import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_meals/models/meal.dart';

enum Filter { glutenFree, lactoseFree, vegeterianFree, veganFree }

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegeterianFree: false,
          Filter.veganFree: false,
        });
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}
