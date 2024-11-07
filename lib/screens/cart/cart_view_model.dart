import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seahorse/locator/locator.dart';
import 'package:seahorse/models/database/product_entity/product_entity.dart';
import 'package:seahorse/services/cart/cart_service.dart';
import 'package:seahorse/utilities/currency_formatter/currency_formatter.dart';

part 'cart_view_model.g.dart';

@riverpod
class CartViewModel extends _$CartViewModel {
  final _cartService = locator<CartService>();

  @override
  CartState build() {
    return CartState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void getProducts() {
    try {
      final products = _cartService.getProducts();
      double totalPrice = products
          .map((product) => product.totalPrice)
          .fold(0, (sum, price) => sum + price);
      state = state.copyWith(
        totalPrice: totalPrice,
        products: products,
      );
    } catch (e) {
      state = state.copyWith(error: e);
    }
  }

  void updateProduct({
    required int quantity,
    required ProductEntity productEntity,
  }) async {
    try {
      await _cartService.updateProduct(
        quantity: quantity,
        productEntity: productEntity,
      );
      getProducts();
    } catch (e) {
      state = state.copyWith(error: e);
    }
  }

  void deleteProduct({required ProductEntity productEntity}) async {
    try {
      await _cartService.deleteProduct(productEntity: productEntity);
      getProducts();
    } catch (e) {
      state = state.copyWith(error: e);
    }
  }

  void delete() async {
    try {
      await _cartService.delete();
      getProducts();
    } catch (e) {
      state = state.copyWith(error: e);
    }
  }
}

class CartState {
  final Object? error;
  final double totalPrice;
  final List<ProductEntity> products;

  String get formattedTotalPrice => currencyFormatter.format(totalPrice);

  bool get isCheckoutButtonEnabled => totalPrice != 0.0;

  CartState({
    this.error,
    this.totalPrice = 0.0,
    this.products = const [],
  });

  CartState copyWith({
    Object? error,
    double? totalPrice,
    List<ProductEntity>? products,
  }) {
    return CartState(
      error: error,
      totalPrice: totalPrice ?? this.totalPrice,
      products: products ?? this.products,
    );
  }
}
