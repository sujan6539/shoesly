import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/analytics/analytics_helper.dart';
import 'package:shoesly/main.dart';
import 'package:shoesly/ui/widgets/primary_button.dart';

class CartCta extends ConsumerWidget {
  double grandTotal;
  String ctaTitle;
  VoidCallback onPressed;

  CartCta(this.grandTotal,
      {super.key, required this.ctaTitle, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: $style.insets.offset,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Grand Total",
                      style: Theme.of(context).textTheme.labelSmall),
                  Text("\$$grandTotal",
                      style: Theme.of(context).textTheme.titleMedium)
                ]),
            PrimaryButton(
              enabled: grandTotal != 0.0,
              onPressed: () {
                onClickEvent(ref, ContentType.primaryButton, ctaTitle);
                onPressed();
              },
              title: ctaTitle,
            )
          ],
        ),
      ),
    );
  }
}
