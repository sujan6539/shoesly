import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/model/order_detail.dart';
import 'package:shoesly/ui/widgets/add_to_cart.dart';
import 'package:shoesly/ui/widgets/added_to_cart.dart';

class CustomBottomSheet extends ConsumerStatefulWidget {
  OrderDetail orderDetail;

  CustomBottomSheet(this.orderDetail, {super.key});

  @override
  ConsumerState<CustomBottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends ConsumerState<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var addedToCart = ref.watch(btmSheetStateProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: !addedToCart
          ? AddToCartBottomSheet(widget.orderDetail)
          : AddedToCartBottomSheet(
              itemCount: 1,
            ),
    );
  }
}

final btmSheetStateProvider = StateProvider<bool>((ref) => false);
