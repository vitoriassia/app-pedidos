class CreateOrderModel {
  final String description;
  final String customerName;

  CreateOrderModel({required this.description, required this.customerName});

  Map<String, dynamic> toJson() {
    return {'description': description, 'customerName': customerName};
  }
}
