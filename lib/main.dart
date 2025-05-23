import 'package:flutter/material.dart';
import 'package:pedidos_app/build_config.dart';
import 'package:pedidos_app/features/oauth/view/auth_view.dart';
import 'package:pedidos_app/features/oauth/viewmodel/auth_viewmodel.dart';
import 'package:pedidos_app/features/orders/view/orders_view.dart';
import 'package:pedidos_app/features/orders/viewmodel/order_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pedidos_app/core/di/inject.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  BuildConfig.main();
  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<OrderViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<AuthViewModel>()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'Orders',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        initialRoute: '/auth',
        routes: {'/auth': (_) => const AuthView(), '/orders': (_) => const OrdersView()},
      ),
    );
  }
}
