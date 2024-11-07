import 'package:seahorse/locator/locator.dart';
import 'package:seahorse/models/network/product_response/product_response.dart';
import 'package:seahorse/network/network_client/network_client.dart';
import 'package:seahorse/services/product/product_service.dart';

class ProductServiceImpl implements ProductService {
  final _networkClient = locator<NetworkClient>();

  @override
  Future<List<ProductResponse>> getProducts() => _networkClient.getProducts();
}
