import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screens/settings_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      IconData icon, String text, BuildContext context, Function tapHandler) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(20),
            height: 200,
            alignment: Alignment
                .centerLeft, //THIS CONTROLS HOW THE CHILD OF THE CONTAINER IS ALIGNNED
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ),
          SizedBox(height: 20),
          buildListTile(Icons.restaurant, 'Categories', context, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile(Icons.settings, 'Filters', context, () {
            Navigator.of(context).pushReplacementNamed(SettingsScreen.routName);
          }),
        ],
      ),
    );
  }
}
