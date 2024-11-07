import 'package:seahorse/models/database/product_entity/product_entity.dart';

abstract class CartService {
  Future<ProductEntity> addProduct({
    required ProductEntity productEntity,
  });
  List<ProductEntity> getProducts();
  Future<ProductEntity> updateProduct({
    required int quantity,
    required ProductEntity productEntity,
  });
  Future<void> deleteProduct({
    required ProductEntity productEntity,
  });
  Future<void> delete();
}
