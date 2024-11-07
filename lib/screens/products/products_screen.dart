import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:seahorse/app_router/app_router.dart';
import 'package:seahorse/models/network/product_response/product_response.dart';
import 'package:seahorse/screens/products/products_view_model.dart';
import 'package:seahorse/ui_components/error_dialog/error_dialog.dart';
import 'package:seahorse/ui_components/loading_indicator/loading_indicator.dart';
import 'package:seahorse/ui_components/product_card_view/product_card_view.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.short1, () {
      ref.read(productsViewModelProvider.notifier).getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductsState state = ref.watch(productsViewModelProvider);
    ref.listen(productsViewModelProvider, (previous, next) {
      if (next.error != null) {
        showErrorDialog(context, error: state.error).then((_) {
          ref.read(productsViewModelProvider.notifier).clearError();
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seahorse"),
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
      body: Stack(
        children: [
          _buildProductList(state),
          if (state.isLoading) const LoadingIndicator()
        ],
      ),
    );
  }

  Widget _buildProductList(ProductsState state) {
    return ListView.builder(
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        final product = state.products[index];
        return ProductCardView(
          viewModel: product.toProductCardViewModel(),
          onTap: () {
            context.pushNamed(RouteName.productDetail, extra: product);
          },
        );
      },
    );
  }
}
