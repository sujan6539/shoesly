import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a sorting option class
class ColorOptions {
  final String title;
  final Color color;

  ColorOptions({required this.title, required this.color});
}

class ItemFilterColor extends ConsumerStatefulWidget {
  List<ColorOptions> colorOptions;

  ItemFilterColor({super.key, required this.colorOptions});

  @override
  ConsumerState<ItemFilterColor> createState() => _ItemFilterColorState();
}

class _ItemFilterColorState extends ConsumerState<ItemFilterColor> {
  int colorSelectedIndex = 0;

  void _onColorSelected(int index) {
    setState(() {
      colorSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Color",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Wrap(
            direction: Axis.horizontal,
            spacing: 2.0,
            runSpacing: 2.0,
            children: widget.colorOptions
                .asMap()
                .entries
                .map((entry) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: colorSelectedIndex == entry.key ? 2 : 1,
                              color: colorSelectedIndex == entry.key
                                  ? Colors.black
                                  : Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.all(8),
                      child: buildColorOption(entry.key),
                    )))
                .toList()),
      ],
    );
  }

  Widget buildColorOption(int index) {
    return GestureDetector(
      onTap: () {
        _onColorSelected(index);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                color: widget.colorOptions[index].color,
                borderRadius: BorderRadius.circular(10.0)),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.colorOptions[index].title,
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
