import 'package:flutter/material.dart';

class ItemDetailCard extends StatefulWidget {
  List<String> imageUrls;

  ItemDetailCard({super.key, required this.imageUrls});

  @override
  _ItemDetailCardState createState() => _ItemDetailCardState();
}

class _ItemDetailCardState extends State<ItemDetailCard> {
  int selectedIndex = 0;
  int colorSelectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.teal,
    Colors.blue,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onColorSelected(int index) {
    setState(() {
      colorSelectedIndex = index;
    });
  }

  void _onImageSelected(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.imageUrls.length,
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.network(
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: CircularProgressIndicator(),
                      ),
                      widget.imageUrls[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              left: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      widget.imageUrls.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.circle,
                          size: 10,
                          color: selectedIndex == index
                              ? Colors.black
                              : Colors.black26,
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: colors
                              .asMap()
                              .entries
                              .map((entry) =>
                                  buildColorOption(entry.value, entry.key))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildColorOption(Color color, int index) {
    bool isSelected = colorSelectedIndex == index;
    return GestureDetector(
      onTap: () => _onColorSelected(index),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: isSelected ? Colors.grey : Colors.transparent,
            width: 2,
          ),
        ),
        child: isSelected
            ? Icon(Icons.check, color: Colors.white, size: 18)
            : SizedBox.shrink(),
      ),
    );
  }
}
