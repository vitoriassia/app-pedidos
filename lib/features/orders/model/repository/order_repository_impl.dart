import 'package:pedidos_app/core/network/api_client.dart';
import 'package:pedidos_app/core/state/ui_state.dart';
import 'package:pedidos_app/features/orders/model/create_order_model.dart';
import 'package:pedidos_app/features/orders/model/order_model.dart';
import 'order_repository.dart';
import 'package:pedidos_app/core/state/repository_handler.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ApiClient _apiService;

  OrderRepositoryImpl(this._apiService);

  @override
  Future<UiState> fetchOrders() {
    return repositoryHandler<List<OrderModel>>(() async {
      final response = await _apiService.get('/orders');

      final dataList = (response.data as List?) ?? [];

      return dataList.map((json) => OrderModel.fromJson(json)).toList();
    });
  }

  @override
  Future<UiState> createOrder(CreateOrderModel createOrder) {
    return repositoryHandler<OrderModel>(() async {
      final response = await _apiService.post('/orders', body: createOrder.toJson());

      return OrderModel.fromJson(response.data);
    });
  }

  @override
  Future<UiState> finalizeOrder(String orderId) {
    return repositoryHandler<void>(() async {
      await _apiService.put('/orders/$orderId/finish');
    });
  }
}
