import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/model/product_detail.dart';
import 'package:shoesly/riverpod/product/product_detail_repository.dart';

class ProductDetailNotifier extends StateNotifier<List<ProductDetail>> {
  final ProductDetailRepository? _productDetailRepository;

  ProductDetailNotifier(this._productDetailRepository) : super([]) {
    _productDetailRepository?.readItems().listen((productDetails) {
      state = productDetails;
    });
  }
}

final productDetailNotifierProvider =
    StateNotifierProvider<ProductDetailNotifier, List<ProductDetail>>((ref) {
  final productDetailsProvider = ref.watch(productDetailsReferenceProvider);
  return ProductDetailNotifier(productDetailsProvider);
});
