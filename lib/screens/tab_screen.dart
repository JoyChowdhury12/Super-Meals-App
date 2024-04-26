import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_meals/provider/favourites_provider.dart';
import 'package:super_meals/provider/meals_provider.dart';
import 'package:super_meals/screens/categories_screen.dart';
import 'package:super_meals/screens/filter_screen.dart';
import 'package:super_meals/screens/meals_screen.dart';
import 'package:super_meals/widgets/main_drawer.dart';

import '../provider/filters_provider.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;

  void _changeScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.push<Map<Filter, bool>>(
          context, MaterialPageRoute(builder: (context) => FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterdMealProvider);

    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activeTitle = "Categories";
    if (_selectedPageIndex == 1) {
      final _favouriteMeals = ref.watch(favouriteMealsProvider);
      activeScreen = MealsScreen(
        meals: _favouriteMeals,
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
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites"),
        ],
      ),
    );
  }
}
