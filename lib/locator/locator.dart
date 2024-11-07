import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:seahorse/database/database_client.dart';
import 'package:seahorse/network/network_client/network_client.dart';
import 'package:seahorse/services/cart/cart_service.dart';
import 'package:seahorse/services/cart/cart_service_impl.dart';
import 'package:seahorse/services/product/product_service.dart';
import 'package:seahorse/services/product/product_service_impl.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  _registerNetworkClient();
  _registerDatabaseClient();
  _registerServices();
}

void _registerNetworkClient() {
  final Dio dio = Dio();
  locator.registerLazySingleton<NetworkClient>(() => NetworkClient(dio));
}

void _registerDatabaseClient() {
  locator.registerLazySingleton<DatabaseClient>(() => DatabaseClient());
}

void _registerServices() {
  locator.registerFactory<ProductService>(() => ProductServiceImpl());
  locator.registerFactory<CartService>(() => CartServiceImpl());
}
