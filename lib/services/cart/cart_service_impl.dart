import 'package:seahorse/core/app_error/app_error.dart';
import 'package:seahorse/database/database_client.dart';
import 'package:seahorse/locator/locator.dart';
import 'package:seahorse/models/database/cart_entity/cart_entity.dart';
import 'package:seahorse/models/database/product_entity/product_entity.dart';
import 'package:seahorse/services/cart/cart_service.dart';

class CartServiceImpl implements CartService {
  final _databaseClient = locator<DatabaseClient>();

  @override
  Future<ProductEntity> addProduct({
    required ProductEntity productEntity,
  }) async {
    final CartEntity? cartEntity = _databaseClient.find(1);
    if (cartEntity == null) {
      final cartEntity = CartEntity(1);
      cartEntity.products.add(productEntity);
      await _databaseClient.add(cartEntity);
      return productEntity;
    } else {
      try {
        final entity = cartEntity.products
            .firstWhere((entity) => entity.id == productEntity.id);
        await _databaseClient.update(() {
          entity.quantity = entity.quantity + productEntity.quantity;
        });
        return entity;
      } catch (e) {
        await _databaseClient.update(() {
          cartEntity.products.add(productEntity);
        });
        return productEntity;
      }
    }
  }

  @override
  List<ProductEntity> getProducts() {
    final CartEntity? cartEntity = _databaseClient.find(1);
    if (cartEntity == null) {
      return [];
    } else {
      return cartEntity.products.toList();
    }
  }

  @override
  Future<ProductEntity> updateProduct({
    required int quantity,
    required ProductEntity productEntity,
  }) async {
    final CartEntity? cartEntity = _databaseClient.find(1);
    if (cartEntity == null) {
      throw Exception(AppError.generic);
    } else {
      final entity = cartEntity.products
          .firstWhere((entity) => entity.id == productEntity.id);
      await _databaseClient.update(() {
        entity.quantity = quantity;
      });
      return entity;
    }
  }

  @override
  Future<void> deleteProduct({
    required ProductEntity productEntity,
  }) async {
    await _databaseClient.delete(productEntity);
  }

  @override
  Future<void> delete() async {
    final CartEntity? cartEntity = _databaseClient.find(1);
    if (cartEntity == null) {
      throw Exception(AppError.generic);
    } else {
      await Future.wait([
        for (final product in cartEntity.products)
          _databaseClient.delete(product),
        _databaseClient.delete(cartEntity),
      ]);
    }
  }
}
