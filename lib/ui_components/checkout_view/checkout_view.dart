import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seahorse/screens/cart/cart_view_model.dart';

class CheckoutView extends ConsumerWidget {
  final Function() onCheckout;

  const CheckoutView({
    super.key,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CartState state = ref.watch(cartViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            children: [
              Text(
                "Total",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                state.formattedTotalPrice,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ElevatedButton(
            onPressed: state.isCheckoutButtonEnabled ? onCheckout : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: const Size(double.infinity, 40),
            ),
            child: const Text("Checkout"),
          ),
        ),
      ],
    );
  }
}
