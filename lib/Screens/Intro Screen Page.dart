import 'package:flutter_wallpaper_app/Controllers/Intro%20Screen%20Controller.dart';
import 'package:flutter_wallpaper_app/Screens/Home%20Page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final controller = IntroScreenController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          controller: controller.pageController,
          onPageChanged: controller.selectedPageIndex,
          itemCount: controller.listPagesViewModel.length,
          itemBuilder: (context, index) {
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      controller.listPagesViewModel[index].image,
                      width: index == 0 ? 300 : 400,
                      height: index == 0 ? 300 : 400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(controller.listPagesViewModel[index].title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.listPagesViewModel[index].body,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                            children: List.generate(
                                controller.listPagesViewModel.length,
                                (index) => Obx(() => Container(
                                      margin: EdgeInsets.all(5),
                                      width:
                                          controller.selectedPageIndex.value ==
                                                  index
                                              ? 15
                                              : 10,
                                      height:
                                          controller.selectedPageIndex.value ==
                                                  index
                                              ? 15
                                              : 10,
                                      decoration: BoxDecoration(
                                          color: controller.selectedPageIndex
                                                      .value ==
                                                  index
                                              ? Colors.blue
                                              : Colors.grey,
                                          shape: BoxShape.circle),
                                    )))),
                        Obx(() => controller.isLastPage
                            ? RaisedButton(
                                onPressed: () {
                                  Get.off(() => HomePage());
                                },
                                color: Colors.blue,
                                child: Text(
                                  'Done',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : RaisedButton(
                                onPressed: controller.nextPage,
                                color: Colors.blue,
                                child: Text(index == 0 ? "Start" :
                                  'Next',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
