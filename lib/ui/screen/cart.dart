import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesly/riverpod/provider.dart';
import 'package:shoesly/ui/widgets/app_bar.dart';
import 'package:shoesly/ui/widgets/cart_cta.dart';
import 'package:shoesly/ui/widgets/item_cart_product.dart';

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartStateProvider);
    var orderList = cartState.orderList;
    return Scaffold(
      appBar: getAppBarWidget(ref, context, 'Cart', []),
      body: orderList.isNotEmpty
          ? ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) =>
                  ItemCartProduct(orderList[index]))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                  Lottie.asset('assets/emptyCart.json'),
                  const Text(
                    'No items in cart.',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  )
                ]),
      bottomSheet: CartCta(
        cartState.totalPrice,
        ctaTitle: 'Checkout',
        onPressed: () {
          context.push('/order_summary');
        },
      ),
    );
  }
}
