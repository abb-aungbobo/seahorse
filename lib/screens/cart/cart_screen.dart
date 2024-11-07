import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:seahorse/models/database/product_entity/product_entity.dart';
import 'package:seahorse/screens/cart/cart_view_model.dart';
import 'package:seahorse/ui_components/cart_card_view/cart_card_view.dart';
import 'package:seahorse/ui_components/checkout_view/checkout_view.dart';
import 'package:seahorse/ui_components/error_dialog/error_dialog.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.short1, () {
      ref.read(cartViewModelProvider.notifier).getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final CartState state = ref.watch(cartViewModelProvider);
    ref.listen(cartViewModelProvider, (previous, next) {
      if (state.error != null) {
        showErrorDialog(context, error: state.error).then((_) {
          ref.read(cartViewModelProvider.notifier).clearError();
        });
      }
    });
    return Scaffold(
      appBar: AppBar(),
      body: state.products.isEmpty ? _buildEmpty() : _buildList(state),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 4),
          Text("Your cart is empty"),
        ],
      ),
    );
  }

  Widget _buildList(CartState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Dismissible(
                key: Key(product.id.toString()),
                child: CartCardView(
                  viewModel: product.toCartCardViewModel(),
                  onQuantityChanged: (value) {
                    ref
                        .read(cartViewModelProvider.notifier)
                        .updateProduct(quantity: value, productEntity: product);
                  },
                ),
                onDismissed: (direction) {
                  ref
                      .read(cartViewModelProvider.notifier)
                      .deleteProduct(productEntity: product);
                },
              );
            },
          ),
        ),
        CheckoutView(
          onCheckout: () {
            _showOrderSuccessfulDialog(context);
          },
        ),
      ],
    );
  }

  Future<void> _showOrderSuccessfulDialog(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Order successful"),
          content: const Text("Thank you so much for your order."),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(cartViewModelProvider.notifier).delete();
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
