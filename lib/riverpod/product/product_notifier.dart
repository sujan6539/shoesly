import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/model/product.dart';
import "product_repository.dart";

class ProductNotifier extends StateNotifier<List<Product>> {
  ItemRepository? _itemRepository;

  ProductNotifier(this._itemRepository) : super([]) {
    _itemRepository?.readItems().listen((products) {
      state = products;
    });
  }

  Future<void> addItem(Product product) async {
    await _itemRepository?.createItem(product);
  }

  Future<void> updateItem(Product product) async {
    await _itemRepository?.updateItem(product);
  }

  Future<void> deleteItem(String id) async {
    await _itemRepository?.deleteItem(id);
  }
}

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  final itemRepository = ref.watch(itemRepositoryProvider);
  return ProductNotifier(itemRepository);
});
