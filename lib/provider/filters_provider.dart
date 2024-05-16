import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'meals_provider.dart';

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

final filterdMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.veganFree]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegeterianFree]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
