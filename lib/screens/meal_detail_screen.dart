import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static final String routName = '/mealDetailScreen';
  final Function addingOrRemovingFavorites;
  final Function checkMealIsFavOrNot;
  MealDetailScreen(this.addingOrRemovingFavorites, this.checkMealIsFavOrNot);

  Widget titletext(BuildContext ctx, String text) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: Theme.of(ctx).textTheme.subtitle1,
        ),
      ),
    );
  }

  Widget buildContainer(Widget list) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        height: 150,
        width: 300,
        padding: EdgeInsets.all(10),
        child: list);
  }

  @override
  Widget build(BuildContext context) {
    var routeArgs = ModalRoute.of(context).settings.arguments as String;
    String mealId = routeArgs;

    var selectedMeal = DUMMY_MEALS.firstWhere((element) {
      //difference between using (((firstWhere))) and (((where))) is that (((firstWhere))) loops on the list until it finds this one item that is stisfy the condition and doesn't return a list on the other hand (((where))) loops on the list and may find more than one item that staisfies this condition an so it returns them into new list
      return element.id == mealId;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedMeal.title,
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          titletext(context, "Ingrediants"),
          buildContainer(
            ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              itemCount: selectedMeal.ingredients.length,
            ),
          ),
          titletext(context, "Steps"),
          buildContainer(
            ListView.builder(
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(), //is used to put a slight line between every item
                  ],
                );
              },
              itemCount: selectedMeal.steps.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          checkMealIsFavOrNot(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          addingOrRemovingFavorites(mealId);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
