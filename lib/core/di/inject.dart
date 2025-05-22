import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pedidos_app/build_config.dart';
import 'package:pedidos_app/core/network/dio_client.dart';
import 'package:pedidos_app/core/network/interceptors/auth_interceptor.dart';
import 'package:pedidos_app/core/storage/secure_storage/flutter_secure_storage_adapter.dart';
import 'package:pedidos_app/core/storage/secure_storage/secure_storage.dart';
import 'package:pedidos_app/core/storage/token_storage.dart';
import 'package:pedidos_app/features/orders/model/repository/order_repository.dart';
import 'package:pedidos_app/features/orders/model/repository/order_repository_impl.dart';
import 'package:pedidos_app/features/orders/viewmodel/order_viewmodel.dart';
import '../../features/oauth/model/repository/oauth_repository.dart';
import '../../features/oauth/model/repository/oauth_repository_impl.dart';
import '../../features/oauth/viewmodel/auth_viewmodel.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Storage
  getIt.registerLazySingleton<SecureStorage>(() => FlutterSecureStorageAdapter());
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(getIt<SecureStorage>()));
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: BuildConfig.instance.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
      ),
    ),
  );

  // API
  getIt.registerLazySingleton<DioHttpClient>(() => DioHttpClient(dio: getIt()));

  // Repository
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl());
  getIt.registerLazySingleton<OAuthRepository>(
    () => OAuthRepositoryImpl(getIt<DioHttpClient>(), getIt<TokenStorage>()),
  );

  // ViewModel
  getIt.registerFactory(() => OrderViewModel(getIt()));
  getIt.registerFactory(() => AuthViewModel(repository: getIt()));
}

void addAuthInterceptor() {
  getIt<DioHttpClient>().addInterceptor(
    AuthInterceptor(getIt<TokenStorage>(), getIt<OAuthRepository>(), getIt<Dio>()),
  );
}
