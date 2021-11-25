import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  List<Meal> favoriteList = [];
  FavoritesScreen(this.favoriteList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return MealItem(
          title: favoriteList[index].title,
          imageUrl: favoriteList[index].imageUrl,
          duration: favoriteList[index].duration,
          complexity: favoriteList[index].complexity,
          affordability: favoriteList[index].affordability,
          id: favoriteList[index].id,
        );
      },
      itemCount: favoriteList.length,
    );
  }
}
