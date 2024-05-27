import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/connectivity/connectivity_status.dart';
import 'package:shoesly/riverpod/provider.dart';

class Connectivity extends ConsumerStatefulWidget {
  Widget child;

  Connectivity({super.key, required this.child});

  @override
  ConsumerState<Connectivity> createState() => _ConnectivityState();
}

class _ConnectivityState extends ConsumerState<Connectivity> {
  @override
  Widget build(BuildContext context) {
    final connectivityStatus = ref.watch(connectivityStreamProvider).value;

    return Center(
        child: connectivityStatus == ConnectivityStatus.connected
            ? widget.child
            : const Text('No internet connection'));
  }
}
