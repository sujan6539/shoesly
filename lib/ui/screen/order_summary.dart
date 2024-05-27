import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shoesly/analytics/constant.dart';
import 'package:shoesly/riverpod/provider.dart';
import 'package:shoesly/ui/widgets/app_bar.dart';
import 'package:shoesly/ui/widgets/cart_cta.dart';
import 'package:shoesly/ui/widgets/confirm_order_detail.dart';
import 'package:shoesly/ui/widgets/confirm_order_payment.dart';

class OrderSummary extends ConsumerWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(firebaseAnalyticsProvider)
        .logScreenView(screenName: orderSummaryPageName);

    final cartState = ref.watch(cartStateProvider);

    return Scaffold(
      appBar: getAppBarWidget(ref, context, "Order Summary", []),
      body: ListView(children: [
        const Flexible(child: ConfirmOrderPayment()),
        Expanded(child: OrderDetailList(orders: cartState.orderList)),
        const SizedBox(
          height: 100,
        )
      ]),
      bottomSheet: CartCta(
        cartState.totalPrice + 20,
        ctaTitle: 'Payment',
        onPressed: () {
          context.replace('/confirmation');
        },
      ),
    );
  }
}
