import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seahorse/locator/locator.dart';
import 'package:seahorse/models/network/product_response/product_response.dart';
import 'package:seahorse/services/cart/cart_service.dart';

part 'product_detail_view_model.g.dart';

@riverpod
class ProductDetailViewModel extends _$ProductDetailViewModel {
  final _cartService = locator<CartService>();

  @override
  ProductDetailState build() {
    return ProductDetailState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void setQuantity(int value) {
    state = state.copyWith(quantity: value);
  }

  void addToCart({required ProductResponse product}) async {
    try {
      final productEntity = product.toProductEntity(state.quantity);
      await _cartService.addProduct(productEntity: productEntity);
      state = state.copyWith(isAddedToCart: true);
    } catch (e) {
      state = state.copyWith(error: e);
    }
  }
}

class ProductDetailState {
  final Object? error;
  final int quantity;
  final bool isAddedToCart;

  bool get isAddToCartButtonEnabled => quantity != 0;

  ProductDetailState({
    this.error,
    this.quantity = 0,
    this.isAddedToCart = false,
  });

  ProductDetailState copyWith({
    Object? error,
    int? quantity,
    bool? isAddedToCart,
  }) {
    return ProductDetailState(
      error: error,
      quantity: quantity ?? this.quantity,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
    );
  }
}
