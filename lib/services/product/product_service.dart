import 'package:seahorse/models/network/product_response/product_response.dart';

abstract class ProductService {
  Future<List<ProductResponse>> getProducts();
}
