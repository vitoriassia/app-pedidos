import 'package:flutter/material.dart';
import 'package:pedidos_app/features/orders/view/orders_view.dart';
import 'package:pedidos_app/features/orders/viewmodel/order_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pedidos_app/core/di/inject.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<OrderViewModel>(),
      child: MaterialApp(
        title: 'Pedidos',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: OrdersView(),
      ),
    );
  }
}
