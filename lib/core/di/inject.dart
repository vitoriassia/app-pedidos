import 'package:get_it/get_it.dart';
import 'package:pedidos_app/features/orders/model/repository/order_repository.dart';
import 'package:pedidos_app/features/orders/model/repository/order_repository_impl.dart';
import 'package:pedidos_app/features/orders/viewmodel/order_viewmodel.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Repository
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());

  // ViewModel
  getIt.registerFactory(() => OrderViewModel(getIt()));
}
