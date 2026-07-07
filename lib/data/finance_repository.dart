import 'package:cash_box/data/app_db.dart';
import 'package:cash_box/model/account_model.dart';
import 'package:cash_box/model/account_with_balance.dart';
import 'package:cash_box/model/cash_box_model.dart';
import 'package:cash_box/model/cash_box_with_balance.dart';
import 'package:cash_box/model/money_transaction_model.dart';
import 'package:cash_box/model/money_transaction_view_model.dart';

class FinanceRepository {
  static final FinanceRepository instance = FinanceRepository._internal();
  FinanceRepository._internal();
  Future<int> createAccount({required AccountModel account}) async {
    final db = await AppDb.instance.database;
    final now = DateTime.now().toIso8601String();

    return db.insert('accounts', account.toJson()..['created_at'] = now);
  }

  Future<List<AccountModel>> getAllAccounts() async {
    final db = await AppDb.instance.database;
    final rows = await db.query('accounts', orderBy: 'id DESC');
    return rows.map((e) => AccountModel.fromJson(e)).toList();
  }

  Future<AccountModel?> getAccountById(int accountId) async {
    final db = await AppDb.instance.database;
    final rows = await db.query(
      'accounts',
      where: 'id = ?',
      whereArgs: [accountId],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return AccountModel.fromJson(rows.first);
  }

  Future<double> getAccountBalance(int accountId) async {
    final db = await AppDb.instance.database;
    final res = await db.rawQuery(
      '''
      SELECT COALESCE(SUM(
        CASE t.type
          WHEN 'payment' THEN t.amount
          WHEN 'receipt' THEN -t.amount
        END
      ), 0) AS balance
      FROM money_transactions t
      WHERE t.account_id = ?
      ''',
      [accountId],
    );

    if (res.isEmpty) return 0.0;
    return (res.first['balance'] as num).toDouble();
  }

  Future<List<AccountWithBalance>> getAccountsWithBalance() async {
    final db = await AppDb.instance.database;
    final res = await db.rawQuery('''
      SELECT
        a.id,
        a.name,
        a.currency,
        a.balance AS stored_balance,
        COALESCE(SUM(
          CASE t.type
            WHEN 'payment' THEN t.amount
            WHEN 'receipt' THEN -t.amount
          END
        ), 0) AS calculated_balance
      FROM accounts a
      LEFT JOIN money_transactions t ON t.account_id = a.id
      GROUP BY a.id
      ORDER BY a.id DESC
    ''');

    return res.map((row) {
      return AccountWithBalance.fromMap(row);
    }).toList();
  }

  Future<int> updateAccount({required int id, required String name}) async {
    final db = await AppDb.instance.database;
    return db.update(
      'accounts',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAccount(int id) async {
    final db = await AppDb.instance.database;
    try {
      return await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      if (e.toString().contains('FOREIGN KEY') ||
          e.toString().contains('foreign key')) {
        throw Exception(
          'لا يمكن حذف هذا الحساب لأنه مرتبط بحركات مالية موجودة',
        );
      }
      rethrow;
    }
  }

  Future<List<AccountModel>> searchAccounts(String query) async {
    final db = await AppDb.instance.database;
    final rows = await db.query(
      'accounts',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'name ASC',
    );
    return rows.map((e) => AccountModel.fromJson(e)).toList();
  }

  Future<int> createCashBox({required CashBoxModel cashBox}) async {
    final db = await AppDb.instance.database;
    final now = DateTime.now().toIso8601String();
    return db.insert('cash_boxes', cashBox.toJson()..['created_at'] = now);
  }

  Future<List<CashBoxModel>> getAllCashBoxes() async {
    final db = await AppDb.instance.database;
    final rows = await db.query('cash_boxes', orderBy: 'id DESC');
    return rows.map((e) => CashBoxModel.fromJson(e)).toList();
  }

  Future<int> deleteCashBox(int id) async {
    final db = await AppDb.instance.database;
    return db.delete('cash_boxes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> addTransaction({
    required MoneyTransactionModel transaction,
  }) async {
    final db = await AppDb.instance.database;
    final now = DateTime.now().toIso8601String();

    final account = await getAccountById(transaction.accountId);
    if (account == null) {
      throw Exception('الحساب غير موجود');
    }
    return db.insert(
      'money_transactions',
      transaction.toJson()..['created_at'] = now,
    );
  }

  Future<List<MoneyTransactionModel>> getCashBoxTransactions(
    int cashBoxId,
  ) async {
    final db = await AppDb.instance.database;
    final rows = await db.query(
      'money_transactions',
      where: 'cash_box_id = ?',
      whereArgs: [cashBoxId],
      orderBy: 'date DESC, created_at DESC',
    );
    return rows.map((e) => MoneyTransactionModel.fromJson(e)).toList();
  }

  Future<List<MoneyTransactionModel>> getAccountTransactions(
    int accountId,
  ) async {
    final db = await AppDb.instance.database;
    final rows = await db.query(
      'money_transactions',
      where: 'account_id = ?',
      whereArgs: [accountId],
      orderBy: 'date DESC, created_at DESC',
    );
    return rows.map((e) => MoneyTransactionModel.fromJson(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getAccountTransactionsWithCashBox(
    int accountId,
  ) async {
    final db = await AppDb.instance.database;
    return db.rawQuery(
      '''
      SELECT
        t.id,
        t.cash_box_id,
        cb.name AS cash_box_name,
        cb.currency AS cash_box_currency,
        t.account_id,
        t.type,
        t.amount,
        t.description,
        t.date,
        t.created_at
      FROM money_transactions t
      LEFT JOIN cash_boxes cb ON cb.id = t.cash_box_id
      WHERE t.account_id = ?
      ORDER BY t.date DESC
    ''',
      [accountId],
    );
  }

  Future<List<MoneyTransactionViewModel>> getCashBoxTransactionsWithAccount(
  int cashBoxId,
) async {
  final db = await AppDb.instance.database;
  final res = await db.rawQuery(
    '''
    SELECT
      t.id,
      t.cash_box_id,
      t.account_id,
      a.name AS account_name,
      a.currency AS account_currency,
      t.type,
      t.amount,
      t.description,
      t.date,
      t.created_at
    FROM money_transactions t
    LEFT JOIN accounts a ON a.id = t.account_id
    WHERE t.cash_box_id = ?
    ORDER BY t.date DESC, t.id DESC
  ''',
    [cashBoxId],
  );

  return res.map((e) {
    return MoneyTransactionViewModel.fromMap(e);
  }).toList();
}

  Future<int> deleteTransaction(int trxId) async {
    final db = await AppDb.instance.database;
    return db.delete('money_transactions', where: 'id = ?', whereArgs: [trxId]);
  }

  Future<double> getCashBoxBalance(int cashBoxId) async {
    final db = await AppDb.instance.database;
    final res = await db.rawQuery(
      '''
      SELECT
        cb.initial_balance
        + COALESCE(SUM(
            CASE t.type
              WHEN 'receipt' THEN t.amount
              WHEN 'payment' THEN -t.amount
            END
          ), 0) AS balance
      FROM cash_boxes cb
      LEFT JOIN money_transactions t ON t.cash_box_id = cb.id
      WHERE cb.id = ?
      GROUP BY cb.id
    ''',
      [cashBoxId],
    );

    if (res.isEmpty) return 0.0;
    return (res.first['balance'] as num).toDouble();
  }

  Future<List<CashBoxWithBalance>> getCashBoxesWithBalance() async {
    final db = await AppDb.instance.database;
    final res = await db.rawQuery('''
    SELECT
      cb.id,
      cb.name,
      cb.currency,
      cb.initial_balance AS initial_balance,

      -- الرصيد بعد الحركات (كما كان سابقاً)
      cb.initial_balance
        + COALESCE(SUM(
            CASE t.type
              WHEN 'receipt' THEN t.amount
              WHEN 'payment' THEN -t.amount
            END
          ), 0) AS balance,

      -- عدد الحركات
      COUNT(t.id) AS transactions_count

    FROM cash_boxes cb
    LEFT JOIN money_transactions t 
      ON t.cash_box_id = cb.id
    GROUP BY cb.id
    ORDER BY cb.id DESC
  ''');

    return res.map((row) => CashBoxWithBalance.fromMap(row)).toList();
  }

  Future<void> createBackup() async {
    await AppDb.instance.exportBackupUserChooseLocation();
  }
}
