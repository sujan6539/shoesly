import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesly/analytics/analytics_helper.dart';
import 'package:shoesly/main.dart';
import 'package:shoesly/ui/widgets/primary_button.dart';
import 'package:shoesly/ui/widgets/secondary_button.dart';

class AddedToCartBottomSheet extends ConsumerStatefulWidget {
  int itemCount;

  AddedToCartBottomSheet({super.key, required this.itemCount});

  @override
  ConsumerState<AddedToCartBottomSheet> createState() =>
      _AddedToCartBottomSheetState();
}

class _AddedToCartBottomSheetState
    extends ConsumerState<AddedToCartBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                height: 120,
                child: Lottie.asset('assets/checkedOut.json', repeat: false)),
            SizedBox(height: $style.insets.sm),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Added to cart',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: $style.insets.sm,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SecondaryButton(
                  onPressed: () {
                    onClickEvent(
                        ref, ContentType.secondaryButton, "Back Explore");
                    Navigator.pop(context);
                  },
                  title: 'Back Explore',
                ),
                PrimaryButton(
                  onPressed: () {
                    onClickEvent(ref, ContentType.primaryButton, "to Cart");
                    context.pushReplacement('/cart');
                  },
                  title: 'to Cart',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
