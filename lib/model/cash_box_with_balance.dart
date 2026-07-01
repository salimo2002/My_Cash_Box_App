class CashBoxWithBalance {
  final int id;
  final String name;
  final String currency;
  final double balance;

  CashBoxWithBalance({
    required this.id,
    required this.name,
    required this.currency,
    required this.balance,
  });

  factory CashBoxWithBalance.fromMap(Map<String, dynamic> map) {
    return CashBoxWithBalance(
      id: map['id'] as int,
      name: map['name'] as String,
      currency: map['currency'] as String,
      balance: (map['balance'] as num).toDouble(),
    );
  }

  String get formattedBalance => '${balance.toStringAsFixed(2)} $currency';
}