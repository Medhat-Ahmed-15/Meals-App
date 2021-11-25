import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  //I converted the FilterScreen to a stateful widget because actually , we'll have to manage which filters the user set or not
  static final routName = '/settings_screen';
  Function handleFilter;
  Map<String, bool> saveSwitchFilter;
  SettingsScreen(this.handleFilter, this.saveSwitchFilter);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.saveSwitchFilter['_glutenFree'];
    _vegetarian = widget.saveSwitchFilter['vegetarian'];
    _vegan = widget.saveSwitchFilter['vegan'];
    _lactoseFree = widget.saveSwitchFilter['lactose'];
    super.initState();
  }

  Widget switchList(
      bool filterType, String title, String subTitle, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: filterType,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Settings'),
        actions: [
          IconButton(
            onPressed: () {
              var filterMap = {
                '_glutenFree': _glutenFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan,
                'lactose': _lactoseFree
              };

              widget.handleFilter(filterMap);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.topCenter,
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              switchList(
                  _glutenFree, 'Glutenn-free', 'Only include gluten-free meals',
                  (new_value) {
                //so the newValue is the value the switch have after being tapped and therefore inside  I can use setState where I set my gluten free boolean wqual to the new value to reflect the change
                setState(() {
                  _glutenFree = new_value;
                });
              }),
              switchList(
                  _vegetarian, 'Vegetarian', 'Only include vegetarian meals',
                  (new_value) {
                //so the newValue is the value the switch have after being tapped and therefore inside  I can use setState where I set my gluten free boolean wqual to the new value to reflect the change
                setState(() {
                  _vegetarian = new_value;
                });
              }),
              switchList(_vegan, 'Vegan', 'Only include vegan meals',
                  (new_value) {
                //so the newValue is the value the switch have after being tapped and therefore inside  I can use setState where I set my gluten free boolean wqual to the new value to reflect the change
                setState(() {
                  _vegan = new_value;
                });
              }),
              switchList(_lactoseFree, 'Lactose-free',
                  'Only include lactose-free meals', (new_value) {
                //so the newValue is the value the switch have after being tapped and therefore inside  I can use setState where I set my gluten free boolean wqual to the new value to reflect the change
                setState(() {
                  _lactoseFree = new_value;
                });
              }),
            ],
          )),
        ],
      ),
    );
  }
}
