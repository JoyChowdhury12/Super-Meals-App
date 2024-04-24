import 'package:flutter/material.dart';
import 'package:super_meals/data/dummy_data.dart';
import 'package:super_meals/models/category.dart';
import 'package:super_meals/widgets/category_grid_item.dart';

import '../models/meal.dart';
import 'meals_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Meal> availableMeals;

  const CategoriesScreen({super.key, required this.availableMeals});

  void _onSelectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MealsScreen(
                title: category.title,
                meals: filteredMeals,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _onSelectCategory(context, category);
              },
            )
        ],
      ),
    );
  }
}
