class CashBoxWithBalance {
  final int id;
  final String name;
  final String currency;
  final double initialBalance;
  final double balance;
  final int transactionsCount;

  CashBoxWithBalance({
    required this.id,
    required this.name,
    required this.currency,
    required this.initialBalance,
    required this.balance,
    required this.transactionsCount,
  });

  factory CashBoxWithBalance.fromMap(Map<String, dynamic> map) {
    return CashBoxWithBalance(
      id: map['id'] as int,
      name: map['name'] as String,
      currency: map['currency'] as String,
      initialBalance: (map['initial_balance'] as num).toDouble(),
      balance: (map['balance'] as num).toDouble(),
      transactionsCount: (map['transactions_count'] ?? 0) as int,
    );
  }
}