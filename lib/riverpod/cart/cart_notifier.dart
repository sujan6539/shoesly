import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/model/order_detail.dart';
import 'package:shoesly/riverpod/cart/cart_repository.dart';
import 'package:shoesly/riverpod/cart/cart_state.dart';

class CartNotifier extends StateNotifier<CartState> {
  final CartRepository _cartRepository;

  CartNotifier(this._cartRepository) : super(CartState());

  void addItem(OrderDetail item) {
    state = state.copyWith(
      items: [
        ...state.orderList,
        if (!state.orderList
            .any((element) => element.shoeIdentifier == item.shoeIdentifier))
          item,
      ],
    );
    // TODO add network call here
    _cartRepository.addItem(item);
  }

  void removeItem(String id) {
    state = state.copyWith(
      items:
          state.orderList.where((item) => item.shoeIdentifier != id).toList(),
    );
    _cartRepository.removeItem(id);
  }

  void clearCart() {
    state = state.copyWith(items: []);
    _cartRepository.clearCart();
  }
}
