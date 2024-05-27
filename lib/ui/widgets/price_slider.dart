import 'package:flutter/material.dart';

class PriceRangeSlider extends StatefulWidget {
  OnPriceRangeCallback onPriceRangeCallback;

  PriceRangeSlider({super.key, required this.onPriceRangeCallback});

  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  double _lowerValue = 0;
  double _upperValue = 1750;
  final int _minValue = 0;
  final int _maxValue = 1750;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          const Text(
            'Price Range',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100,
            child: RangeSlider(
              values: RangeValues(_lowerValue, _upperValue),
              min: _minValue.roundToDouble(),
              max: _maxValue.roundToDouble(),
              divisions: (_maxValue - _minValue).toInt(),
              activeColor: Colors.black,
              inactiveColor: Colors.grey.withOpacity(0.5),
              onChanged: (values) {
                setState(() {
                  _lowerValue = values.start;
                  _upperValue = values.end;
                });
                widget.onPriceRangeCallback(_lowerValue, _upperValue);
              },
            ),
          ),
          Positioned(
            left: ((_lowerValue - _minValue) /
                (_maxValue - _minValue) *
                MediaQuery.of(context).size.width),
            bottom: 8,
            child: _lowerValue != 0.0
                ? Text(
                    '\$${_lowerValue.toInt()}',
                    style: const TextStyle(fontSize: 16),
                  )
                : Container(),
          ),
          Positioned(
            left: ((_upperValue - _minValue) /
                    (_maxValue - _minValue) *
                    MediaQuery.of(context).size.width) -
                32,
            bottom: 8,
            child: _upperValue != 1750
                ? Text(
                    '\$${_upperValue.toInt()}',
                    style: const TextStyle(fontSize: 16),
                  )
                : Container(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${_minValue.toString()}',
                    style: const TextStyle(color: Colors.grey)),
                Text('\$${_maxValue.toString()}',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

typedef OnPriceRangeCallback = Function(double min, double max);
