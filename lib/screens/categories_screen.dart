import 'package:flutter/material.dart';
import 'package:super_meals/data/dummy_data.dart';
import 'package:super_meals/models/category.dart';
import 'package:super_meals/widgets/category_grid_item.dart';

import '../models/meal.dart';
import 'meals_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Meal> availableMeals;

  const CategoriesScreen({super.key, required this.availableMeals});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  void _onSelectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
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

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        child: GridView(
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
        builder: (context, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut)),
          child: child,
        ),
      ),
    );
  }
}
