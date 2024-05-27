import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/model/filter.dart';
import 'package:shoesly/riverpod/filter/filter_state.dart';

class FilterStateNotifier extends StateNotifier<FilterState> {
  FilterStateNotifier() : super(FilterState());

  void updateState({required Filter newFilter}) {
    state = state.copyWith(newFilter: newFilter);
  }
}
