import 'dart:developer';
import 'dart:io';
import 'package:file_saver/file_saver.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDb {
  AppDb._();
  static final AppDb instance = AppDb._();

  static Database? _db;

  static const String _dbFileName = 'expenses_boxes.db';

  Future<String> get dbPath async {
    final dbDir = await getDatabasesPath();
    return join(dbDir, _dbFileName);
  }

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<void> importDatabaseFromPath(String sourcePath) async {
    final targetPath = await dbPath;

    if (_db != null) {
      await _db!.close();
      _db = null;
    }

    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      throw Exception('ملف قاعدة البيانات غير موجود: $sourcePath');
    }

    await Directory(dirname(targetPath)).create(recursive: true);

    if (normalize(sourceFile.path) == normalize(targetPath)) {
      _db = await _open();
      return;
    }

    final targetFile = File(targetPath);
    if (await targetFile.exists()) {
      await targetFile.delete();
    }

    await sourceFile.copy(targetPath);

    _db = await _open();
  }

  Future<Database> _open() async {
    final path = await dbPath;

    return openDatabase(
      path,
      version: 2,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cash_boxes (
            id              INTEGER PRIMARY KEY AUTOINCREMENT,
            name            TEXT    NOT NULL,
            currency        TEXT    NOT NULL,
            initial_balance REAL    DEFAULT 0,
            created_at      TEXT    NOT NULL
          );
        ''');
        await db.execute('''
          CREATE TABLE accounts (
            id           INTEGER PRIMARY KEY AUTOINCREMENT,
            name         TEXT    NOT NULL,
            currency     TEXT    NOT NULL DEFAULT 'IQD',
            balance      REAL    NOT NULL DEFAULT 0,
            created_at   TEXT    NOT NULL
          );
        ''');
        await db.execute('''
          CREATE TABLE money_transactions (
            id          INTEGER PRIMARY KEY AUTOINCREMENT,
            cash_box_id INTEGER NOT NULL,
            account_id  INTEGER NOT NULL,
            type        TEXT    NOT NULL CHECK (type IN ('payment','receipt')),
            amount      REAL    NOT NULL CHECK (amount > 0),
            description TEXT,
            date        TEXT    NOT NULL,
            created_at  TEXT    NOT NULL,

            FOREIGN KEY (cash_box_id) REFERENCES cash_boxes(id) ON DELETE CASCADE,
            FOREIGN KEY (account_id)  REFERENCES accounts(id)   ON DELETE RESTRICT
          );
        ''');
        await db.execute(
          'CREATE INDEX idx_trx_cash_box_id ON money_transactions(cash_box_id);',
        );
        await db.execute(
          'CREATE INDEX idx_trx_account_id ON money_transactions(account_id);',
        );
        await db.execute(
          'CREATE INDEX idx_trx_date ON money_transactions(date);',
        );
        await db.execute('''
          CREATE TRIGGER trg_after_insert_transaction
          AFTER INSERT ON money_transactions
          BEGIN
            UPDATE accounts
            SET balance = balance + CASE
              WHEN NEW.type = 'payment' THEN  NEW.amount
              WHEN NEW.type = 'receipt' THEN -NEW.amount
            END
            WHERE id = NEW.account_id;
          END;
        ''');
        await db.execute('''
          CREATE TRIGGER trg_after_delete_transaction
          AFTER DELETE ON money_transactions
          BEGIN
            UPDATE accounts
            SET balance = balance + CASE
              WHEN OLD.type = 'payment' THEN -OLD.amount
              WHEN OLD.type = 'receipt' THEN  OLD.amount
            END
            WHERE id = OLD.account_id;
          END;
        ''');
        await db.execute('''
          CREATE TRIGGER trg_after_update_transaction
          AFTER UPDATE ON money_transactions
          BEGIN
            UPDATE accounts
            SET balance = balance + CASE
              WHEN OLD.type = 'payment' THEN -OLD.amount
              WHEN OLD.type = 'receipt' THEN  OLD.amount
            END
            WHERE id = OLD.account_id;

            UPDATE accounts
            SET balance = balance + CASE
              WHEN NEW.type = 'payment' THEN  NEW.amount
              WHEN NEW.type = 'receipt' THEN -NEW.amount
            END
            WHERE id = NEW.account_id;
          END;
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS accounts (
              id           INTEGER PRIMARY KEY AUTOINCREMENT,
              name         TEXT    NOT NULL,
              currency     TEXT    NOT NULL DEFAULT 'IQD',
              balance      REAL    NOT NULL DEFAULT 0,
              created_at   TEXT    NOT NULL
            );
          ''');
          await db.execute('''
            ALTER TABLE money_transactions
            ADD COLUMN account_id INTEGER REFERENCES accounts(id) ON DELETE RESTRICT;
          ''');
          await db.execute(
            'CREATE INDEX IF NOT EXISTS idx_trx_account_id ON money_transactions(account_id);',
          );
          await db.execute('''
            CREATE TRIGGER IF NOT EXISTS trg_after_insert_transaction
            AFTER INSERT ON money_transactions
            WHEN NEW.account_id IS NOT NULL
            BEGIN
              UPDATE accounts
              SET balance = balance + CASE
                WHEN NEW.type = 'payment' THEN  NEW.amount
                WHEN NEW.type = 'receipt' THEN -NEW.amount
              END
              WHERE id = NEW.account_id;
            END;
          ''');
          await db.execute('''
            CREATE TRIGGER IF NOT EXISTS trg_after_delete_transaction
            AFTER DELETE ON money_transactions
            WHEN OLD.account_id IS NOT NULL
            BEGIN
              UPDATE accounts
              SET balance = balance + CASE
                WHEN OLD.type = 'payment' THEN -OLD.amount
                WHEN OLD.type = 'receipt' THEN  OLD.amount
              END
              WHERE id = OLD.account_id;
            END;
          ''');
          await db.execute('''
            CREATE TRIGGER IF NOT EXISTS trg_after_update_transaction
            AFTER UPDATE ON money_transactions
            BEGIN
              UPDATE accounts
              SET balance = balance + CASE
                WHEN OLD.type = 'payment' THEN -OLD.amount
                WHEN OLD.type = 'receipt' THEN  OLD.amount
              END
              WHERE id = OLD.account_id AND OLD.account_id IS NOT NULL;

              UPDATE accounts
              SET balance = balance + CASE
                WHEN NEW.type = 'payment' THEN  NEW.amount
                WHEN NEW.type = 'receipt' THEN -NEW.amount
              END
              WHERE id = NEW.account_id AND NEW.account_id IS NOT NULL;
            END;
          ''');
        }
      },
    );
  }

  Future<String?> exportBackupUserChooseLocation() async {
    await database;
    final originalPath = await dbPath;

    final ts = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('.', '-');

    final bytes = await File(originalPath).readAsBytes();

    final savedPathOrUri = await FileSaver.instance.saveAs(
      fileExtension: 'db',
      name: 'expenses_boxes_backup_$ts',
      bytes: bytes,
      mimeType: MimeType.other,
    );

    log('Backup exported to: $savedPathOrUri');
    return savedPathOrUri;
  }
}
