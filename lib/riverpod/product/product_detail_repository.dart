import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shoesly/model/product_detail.dart';
import 'package:shoesly/riverpod/provider.dart';

class ProductDetailRepository {
  final DatabaseReference _databaseReference;

  ProductDetailRepository(this._databaseReference);

  Future<void> createItem(ProductDetail productDetail) async {
    await _databaseReference
        .child(productDetail.id.toString())
        .set(productDetail.toJson());
  }

  Stream<List<ProductDetail>> readItems() {
    return _databaseReference.onValue.map((event) {
      final data = event.snapshot.value;

      if (data is Map) {
        // If data is a Map
        final productDetails = (data).entries.map((entry) {
          final productData = entry.value as Map<dynamic, dynamic>;
          return ProductDetail.fromJson(Map<String, dynamic>.from(productData));
        }).toList();
        return productDetails;
      } else if (data is List) {
        // If data is a List
        final productDetails = (data).map((detailsData) {
          return ProductDetail.fromJson(Map<String, dynamic>.from(detailsData));
        }).toList();
        return productDetails;
      } else {
        return [];
      }
    });
  }
}

final productDetailsReferenceProvider =
    Provider<ProductDetailRepository>((ref) {
  final databaseReference = ref.watch(databaseProductDetailsReferenceProvider);
  return ProductDetailRepository(databaseReference);
});
