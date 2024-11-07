import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:seahorse/ui_components/cart_card_view/cart_card_view_model.dart';

class CartCardView extends StatelessWidget {
  final CartCardViewModel viewModel;
  final Function(int) onQuantityChanged;

  const CartCardView({
    super.key,
    required this.viewModel,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                viewModel.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  viewModel.price,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Spacer(),
                    InputQty(
                      initVal: viewModel.quantity,
                      decoration: const QtyDecorationProps(
                        qtyStyle: QtyStyle.classic,
                        isBordered: false,
                        btnColor: Colors.purple,
                      ),
                      qtyFormProps: QtyFormProps(enableTyping: false),
                      onQtyChanged: (value) {
                        onQuantityChanged(value.toInt());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
