import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem;

  MealItem(
      {this.title,
      this.imageUrl,
      this.duration,
      this.complexity,
      this.affordability,
      this.removeItem,
      this.id});

//I made these two getters to return a text string what came from Complexity and Affordability enums since their objects only wont be considered as a string to  be put in a Text
  String get complexityText {
    if (complexity == Complexity.Simple) {
      return "simple";
    }
    if (complexity == Complexity.Hard) {
      return "Hard";
    }
    if (complexity == Complexity.Challenging) {
      return "Challenging";
    }
  }

  String get affordabilityText {
    if (affordability == Affordability.Pricey) {
      return "Pricey";
    }
    if (affordability == Affordability.Affordable) {
      return "Affordable";
    }
    if (affordability == Affordability.Luxurious) {
      return "Luxurious";
    }
  }

  void _selecteddMeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(MealDetailScreen.routName, arguments: id)
        .then((value) => removeItem(value));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selecteddMeal(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  //clipRect is responsible for cutting the image if i want to make its edges rounded since there is no direct way with doing that by the image widget
                  borderRadius: BorderRadius.only(
                    //BorderRadius.only()==>only alows me to set the radius for each corners sepertely and i only wnat to round the corners on top left and top right corners
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  //since i want to move the text up,down,left,right..when i'm inside a stack i can use a special widget which works only inside a stack, i can wrap text with that widget which is "Positioned" which allows to move freely
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title,
                      softWrap:
                          true, //true so that the text, if it should be too long for the card container is actually wrapped
                      overflow:
                          TextOverflow //and i'll set overflow so in case that it doesn't fit into its box even with wrapping, now it would just fade and not overflow
                              .fade,
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$duration min',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        complexityText,
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        affordabilityText,
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
