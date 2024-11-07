import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:seahorse/screens/product_detail/product_detail_view_model.dart';

class AddToCartView extends ConsumerWidget {
  final Function() onAddToCart;

  const AddToCartView({
    super.key,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProductDetailState state = ref.watch(productDetailViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
          child: InputQty(
            initVal: state.quantity,
            decoration: const QtyDecorationProps(
              qtyStyle: QtyStyle.classic,
              isBordered: false,
              btnColor: Colors.purple,
            ),
            qtyFormProps: QtyFormProps(enableTyping: false),
            onQtyChanged: (value) {
              ref
                  .read(productDetailViewModelProvider.notifier)
                  .setQuantity(value.toInt());
            },
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ElevatedButton(
            onPressed: state.isAddToCartButtonEnabled ? onAddToCart : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: const Size(double.infinity, 40),
            ),
            child: const Text("Add to cart"),
          ),
        )
      ],
    );
  }
}
