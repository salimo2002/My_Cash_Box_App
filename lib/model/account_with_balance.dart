class AccountWithBalance {
  final int id;
  final String name;
  final String currency;
  final double storedBalance;
  final double calculatedBalance;

  const AccountWithBalance({
    required this.id,
    required this.name,
    required this.currency,
    required this.storedBalance,
    required this.calculatedBalance,
  });

  factory AccountWithBalance.fromMap(Map<String, dynamic> map) {
    return AccountWithBalance(
      id: map['id'],
      name: map['name'],
      currency: map['currency'],
      storedBalance: (map['stored_balance'] as num).toDouble(),
      calculatedBalance: (map['calculated_balance'] as num).toDouble(),
    );
  }
}
