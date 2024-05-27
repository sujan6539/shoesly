import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesly/riverpod/provider.dart';
import 'package:shoesly/ui/widgets/primary_button.dart';

class Confirmation extends ConsumerWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cartState = ref.watch(cartStateProvider);
    cartState.clearCart();

    return Scaffold(
      body: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/confirmation.json', repeat: true),
            const Text(
              "Order Confirmed",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 126,
              height: 60,
              child: PrimaryButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) {
                      return route.settings.name == '/';
                    });
                  },
                  title: "Done"),
            )
          ],
        ),
      ),
    );
  }
}
