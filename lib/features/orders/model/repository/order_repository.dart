import 'package:pedidos_app/core/state/ui_state.dart';
import 'package:pedidos_app/features/orders/model/create_order_model.dart';

abstract class OrderRepository {
  Future<UiState> fetchOrders();

  Future<UiState> createOrder(CreateOrderModel order);

  Future<UiState> finalizeOrder(String orderId);
}
