import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/Screens/Home%20Page.dart';
import 'package:flutter_wallpaper_app/Screens/Intro%20Screen%20Page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> opacity;

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Get.off(() => HomePage());
    } else {
      await prefs.setBool('seen', true);
      Get.off(() => IntroScreen());
    }
  }

  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      checkFirstSeen();
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(curve: Curves.easeIn, parent: animationController));
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(),
          FadeTransition(
            opacity: opacity,
            child: Image.asset(
              "assets/logo.png",
              width: 60,
              height: 60,
            ),
          ),
          Text(
            'By pexels.com',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    ));
  }
}
