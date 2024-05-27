// Import libraries

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SizePicker extends ConsumerStatefulWidget {
  List<String> sizes;

  OnSizeSelectedCallback onSizeSelected;

  SizePicker({Key? key, required this.onSizeSelected, required this.sizes})
      : super(key: key);

  @override
  ConsumerState<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends ConsumerState<SizePicker> {
  int selected_index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
        // Change Row to Column for vertical stacking
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Size',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Wrap(
              direction: Axis.horizontal,
              spacing: 4.0,
              runSpacing: 8.0,
              children: widget.sizes
                  .asMap()
                  .entries
                  .map((entry) => createCircle(entry.value, entry.key))
                  .toList())
        ]);
  }

  Widget createCircle(String item, int index) {
    return Padding(
      padding: const EdgeInsets.all(4.0), // Add some padding
      child: GestureDetector(
        onTap: () {
          widget.onSizeSelected(index);
          setState(() {
            selected_index = index;
          });
        },
        child: Container(
          width: 48.0, // Set the circle size
          height: 48.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            shape: BoxShape.circle,
            color: index == selected_index
                ? Colors.black
                : Colors.transparent, // Set the circle color
          ),
          child: Center(
            child: Text(
              item,
              style: TextStyle(
                  fontSize: 16.0,
                  color: index == selected_index
                      ? Colors.white
                      : Colors.grey.shade600),
            ),
          ),
        ),
      ),
    );
  }
}

typedef OnSizeSelectedCallback = void Function(int index);
