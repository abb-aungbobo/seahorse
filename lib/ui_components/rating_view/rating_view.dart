import 'package:flutter/material.dart';

class RatingView extends StatelessWidget {
  final String rate;

  const RatingView({
    super.key,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          size: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 4),
        Text(
          rate,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
