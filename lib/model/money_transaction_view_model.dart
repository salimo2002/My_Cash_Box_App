class MoneyTransactionViewModel {
  final int id;
  final int cashBoxId;
  final int accountId;
  final String accountName;
  final String accountCurrency;
  final String type;
  final double amount;
  final String? description;
  final String date;
  final String createdAt;

  const MoneyTransactionViewModel({
    required this.id,
    required this.cashBoxId,
    required this.accountId,
    required this.accountName,
    required this.accountCurrency,
    required this.type,
    required this.amount,
    this.description,
    required this.date,
    required this.createdAt,
  });

  factory MoneyTransactionViewModel.fromMap(Map<String, dynamic> map) {
    return MoneyTransactionViewModel(
      id: map['id'],
      cashBoxId: map['cash_box_id'],
      accountId: map['account_id'],
      accountName: map['account_name'],
      accountCurrency: map['account_currency'],
      type: map['type'],
      amount: (map['amount'] as num).toDouble(),
      description: map['description'],
      date: map['date'],
      createdAt: map['created_at'],
    );
  }
}
