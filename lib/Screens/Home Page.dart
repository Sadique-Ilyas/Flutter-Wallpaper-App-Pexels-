import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/Widgets/Home%20Page%20Widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: HomePageWidgets.appBar(),
        body: RefreshIndicator(
          onRefresh: () {
            return HomePageWidgets().nextPage();
          },
          child: Container(
            margin: EdgeInsets.only(right: 15, left: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomePageWidgets().textField(context),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 40,
                      child: HomePageWidgets().horizontalListView()),
                  SizedBox(
                    height: 20,
                  ),
                  HomePageWidgets().staggeredGridView(),
                  // HomePageWidgets().prevNextPageButton(),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
