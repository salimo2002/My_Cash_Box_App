class AccountModel {
  final int id;
  final String name;
  final String currency;
  final double balance;
  final String createdAt;

  AccountModel({
    required this.id,
    required this.name,
    required this.currency,
    this.balance = 0,
    required this.createdAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as int,
      name: json['name'] as String,
      currency: json['currency'] as String,
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'currency': currency,
      'balance': balance,
      'created_at': createdAt,
    };
  }
}
