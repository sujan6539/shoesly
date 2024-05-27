import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/analytics/constant.dart';
import 'package:shoesly/model/filter.dart';
import 'package:shoesly/riverpod/filter/filter_state.dart';
import 'package:shoesly/riverpod/product/product_notifier.dart';
import 'package:shoesly/riverpod/provider.dart';
import 'package:shoesly/ui/widgets/app_bar.dart';
import 'package:shoesly/ui/widgets/filter_cta.dart';
import 'package:shoesly/ui/widgets/item_filter.dart';
import 'package:shoesly/ui/widgets/item_filter_brands.dart';
import 'package:shoesly/ui/widgets/item_filter_color.dart';
import 'package:shoesly/ui/widgets/price_slider.dart';

final List<SortOption> sortingOptions = [
  SortOption(title: 'Random', icon: Icons.sort_by_alpha),
  SortOption(title: 'Name (A-Z)', icon: Icons.sort_by_alpha),
  SortOption(
    title: 'Price (Low-High)',
    icon: Icons.abc_outlined,
  ),
  SortOption(title: 'Price (High-Low)', icon: Icons.money_off)
];

final List<SortOption> gender = [
  SortOption(
    title: 'All',
    icon: Icons.sort_by_alpha,
  ),
  SortOption(
    title: 'Men',
    icon: Icons.sort_by_alpha,
  ),
  SortOption(
    title: 'Women',
    icon: Icons.abc_outlined,
  ),
  SortOption(
    title: 'Unisex',
    icon: Icons.money_off,
  )
];

final List<ColorOptions> colors = [
  ColorOptions(title: 'all', color: Colors.transparent),
  ColorOptions(
    title: 'Black',
    color: Colors.black,
  ),
  ColorOptions(
    title: 'White',
    color: Colors.white,
  ),
  ColorOptions(
    title: 'Red',
    color: Colors.red,
  ),
  ColorOptions(
    title: 'Green',
    color: Colors.green,
  ),
];

class ProductFilter extends ConsumerStatefulWidget {
  ProductFilter({super.key});

  @override
  ConsumerState<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends ConsumerState<ProductFilter> {
  Filter filter = Filter(
      brand: 'All',
      sortBy: SortByFilter.random,
      gender: GenderFilter.all,
      color: '',
      minPrice: 0,
      maxPrice: 1750);

  @override
  Widget build(BuildContext context) {
    ref
        .read(firebaseAnalyticsProvider)
        .logScreenView(screenName: productFilterPageName);

    var products = ref.watch(productNotifierProvider);

    FilterState filterState = ref.watch(filterStateNotifier);
    filter = filterState.filter ?? filter;

    Map<String, Brand> brandsmap = {
      'all': Brand(name: 'all', logoUrl: 'logo', items: products.length)
    };

    for (var p in products) {
      brandsmap[p.brand.toLowerCase()] = Brand(
          name: p.brand.toLowerCase(),
          logoUrl: p.logoURL ?? '',
          items: (brandsmap[p.brand.toLowerCase()]?.items ?? 0) + 1);
    }

    var brands = brandsmap.values;

    return Scaffold(
        appBar: getAppBarWidget(ref, context, 'Filter', []),
        body: Stack(children: [
          ListView(
            children: [
              IntrinsicHeight(
                  child: BrandsList(
                brands: brandsmap.values.toList(),
                onFilterSelectedCallback: (index) {
                  setState(() {
                    filter.brand = brands.elementAt(index).name;
                  });
                },
              )),
              PriceRangeSlider(
                onPriceRangeCallback: (min, max) {
                  setState(() {
                    filter.minPrice = min;
                    filter.maxPrice = max;
                  });
                },
              ),
              SortBy(
                title: 'Sort By',
                sortOptions: sortingOptions,
                onFilterSelectedCallback: (index) {
                  setState(() {
                    filter.sortBy =
                        SortByFilter.toFilter(sortingOptions[index].title);
                  });
                },
              ),
              SortBy(
                title: 'Gender',
                sortOptions: gender,
                onFilterSelectedCallback: (index) {
                  setState(() {
                    filter.gender = GenderFilter.toFilter(gender[index].title);
                  });
                },
              ),
              ItemFilterColor(
                colorOptions: colors,
              ),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: FilterCTA(filter))
        ]));
  }
}
