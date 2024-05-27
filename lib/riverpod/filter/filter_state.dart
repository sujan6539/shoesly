import 'package:shoesly/model/filter.dart';

class FilterState {
  Filter? filter;

  FilterState({this.filter});

  FilterState copyWith({required Filter newFilter}) {
    return FilterState(
      filter: newFilter,
    );
  }
}
