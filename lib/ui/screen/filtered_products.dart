import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesly/model/filter.dart';
import 'package:shoesly/riverpod/filter/filter_state.dart';
import 'package:shoesly/riverpod/product/product_notifier.dart';
import 'package:shoesly/riverpod/provider.dart';
import 'package:shoesly/ui/widgets/app_bar.dart';
import 'package:shoesly/ui/widgets/item_card.dart';

class FilteredProducts extends ConsumerStatefulWidget {
  const FilteredProducts({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilteredProductsState();
}

class _FilteredProductsState extends ConsumerState<FilteredProducts> {
  @override
  Widget build(BuildContext context) {
    FilterState filterState = ref.watch(filterStateNotifier);

    var productlist = ref.watch(productNotifierProvider);

    productlist = productlist.where((product) {
      return filterState.filter?.brand.toLowerCase() == 'all' ||
          product.brand.toLowerCase() ==
              filterState.filter?.brand.toLowerCase();
    }).where((product) {
      return filterState.filter?.gender?.name.toLowerCase() == 'all' ||
          product.gender.toLowerCase() ==
              filterState.filter?.gender?.name.toLowerCase();
    }).where((product) {
      return (product.price >= (filterState.filter?.minPrice ?? 0) &&
          product.price <= (filterState.filter?.maxPrice ?? 1750));
    }).toList();

    switch (filterState.filter?.sortBy) {
      case SortByFilter.random:
        break;
      case SortByFilter.nameAToZ:
        productlist.sort((p1, p2) => p1.name.compareTo(p2.name));
        break;
      case SortByFilter.priceLowToHigh:
        productlist.sort((p1, p2) => p1.price.compareTo(p2.price));
        break;
      case SortByFilter.priceHighToLow:
        productlist.sort((p1, p2) => p2.price.compareTo(p1.price));
        break;
      case null:
    }

    return Scaffold(
      appBar: getAppBarWidget(ref, context, 'Filtered Result', []),
      body: (productlist.isNotEmpty)
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.60),
              itemCount: productlist.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemCard(product: productlist[index]);
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/noResult.json', repeat: false),
                  const Text(
                    'No products.',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
    );
  }
}
