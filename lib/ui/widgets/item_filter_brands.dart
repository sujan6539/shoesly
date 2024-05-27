import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoesly/main.dart';
import 'package:shoesly/ui/widgets/item_filter.dart';

class Brand {
  final String name;
  final String logoUrl;
  int items = 0;

  Brand({
    required this.name,
    required this.logoUrl,
    required this.items,
  });
}

class BrandsList extends StatefulWidget {
  List<Brand> brands;
  OnFilterSelectedCallback onFilterSelectedCallback;

  BrandsList(
      {super.key,
      required this.brands,
      required this.onFilterSelectedCallback});

  @override
  _BrandsListState createState() => _BrandsListState();
}

class _BrandsListState extends State<BrandsList> {
  var selectedIndex = 0;

  void _onBrandTap(int index) {
    setState(() {
      for (int i = 0; i < widget.brands.length; i++) {
        selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: $style.insets.sm),
          child: const Text(
            'Brands',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: $style.insets.xs),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.brands.length,
            itemBuilder: (context, index) {
              final brand = widget.brands[index];
              return GestureDetector(
                onTap: () {
                  _onBrandTap(index);
                  widget.onFilterSelectedCallback(index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.shade300,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SvgPicture.network(
                                  brand.logoUrl,
                                  placeholderBuilder: (BuildContext context) =>
                                      const Icon(Icons.sports_football),
                                ),
                              )),
                          if (index == selectedIndex)
                            const Positioned(
                              bottom: 4,
                              right: 4,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: $style.insets.xs),
                      Text(
                        brand.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${brand.items} Items',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
