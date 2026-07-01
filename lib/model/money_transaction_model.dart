class MoneyTransactionModel {
  final int? id;
  final int cashBoxId;
  final int accountId;
  final String type;
  final double amount;
  final String description;
  final String date;
  final String createdAt;

  MoneyTransactionModel({
     this.id,
    required this.cashBoxId,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
    required this.createdAt,
  });

  factory MoneyTransactionModel.fromJson(Map<String, dynamic> json) {
    return MoneyTransactionModel(
      id: json['id'] as int?,
      cashBoxId: json['cash_box_id'] as int,
      accountId: json['account_id'] as int,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      date: json['date'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cash_box_id': cashBoxId,
      'account_id': accountId,
      'type': type,
      'amount': amount,
      'description': description,
      'date': date,
      'created_at': createdAt,
    };
  }

  bool get isPayment => type == 'payment';
  bool get isReceipt => type == 'receipt';
}
