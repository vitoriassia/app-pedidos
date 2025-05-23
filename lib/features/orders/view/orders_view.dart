import 'package:flutter/material.dart';
import 'package:pedidos_app/core/helpers/snackbar_helper.dart';
import 'package:pedidos_app/features/orders/view/widgets/list_orders_widget.dart';
import 'package:pedidos_app/shared/widgets/ui_state_builder.dart';
import 'package:provider/provider.dart';
import 'package:pedidos_app/features/orders/viewmodel/order_viewmodel.dart';
import '../../../core/state/ui_state.dart';
import '../model/order_model.dart';
import '../view/create_order_view.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  late final OrderViewModel _viewModel;

  @override
  void initState() {
    _viewModel = context.read();

    super.initState();
    Future.microtask(() => _getOrders());
  }

  Future<void> _getOrders() => _viewModel.getOrders();

  Future<void> _finalizeOrder(String orderId) async {
    final result = await _viewModel.finalizeOrder(orderId);
    if (result is SuccessState) {
      SnackbarHelper.showSuccess('Order finalized successfully');
    } else if (result is FailureState) {
      final message = result.message;
      SnackbarHelper.showError(message);
    }

    await _getOrders();
  }

  void _onPressedAdd() {
    showDialog(context: context, builder: _buildCreateOrder);
  }

  Widget _buildCreateOrder(BuildContext _) => Dialog(
    child: SizedBox(
      width: 400,
      child: CreateOrderView(onSubmitForm: (order) => _viewModel.createOrder(order)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: Selector<OrderViewModel, UiState>(
        selector: (_, viewModel) => viewModel.uiState,
        builder: (context, state, _) {
          return UiStateBuilder<List<OrderModel>>(
            state: state,
            onSuccess: (orders) {
              if (_viewModel.orders.isEmpty) {
                return const Center(child: Text('No orders found'));
              }

              return ListOrdersWidget(
                orders: _viewModel.orders,
                onFinishPressed: _finalizeOrder,
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'refresh',
            onPressed: _getOrders,
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'create',
            onPressed: _onPressedAdd,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
