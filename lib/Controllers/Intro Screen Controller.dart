import 'package:flutter/cupertino.dart';
import 'package:flutter_wallpaper_app/Models/Intro%20Page%20Model.dart';
import 'package:get/state_manager.dart';

class IntroScreenController extends GetxController {
  var selectedPageIndex = 0.obs;
  var pageController = PageController();

  bool get isLastPage =>
      selectedPageIndex.value == listPagesViewModel.length - 1;

  void nextPage() {
    if (isLastPage) {
    } else {
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  List<IntroPageModel> listPagesViewModel = [
    IntroPageModel(
        title: "QuickStart Guide",
        body: "Let's have a quickstart guide to get familiar with app",
        image: "assets/quickstart.gif"),
    IntroPageModel(
        title: "Search Wallpapers",
        body: "Search and find wallpaper of your own choice",
        image: "assets/page1.jpeg"),
    IntroPageModel(
        title: "Get Categoriesed Wallpapers",
        body:
            "Slide the list and choose a category to find wallpaper category-wise",
        image: "assets/page2.jpeg"),
    IntroPageModel(
        title: "Trending Wallpapers",
        body: "On the Home Page, you can find the Trending Wallpapers",
        image: "assets/page3.jpeg"),
    IntroPageModel(
        title: "Refresh Wallpapers Page",
        body: "Swipe Down on any Page to Refresh or get to the Next Page",
        image: "assets/page4.jpeg")
  ];
}
