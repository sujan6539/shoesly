import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shoesly/analytics/constant.dart';
import 'package:shoesly/main.dart';
import 'package:shoesly/model/review.dart';
import 'package:shoesly/model/shoe_review.dart';
import 'package:shoesly/riverpod/provider.dart';
import 'package:shoesly/riverpod/reviews/review_notifier.dart';
import 'package:shoesly/ui/widgets/app_bar.dart';
import 'package:shoesly/ui/widgets/review_card.dart';

class ProductReview extends ConsumerStatefulWidget {
  String productIdentifier;

  ProductReview({super.key, required this.productIdentifier});

  @override
  ConsumerState<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends ConsumerState<ProductReview> {
  double currentPageValue = 0;
  PageController controller = PageController();
  List<String> titles = [
    "All",
    "5 stars",
    "4 Stars",
    "3 Stars",
    "2 Stars",
    "1 Stars"
  ];
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ref
        .read(firebaseAnalyticsProvider)
        .logScreenView(screenName: productReviewPageName);

    ShoeReview shoeReview =
        ref.watch(reviewNotifierProvider(widget.productIdentifier));

    return Scaffold(
      appBar: getAppBarWidget(ref, context, 'Review', [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            ),
            SizedBox(width: $style.insets.xxs),
            Text(
              '4.5',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 12),
            ),
            SizedBox(width: $style.insets.xxs),
          ],
        ),
      ]),
      body: Column(children: [
        getSegmentButtons(titles),
        getPageView(shoeReview.reviews)
      ]),
    );
  }

  Widget getSegmentButtons(List<String> titles) {
    List<Widget> widgets = titles.asMap().entries.map((entry) {
      double index = entry.key.toDouble();
      String title = entry.value;

      return getButtonItem(title, currentPageValue == index, onTap: () {
        setState(() {
          currentPageValue = index;
          controller.animateToPage(currentPageValue.toInt(),
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn);
        });
      });
    }).toList();
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          children: widgets,
        ),
      ),
    );
  }

  Widget getButtonItem(String title, bool isSelected, {VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.black : Colors.grey.withOpacity(0.5),
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getPageView(List<Review> reviews) {
    List<Review> filteredList;
    if (currentPageValue == 0) {
      filteredList = reviews;
    } else {
      filteredList = reviews
          .where((review) => 6 - review.stars == currentPageValue)
          .toList();
    }

    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: titles.length,
        physics: const ScrollPhysics(),
        itemBuilder: (context, position) {
          print(filteredList.length);
          if (filteredList.isNotEmpty) {
            return ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) => ReviewCard(
                      imageUrl: 'https://picsum.photos/200',
                      name: filteredList[index].reviewerName,
                      reviewDate:
                          DateFormat.yMMMd().format(filteredList[index].date),
                      rating: filteredList[index].stars,
                      reviewText: filteredList[index].description,
                    ));
          } else {
            return Center(
                child: Text(
              'No reviews.',
              style: Theme.of(context).textTheme.bodyLarge,
            ));
          }
        },
      ),
    );
  }
}
