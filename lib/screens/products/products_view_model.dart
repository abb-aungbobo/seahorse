import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:seahorse/locator/locator.dart';
import 'package:seahorse/models/network/product_response/product_response.dart';
import 'package:seahorse/services/product/product_service.dart';

part 'products_view_model.g.dart';

@riverpod
class ProductsViewModel extends _$ProductsViewModel {
  final _productService = locator<ProductService>();

  @override
  ProductsState build() {
    return ProductsState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void getProducts() async {
    state = state.copyWith(isLoading: true);
    try {
      final products = await _productService.getProducts();
      state = state.copyWith(isLoading: false, products: products);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }
}

class ProductsState {
  final bool isLoading;
  final Object? error;
  final List<ProductResponse> products;

  ProductsState({
    this.isLoading = false,
    this.error,
    this.products = const [],
  });

  ProductsState copyWith({
    bool? isLoading,
    Object? error,
    List<ProductResponse>? products,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      products: products ?? this.products,
    );
  }
}
