import 'package:flutter/material.dart';
import 'package:pedidos_app/features/orders/model/order_model.dart';

class ListOrdersWidget extends StatelessWidget {
  final List<OrderModel> orders;
  final Function(String orderId) onFinishPressed;
  const ListOrdersWidget({super.key, required this.orders, required this.onFinishPressed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, index) {
        final pedido = orders[index];
        return ListTile(
          title: Text(pedido.description ?? 'Sem descrição'),
          subtitle: Text('Cliente: ${pedido.customerName ?? 'N/A'}'),
          trailing:
              pedido.finished
                  ? Chip(
                    avatar: const Icon(Icons.check, size: 16, color: Colors.white),
                    label: const Text('Completed', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                  )
                  : ElevatedButton.icon(
                    onPressed: () => onFinishPressed(pedido.id),
                    icon: const Icon(Icons.done),
                    label: const Text('Complete'),
                  ),
        );
      },
    );
  }
}
