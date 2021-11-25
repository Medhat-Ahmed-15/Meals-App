import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

class CategorySingleItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategorySingleItem({this.title, this.color, this.id});

  void _selectedCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routName,
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectedCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(
          15), //its better to be same radius as the container itself so splashing fits exactly the container try changing the number to smaller and see the difference
      child: Container(
          //now i want to make sure that when i tap on a single item i will make an action and since container doesn't have a ontap method i will wrap it with a widget that have a onTap argument which is GestureDetector but the problem with GestureDetector is that it doesn't have any animations when tapping the card what i mean is i won't recognize that i tapped and to make a some kind of splash of colors when tapping so to Know that i tapped somethhing im gonna use instead Inkwell class to wrap with it the container

          padding: EdgeInsets.only(left: 10, top: 5),
          child: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.7),
                color
              ], //here im telling him to start the gradient from transparent of my color to the full color
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
