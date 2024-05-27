import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoesly/main.dart';
import 'package:shoesly/model/order_detail.dart';
import 'package:shoesly/riverpod/cart/cart_notifier.dart';
import 'package:shoesly/riverpod/provider.dart';

class ItemCartProduct extends ConsumerStatefulWidget {
  OrderDetail orderDetail;

  ItemCartProduct(
    this.orderDetail, {
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ItemCartProduct> createState() => _ItemCartProductState();
}

class _ItemCartProductState extends ConsumerState<ItemCartProduct> {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.read(cartStateProvider.notifier);

    var orderDetail = widget.orderDetail;
    return Dismissible(
      key: Key(orderDetail.shoeIdentifier),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          cartNotifier.removeItem(orderDetail.shoeIdentifier);
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${orderDetail.name} removed.'),
          duration: const Duration(milliseconds: 600),
        ));
      },
      background: Container(
        color: Colors.red,
        child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: FaIcon(FontAwesomeIcons.trash),
            )),
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                      width: 80,
                      child: Center(child: CircularProgressIndicator())),
                  orderDetail.imageURL,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: $style.insets.xs),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderDetail.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: $style.insets.xxs),
                    Text(
                      '${orderDetail.brand} . ${orderDetail.color} . ${orderDetail.size}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: $style.insets.xxs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${orderDetail.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              color: orderDetail.quantity > 1
                                  ? Colors.black
                                  : Colors.grey,
                              onPressed: () {
                                _updateQuantity(false, cartNotifier);
                              },
                            ),
                            Text(
                              '${orderDetail.quantity}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                _updateQuantity(true, cartNotifier);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: $style.insets.xs),
              // Quantity Controls
            ],
          ),
        ),
      ),
    );
  }

  _updateQuantity(bool shouldIncrease, CartNotifier cartNotifier) {
    setState(() {
      if (shouldIncrease) {
        widget.orderDetail.quantity += 1;
      } else {
        if (widget.orderDetail.quantity > 1) {
          widget.orderDetail.quantity -= 1;
        }
      }
    });
    cartNotifier.addItem(widget.orderDetail);
  }
}
