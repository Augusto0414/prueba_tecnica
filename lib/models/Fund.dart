class Fund {
  final int id;
  final String name;
  final int minimumAmount;
  final String category;

  const Fund({
    required this.id,
    required this.name,
    required this.minimumAmount,
    required this.category,
  });

  factory Fund.fromJson(Map<String, dynamic> json) {
    return Fund(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      minimumAmount: json['minimumAmount'] ?? 0,
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'minimumAmount': minimumAmount,
      'category': category,
    };
  }
}
