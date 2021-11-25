import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
          25), // i could of used padding inside gridView as it contains padding argument but i preferred to wrap it with a container as used to do
      child: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //this parameter that the gridView Takes sets up the general look of the gridView what odes that do however? Now slivers in flutter are reall just scrollable areas on the screen,Grid delegate,that simply means that for the grid this takes care about structuring layouting the grid so this task of providing a layout,MaxCrossAxisExtent simply means a preconfigured class which allows us to define a maximum width for each grid item and then it will automatically create as many columns as we can fit items with that provided width
          maxCrossAxisExtent:
              200 //this defines what is the maximum width of the single cars in pixels
          ,
          crossAxisSpacing: 20 //how much distance between our rows
          ,
          childAspectRatio: 3 /
              2 //defines how he items should be sized regarding their height width relation here 3/2 relation so for 200 width i want have 300 height
          ,
          mainAxisSpacing: 50 //how much distance between our columns
          ,
        ),
        children: DUMMY_CATEGORIES
            .map((catItem) => CategorySingleItem(
                  title: catItem.title,
                  color: catItem.color,
                  id: catItem.id,
                ))
            .toList(),
      ),
    );
  }
}
