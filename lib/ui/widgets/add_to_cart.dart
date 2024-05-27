import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/analytics/analytics_helper.dart';
import 'package:shoesly/main.dart';
import 'package:shoesly/model/order_detail.dart';
import 'package:shoesly/riverpod/provider.dart';
import 'package:shoesly/ui/widgets/btm_sheet.dart';
import 'package:shoesly/ui/widgets/primary_button.dart';

class AddToCartBottomSheet extends ConsumerStatefulWidget {
  OrderDetail orderDetail;

  AddToCartBottomSheet(this.orderDetail, {super.key});

  @override
  _AddToCartBottomSheetState createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends ConsumerState<AddToCartBottomSheet> {
  int quantity = 1;
  double pricePerItem = 0; // example price per item
  double totalPrice = 0;

  @override
  void initState() {
    pricePerItem = widget.orderDetail.price;
    totalPrice = pricePerItem * quantity;
    super.initState();
  }

  void updateState(bool shouldIncrease) {
    setState(() {
      shouldIncrease ? quantity++ : ((quantity > 1) ? quantity-- : quantity);
      totalPrice = quantity * pricePerItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.read(cartStateProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    onClickEvent(ref, ContentType.icon, "Close");
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: $style.insets.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Quantity:',
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        color: quantity > 1 ? Colors.black : Colors.grey,
                        onPressed: () {
                          onClickEvent(
                              ref, ContentType.icon, "Decrease quantity");
                          updateState(false);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          onClickEvent(
                              ref, ContentType.icon, "Increase quantity");
                          updateState(true);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Total Price:',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      textAlign: TextAlign.start,
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                PrimaryButton(
                  onPressed: () {
                    widget.orderDetail.quantity = quantity;
                    cartNotifier.addItem(widget.orderDetail);
                    onClickEvent(ref, ContentType.primaryButton, "Add to Cart");
                    ref.read(btmSheetStateProvider.notifier).state = true;
                  },
                  title: 'Add to Cart',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
