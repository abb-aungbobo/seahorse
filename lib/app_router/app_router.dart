import 'package:go_router/go_router.dart';
import 'package:seahorse/models/network/product_response/product_response.dart';
import 'package:seahorse/screens/cart/cart_screen.dart';
import 'package:seahorse/screens/product_detail/product_detail_screen.dart';
import 'package:seahorse/screens/products/products_screen.dart';

class RouteName {
  static const products = "products";
  static const productDetail = "product_detail";
  static const cart = "cart";
}

class RoutePath {
  static const products = "/products";
  static const productDetail = "/product_detail";
  static const cart = "/cart";
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      name: RouteName.products,
      path: RoutePath.products,
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      name: RouteName.productDetail,
      path: RoutePath.productDetail,
      builder: (context, state) {
        final product = state.extra as ProductResponse;
        return ProductDetailScreen(product: product);
      },
    ),
    GoRoute(
      name: RouteName.cart,
      path: RoutePath.cart,
      builder: (context, state) => const CartScreen(),
    ),
  ],
  initialLocation: RoutePath.products,
);
