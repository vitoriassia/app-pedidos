class OrderModel {
  final String id;
  final DateTime createdAt;
  final String? description;
  final String? customerName;
  final bool finished;

  OrderModel({
    required this.id,
    required this.createdAt,
    this.description,
    this.customerName,
    required this.finished,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String?,
      customerName: json['customerName'] as String?,
      finished: json['finished'] as bool,
    );
  }

  OrderModel copyWith({
    String? id,
    DateTime? createdAt,
    String? description,
    String? customerName,
    bool? finished,
  }) {
    return OrderModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      customerName: customerName ?? this.customerName,
      finished: finished ?? this.finished,
    );
  }
}
