import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/Models/Wallpaper%20Model.dart';
import 'package:flutter_wallpaper_app/Widgets/Details%20Page%20Widgets.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Photo photo = Photo();
  @override
  void initState() {
    photo = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        DetailsPageWidgets.backgroundImage(photo),
        InkWell(
          onTap: () async {
            await DetailsPageWidgets().showBottomSheets(photo);
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.keyboard_arrow_up_outlined, color: Colors.white),
                Text('Show Details',
                    style: TextStyle(
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
