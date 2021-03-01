import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/Widgets/Search%20Page%20Widgets.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword;
  @override
  void initState() {
    keyword = Get.arguments.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: SearchPageWidgets.appBar(),
        body: RefreshIndicator(
          onRefresh: () {
            return SearchPageWidgets().nextPage();
          },
          child: Container(
            margin: EdgeInsets.only(right: 15, left: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SearchPageWidgets().textField(context, keyword),
                  SizedBox(
                    height: 20,
                  ),
                  SearchPageWidgets().staggeredGridView(),
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
