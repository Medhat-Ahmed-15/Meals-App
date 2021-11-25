import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/settings_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> newMealsList;
  List<Meal> favoriteList = [];

  var saveSwitchFilter = {
    '_glutenFree': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false
  };

  void filterMeals(Map filterMap) {
    saveSwitchFilter = filterMap;
    if (filterMap['_glutenFree'] == true) {
      setState(() {
        newMealsList = DUMMY_MEALS.where((element) {
          return element.isGlutenFree == true;
        }).toList();
      });
    }

    if (filterMap['vegetarian'] == true) {
      setState(() {
        newMealsList = DUMMY_MEALS.where((element) {
          return element.isVegetarian == true;
        }).toList();
      });
    }

    if (filterMap['vegan'] == true) {
      setState(() {
        newMealsList = DUMMY_MEALS.where((element) {
          return element.isVegan == true;
        }).toList();
      });
    }

    if (filterMap['lactose'] == true) {
      setState(() {
        newMealsList = DUMMY_MEALS.where((element) {
          return element.isLactoseFree == true;
        }).toList();
      });
    }
  }

  void addingOrRemovingFavorites(String mealId) {
    var existingIndex = favoriteList.indexWhere((element) =>
        element.id ==
        mealId); //hna lw meal el id mawgood hayrag3 el index bata3o

    if (existingIndex >= 0) {
      setState(() {
        favoriteList.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteList
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool checkMealIsFavOrNot(String mealId) {
    return favoriteList.any((meal) =>
        meal.id ==
        mealId); //dee bat loop 3al list lw fee any id mn el badawr feehom zy el ana 3andee ba t return true
  }

  @override
  Widget build(BuildContext context) {
    if (newMealsList == null) {
      newMealsList = DUMMY_MEALS;
    }
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1), //the background color
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromARGB(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromARGB(20, 51, 51, 1),
              ),
              subtitle1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondenseed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: TabsScreen(
      //  favoriteList), //home argument points at which widget should be loaded first this the entry point of the app
      routes: {
        '/': (context) => TabsScreen(
            //((((((('/'))))))) dee keda ma3naha 2n 5alee el app yabtdy hna w fa nfs el wa2t hatatha fal routes
            favoriteList), //since 2nee 3ayz 2ab3t el favorite list lal settings screen w since brdo 2nee ma3andeesh da5la direct la class settings bs 3ande da5la mn el tabs w mn el tabs lal setting
        CategoryMealsScreen.routName: (context) =>
            CategoryMealsScreen(newMealsList),
        MealDetailScreen.routName: (context) =>
            MealDetailScreen(addingOrRemovingFavorites, checkMealIsFavOrNot),
        SettingsScreen.routName: (context) =>
            SettingsScreen(filterMeals, saveSwitchFilter),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) =>
                CategoriesScreen()); //ana hna ba2olo lama yahsl 2y error wadeene lal categories page bdl ya3nii ma3ml page gdeeda feeha error message
      },
    );
  }
}
