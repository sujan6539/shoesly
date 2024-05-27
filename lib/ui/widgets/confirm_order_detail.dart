import 'package:flutter/material.dart';
import 'package:shoesly/main.dart';
import 'package:shoesly/model/order_detail.dart';

class OrderDetailList extends StatelessWidget {
  List<OrderDetail> orders;

  OrderDetailList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    double sum = 0;
    for (var o in orders) {
      sum += o.price * o.quantity;
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const Text(
              'Order Detail',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      order.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${order.brand} .${order.color} . ${order.size} . Qty ${order.quantity}',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        SizedBox(width: $style.insets.sm),
                        Text(
                          '\$${order.price * order.quantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: $style.insets.sm,
                    )
                  ],
                );
              },
            ),
            getOrderSummary(sum)
          ]),
    );
  }

  Widget getOrderSummary(double sum) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Detail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: $style.insets.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sub Total',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '\$${sum.toString()}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: $style.insets.xs),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '\$20',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: $style.insets.xs),
        const Divider(),
        SizedBox(height: $style.insets.xs),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Order',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '\$${sum + 20}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
