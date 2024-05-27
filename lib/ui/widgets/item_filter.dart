// Import libraries
import 'package:flutter/material.dart';

// Define a sorting option class
class SortOption {
  final String title;
  final IconData icon;

  SortOption({required this.title, required this.icon});
}

// Create a SortBy class
class SortBy extends StatefulWidget {
  String title;
  List<SortOption> sortOptions;
  OnFilterSelectedCallback onFilterSelectedCallback;

  SortBy(
      {super.key,
      required this.title,
      required this.sortOptions,
      required this.onFilterSelectedCallback});

  @override
  State<SortBy> createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
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
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount: widget.sortOptions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorSelectedIndex == index
                            ? Colors.black
                            : Colors.transparent,
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(8),
                    child: buildColorOption(index),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget buildColorOption(int index) {
    bool isSelected = colorSelectedIndex == index;
    return GestureDetector(
      onTap: () {
        _onColorSelected(index);
        widget.onFilterSelectedCallback(index);
      },
      child: Text(
        widget.sortOptions[index].title,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}

typedef OnFilterSelectedCallback = void Function(int index);
