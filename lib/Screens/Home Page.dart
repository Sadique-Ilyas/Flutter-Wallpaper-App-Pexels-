import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/Widgets/Widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Widgets.appBar(),
        body: Container(
          margin: EdgeInsets.only(right: 15, left: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Widgets.textField(),
                SizedBox(
                  height: 20,
                ),
                Container(height: 40, child: Widgets.horizontalListView()),
                SizedBox(
                  height: 20,
                ),
                Widgets().gridView()
              ],
            ),
          ),
        ));
  }
}
