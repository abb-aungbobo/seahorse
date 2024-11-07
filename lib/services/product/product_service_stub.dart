import 'package:seahorse/models/network/product_response/product_response.dart';
import 'package:seahorse/services/product/product_service.dart';
import 'package:seahorse/utilities/json/json.dart';

class ProductServiceStub implements ProductService {
  @override
  Future<List<ProductResponse>> getProducts() async {
    List<ProductResponse> response = await JSON.decode("products");
    return response;
  }
}
