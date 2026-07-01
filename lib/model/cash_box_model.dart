class CashBoxModel {
  final int? id;
  final String name;
  final String currency;
  final double initialBalance;
  final String createdAt;

  CashBoxModel({
    this.id,
    required this.name,
    required this.currency,
    required this.initialBalance,
    required this.createdAt,
  });

  factory CashBoxModel.fromJson(Map<String, dynamic> json) {
    return CashBoxModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      currency: json['currency'] as String,
      initialBalance: (json['initial_balance'] as num).toDouble(),
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'currency': currency,
      'initial_balance': initialBalance,
      'created_at': createdAt,
    };
  }
}
