import 'package:flutter/material.dart';
import 'package:super_meals/data/dummy_data.dart';
import 'package:super_meals/screens/categories_screen.dart';
import 'package:super_meals/screens/filter_screen.dart';
import 'package:super_meals/screens/meals_screen.dart';
import 'package:super_meals/widgets/main_drawer.dart';

import '../models/meal.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegeterianFree: false,
  Filter.veganFree: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;

  void _changeScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Meal> _favouriteMeals = [];

  Map<Filter, bool> _selectedFilters = kInitialFilter;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessage("Meal is no longer a favourite");
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showInfoMessage("Meal is saved as favourite");
    }
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.push<Map<Filter, bool>>(
          context,
          MaterialPageRoute(
              builder: (context) => FilterScreen(
                    currrentFilters: _selectedFilters,
                  )));
      setState(() {
        _selectedFilters = result ?? kInitialFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && meal.isGlutenFree) {
        return true;
      }
      if (_selectedFilters[Filter.lactoseFree]! && meal.isLactoseFree) {
        return true;
      }
      if (_selectedFilters[Filter.veganFree]! && meal.isVegan) {
        return true;
      }
      if (_selectedFilters[Filter.vegeterianFree]! && meal.isVegetarian) {
        return true;
      }
      return false;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    var activeTitle = "Categories";
    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: _toggleMealFavouriteStatus,
      );
      activeTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          _setScreen(identifier);
        },
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _changeScreen(index);
        },
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites"),
        ],
      ),
    );
  }
}
