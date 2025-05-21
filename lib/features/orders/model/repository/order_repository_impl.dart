import 'package:pedidos_app/core/state/ui_state.dart';
import 'package:pedidos_app/features/orders/model/create_order_model.dart';
import 'package:pedidos_app/features/orders/model/order_model.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<UiState> fetchOrders() async {
    await Future.delayed(const Duration(seconds: 1));

    final mockPedidos = List.generate(3, (index) {
      return OrderModel(
        id: 'id-$index',
        createdAt: DateTime.now().subtract(Duration(days: index)),
        description: 'Pedido de teste $index',
        customerName: 'Cliente $index',
        finished: index % 2 == 0,
      );
    });

    return SuccessState(mockPedidos);
  }

  @override
  Future<UiState> createOrder(CreateOrderModel createOrder) async {
    await Future.delayed(const Duration(seconds: 1));

    OrderModel order = OrderModel(
      id: 'id-${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
      description: createOrder.description,
      customerName: createOrder.customerName,
      finished: false,
    );
    return SuccessState(order);
  }

  @override
  Future<UiState> finalizeOrder(String orderId) async {
    await Future.delayed(const Duration(seconds: 1));
    return SuccessState(null);
  }
}
