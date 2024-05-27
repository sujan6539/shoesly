import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/analytics/analytics_helper.dart';

class ConfirmOrderPayment extends ConsumerWidget {
  const ConfirmOrderPayment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Information',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ListTile(
            title: const Text(
              'Payment Method',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('Credit Card'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              onClickEvent(ref, ContentType.listTile, "Payment Method");
              // Handle tap if necessary
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('Kathmandu, Nepal'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Handle tap if necessary
            },
          ),
        ],
      ),
    );
  }
}
