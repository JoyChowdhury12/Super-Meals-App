import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vegeterianFree, veganFree }

class FilterScreen extends StatefulWidget {
  final Map<Filter, bool> currrentFilters;

  const FilterScreen({super.key, required this.currrentFilters});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegeterianFreeFilterSet = false;
  var _veganFreeFilterSet = false;

  @override
  void initState() {
    _glutenFreeFilterSet = widget.currrentFilters[Filter.glutenFree]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Flters"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({Filter.glutenFree: _glutenFreeFilterSet});
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (newValue) {
                setState(() {
                  _glutenFreeFilterSet = newValue;
                });
              },
              title: Text(
                "Gluten Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "Only inclusw Gluten Free ingredients",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
