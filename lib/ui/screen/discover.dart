import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shoesly/analytics/constant.dart';
import 'package:shoesly/model/product.dart';
import 'package:shoesly/riverpod/product/product_notifier.dart';
import 'package:shoesly/ui/widgets/item_card.dart';
import 'package:shoesly/ui/widgets/primary_button.dart';

class Discover extends ConsumerStatefulWidget {
  const Discover({super.key});

  @override
  ConsumerState<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends ConsumerState<Discover> {
  double currentPageValue = 0;
  PageController controller = PageController();
  Set<String> titles = {};

  @override
  void initState() {
    super.initState();
    titles.add('all');

    FirebaseAnalytics.instance.logBeginCheckout(
        value: 10.0,
        currency: 'USD',
        items: [
          AnalyticsEventItem(
              itemName: 'Socks', itemId: 'xjw73ndnw', price: 10.0),
        ],
        coupon: '10PERCENTOFF');

    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final productlist = ref.watch(productNotifierProvider);

    FirebaseAnalytics.instance.logScreenView(screenName: discoverPageName);

    for (var p in productlist) {
      titles.add(p.brand.toLowerCase());
    }

    var products = titles.elementAt(currentPageValue.toInt()) == 'all'
        ? productlist
        : productlist
            .where((p) =>
                p.brand.toLowerCase() ==
                titles.elementAt(currentPageValue.toInt()).toLowerCase())
            .toList();

    return titles.length == 1
        ? // Load a Lottie file from your assets
        Builder(builder: (context) {
            return Lottie.asset('assets/loading.json');
          })
        : Stack(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    IconButton(
                      onPressed: () {
                        context.push('/cart');
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.bagShopping,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                getSegmentButtons(titles),
                getPageView(products)
              ]),
            ),
            Positioned(
              bottom: 16,
              right: 120,
              left: 120,
              child: PrimaryButton(
                  onPressed: () {
                    context.push('/product_filter');
                  },
                  iconData: FontAwesomeIcons.sliders,
                  title: 'Filter'),
            ),
          ]);
  }

  Widget getSegmentButtons(Set<String> titles) {
    List<Widget> widgets = [];
    for (var i = 0; i < titles.length; i++) {
      double index = i.toDouble();
      String title = titles.elementAt(i);
      widgets.add(getButtonItem(title, currentPageValue == index, onTap: () {
        setState(() {
          currentPageValue = index;
          controller.animateToPage(currentPageValue.toInt(),
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn);
        });
      }));
    }

    return SizedBox(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: titles.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: widgets[index],
              )),
    );
  }

  Widget getButtonItem(String title, bool isSelected, {VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.black : Colors.grey.withOpacity(0.9),
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget getPageView(List<Product> products) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: titles.length,
        physics: const ScrollPhysics(),
        itemBuilder: (context, position) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.60),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemCard(product: products[index]);
              });
        },
      ),
    );
  }
}
