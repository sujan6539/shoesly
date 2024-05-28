import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shoesly/main.dart';
import 'package:shoesly/model/product.dart';
import 'package:shoesly/riverpod/reviews/review_notifier.dart';

class ItemCard extends ConsumerWidget {
  Product product;

  ItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var reviewRef = ref.watch(reviewAvgProvider(product.slug));
    int reviewCountRef = ref.watch(reviewCountProvider(product.slug));

    return GestureDetector(
      onTap: () {
        context.push('/product_detail/${product.slug}', extra: product);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: CircularProgressIndicator(),
                      ),
                      product.imageURL,
                      // Replace with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  top: 8,
                  left: 8,
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: $style.insets.xs),
            Text(
              product.name,
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: $style.insets.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                SizedBox(width: $style.insets.xxs),
                Text(
                  '$reviewRef',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 12),
                ),
                SizedBox(width: $style.insets.xxs),
                Text(
                  '($reviewCountRef Reviews)',
                  style: const TextStyle(fontSize: 8, color: Colors.grey),
                ),
              ],
            ),
            Text(
              '\$${product.price.toString()}',
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
