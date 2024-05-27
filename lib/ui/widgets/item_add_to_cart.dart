import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/model/order_detail.dart';
import 'package:shoesly/ui/widgets/btm_sheet.dart';
import "package:shoesly/ui/widgets/primary_button.dart";

class ItemAddToCart extends ConsumerWidget {
  OrderDetail orderDetail;

  ItemAddToCart(this.orderDetail, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 80,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Price", style: Theme.of(context).textTheme.labelSmall),
              Text("\$${orderDetail.price}",
                  style: Theme.of(context).textTheme.titleMedium)
            ]),
            Builder(builder: (context) {
              return PrimaryButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return CustomBottomSheet(orderDetail);
                    },
                  ).whenComplete(() {
                    ref.read(btmSheetStateProvider.notifier).state = false;
                  });
                },
                title: 'Add to cart',
              );
            })
          ],
        ),
      ),
    );
  }
}
