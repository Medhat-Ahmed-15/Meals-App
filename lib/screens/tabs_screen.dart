import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static final routName = '/tabs_screen';
  List<Meal> favoriteList = [];
  TabsScreen(this.favoriteList);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> pages;

  @override
  void initState() {
    pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget.favoriteList), 'title': 'My favorites'},
    ];
  }

  int selectedPage = 0;

  void _selectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pages[selectedPage]['title'],
        ),
      ),
      drawer: MainDrawer(),
      body: pages[selectedPage]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        backgroundColor: Theme.of(context).primaryColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: selectedPage,
        type: BottomNavigationBarType
            .shifting, //this controls the animation when switching between tabs bs lw ha5tarha fa haya batsha2labee kol el ana 3amalto fo2 fa bahtag a customize fa kol (((BottomNavigationBarItem))) lowahdo
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          )
        ],
      ),
    );
  }
}
