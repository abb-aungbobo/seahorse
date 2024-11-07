import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:seahorse/configuration/environment.dart';
import 'package:seahorse/models/network/product_response/product_response.dart';
import 'package:seahorse/network/endpoint/products_endpoint.dart';

part 'network_client.g.dart';

@RestApi(baseUrl: Environment.apiBaseUrl)
abstract class NetworkClient {
  factory NetworkClient(Dio dio) = _NetworkClient;

  @GET(ProductsEndpoint.products)
  Future<List<ProductResponse>> getProducts();
}
