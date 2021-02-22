import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/Widgets/Category%20Page%20Widgets.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CategoryPageWidgets.appBar(),
        body: Container(
          margin: EdgeInsets.only(right: 15, left: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CategoryPageWidgets()
                    .textField(context),
                SizedBox(
                  height: 20,
                ),
                CategoryPageWidgets().staggeredGridView(),
                // HomePageWidgets().prevNextPageButton(),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }
}