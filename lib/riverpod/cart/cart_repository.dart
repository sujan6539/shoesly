import 'package:shoesly/model/order_detail.dart';

class CartRepository {
  Future<void> addItem(OrderDetail item) async {
    // Add item to the cart (this could be a network request or database operation)
  }

  Future<void> removeItem(String id) async {
    // Remove item from the cart
  }

  Future<void> clearCart() async {
    // Clear the cart
  }
}
