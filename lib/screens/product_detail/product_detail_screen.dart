import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:seahorse/app_router/app_router.dart';
import 'package:seahorse/models/network/product_response/product_response.dart';
import 'package:seahorse/screens/product_detail/product_detail_view_model.dart';
import 'package:seahorse/ui_components/add_to_cart_view/add_to_cart_view.dart';
import 'package:seahorse/ui_components/error_dialog/error_dialog.dart';
import 'package:seahorse/ui_components/product_detail_card_view/product_detail_card_view.dart';

class ProductDetailScreen extends ConsumerWidget {
  final ProductResponse product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProductDetailState state = ref.watch(productDetailViewModelProvider);
    ref.listen(productDetailViewModelProvider, (previous, next) {
      if (next.error != null) {
        showErrorDialog(context, error: state.error).then((_) {
          ref.read(productDetailViewModelProvider.notifier).clearError();
        });
      }
      if (next.isAddedToCart) {
        _showAddedToCartDialog(context, state: state);
      }
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              context.pushNamed(RouteName.cart);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ProductDetailCardView(
                viewModel: product.toProductDetailCardViewModel(),
              ),
            ),
          ),
          AddToCartView(
            onAddToCart: () {
              ref
                  .read(productDetailViewModelProvider.notifier)
                  .addToCart(product: product);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showAddedToCartDialog(
    BuildContext context, {
    required ProductDetailState state,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Added to cart"),
          content: Text(
            "${product.title} (quantity: ${state.quantity}) added to cart.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
      barrierDismissible: false,
    );
  }
}
