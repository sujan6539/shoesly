import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shoesly/model/product.dart';
import 'package:shoesly/riverpod/provider.dart';

class ItemRepository {
  final DatabaseReference _databaseReference;

  ItemRepository(this._databaseReference);

  Future<void> createItem(Product product) async {
    await _databaseReference.child(product.id.toString()).set(product.toJson());
  }

  Stream<List<Product>> readItems() {
    return _databaseReference.onValue.map((event) {
      final data = event.snapshot.value;

      if (data is Map) {
        // If data is a Map
        final products = (data).entries.map((entry) {
          final productData = entry.value as Map<dynamic, dynamic>;
          return Product.fromJson(Map<String, dynamic>.from(productData));
        }).toList();
        return products;
      } else if (data is List) {
        // If data is a List
        final products = (data).map((productData) {
          return Product.fromJson(Map<String, dynamic>.from(productData));
        }).toList();
        return products;
      } else {
        return [];
      }
    });
  }

  Future<void> updateItem(Product product) async {
    await _databaseReference
        .child(product.id.toString())
        .update(product.toJson());
  }

  Future<void> deleteItem(String id) async {
    await _databaseReference.child(id).remove();
  }
}

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final databaseReference = ref.watch(databaseProductReferenceProvider);
  return ItemRepository(databaseReference);
});
