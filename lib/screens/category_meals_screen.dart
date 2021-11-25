import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static final routName = '/category_meals_screen';
  List<Meal> selectedMeals;
  List<Meal> selectedMealsAfterFiltering;
  CategoryMealsScreen(this.selectedMealsAfterFiltering);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String title;

  String id;

  @override
  void didChangeDependencies() {
    //this method is really useful because this will be triggerd whenever the refrences of the state change which also means it will bee called when when the widget that belongs to the state has been fully initialized,updated...and this will still runs before build runs, initStae would have been great if we wouldn't have required to use modal route of context in here so any of context stuff which you need to do in initState will unfortunately not work but in here will work
    var routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    title = routeArgs['title'];
    id = routeArgs['id'];

    widget.selectedMeals = widget.selectedMealsAfterFiltering.where((element) {
      return element.categories.contains(id);
    }).toList(); //delw2ty ana 3andee kaza category w kol category leeha el id bata3ha, w 3andee kaza meal w kol meal 3andha el id bata3t el category dah ya3ni kol meal momken tab2 mahtoota fa 2ktr mn category w ana lama badoos 3ala category mo3ayana bayab2 ma3aya el id bata3t el category dee fa keda kol el ana 3amalto 2nee ba3ml list tanya feeha bs el meals bata3t el category el ana feeh dah w haya 2nee ba loop 3ala list el meals kolha w bashoof meen feeha 3ando nfs el id bata3 el category el ana wa2f 3ando w bs ba3d keda bahoto al list dee
    super.didChangeDependencies();
  }

  void removeItem(String mealId) {
    //since this method takes my mealId and remove from the lis. for that first of all, we have to make suret hat we don't derive our meals in the build method but actually a bit earlier and initState sound like a great place for that because when this page gets loaded, when this state im in this class gets created then we want to load all meals that are based on the ID of the category we're getting but it wont work because this call that I did inside initState this one ==>(((ModalRoute.of(context).settings.arguments as Map<String, String>;))))) is not liked in initState because from its requirments context and initstate isn't availble in it context although context is globally available in our ststae object but not inside of initState because initState runs too early. it runs before our widget has been created or fully created now the solution for that is by using another lifeCycle method which is (((didChangeDependencies)))

    setState(() {
      widget.selectedMeals.removeWhere((item) => item.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            title: widget.selectedMeals[index].title,
            imageUrl: widget.selectedMeals[index].imageUrl,
            duration: widget.selectedMeals[index].duration,
            complexity: widget.selectedMeals[index].complexity,
            affordability: widget.selectedMeals[index].affordability,
            id: widget.selectedMeals[index].id,
            removeItem: removeItem,
          );
        },
        itemCount: widget.selectedMeals.length,
      ),
    );
  }
}
