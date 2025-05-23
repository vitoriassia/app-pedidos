import 'package:flutter/material.dart';
import 'package:pedidos_app/features/orders/model/create_order_model.dart';
import 'package:pedidos_app/features/orders/model/order_model.dart';
import '../../../core/state/ui_state.dart';
import '../model/repository/order_repository.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _repository;

  UiState _uiState = InitialState();

  void _setUiState(UiState value) {
    _uiState = value;
    notifyListeners();
  }

  UiState get uiState => _uiState;

  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  OrderViewModel(this._repository);

  Future<void> getOrders() async {
    _setUiState(LoadingState());

    final result = await _repository.fetchOrders();

    if (result is SuccessState<List<OrderModel>>) {
      _orders = result.data;
    }

    _uiState = result;

    notifyListeners();
  }

  Future<UiState> createOrder(CreateOrderModel order) async {
    final result = await _repository.createOrder(order);

    if (result is SuccessState<OrderModel>) {
      _orders.insert(0, result.data);
    }

    _setUiState(SuccessState(_orders));

    notifyListeners();
    return result;
  }

  Future<UiState> finalizeOrder(String orderId) async {
    _setUiState(LoadingState());
    final result = await _repository.finalizeOrder(orderId);

    if (result is SuccessState) {
      final index = _orders.indexWhere((o) => o.id == orderId);

      if (index != -1) {
        final updated = _orders[index].copyWith(finished: true);
        _orders[index] = updated;
      }
    }

    _setUiState(SuccessState(_orders));
    notifyListeners();
    return result;
  }
}
