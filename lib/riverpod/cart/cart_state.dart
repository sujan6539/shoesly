import 'package:shoesly/model/order_detail.dart';

class CartState {
  List<OrderDetail> orderList = [];

  CartState({this.orderList = const []});

  double get totalPrice =>
      orderList.fold(0, (total, item) => total + item.price * item.quantity);

  CartState copyWith({List<OrderDetail>? items}) {
    return CartState(
      orderList: items ?? this.orderList,
    );
  }

  void clearCart() {
    orderList = [];
  }
}
