import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/Models/Trending%20Wallpaper%20Model.dart';
import 'package:flutter_wallpaper_app/Services/Downloading%20Services.dart';
import 'package:get/get.dart';

class DetailsPageWidgets {
  // Background Image
  static Widget backgroundImage(Photo photo) {
    return Hero(
      tag: photo,
      child: CachedNetworkImage(
        imageUrl: photo.src.portrait,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  static showBottomSheets(Photo photo) async {
    await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white70, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                height: 50,
                child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 35,
                    ),
                    onPressed: () {
                      Get.back();
                    })),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                    width: 100,
                    height: 100,
                    imageUrl: photo.src.medium,
                    fit: BoxFit.cover),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Image Dimension: ${photo.width} * ${photo.height}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        text: TextSpan(
                            text: 'Url: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                  text: '${photo.url}',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      DownloadingServices.launchURL(photo.url);
                                    }),
                            ]),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'Photographer: ${photo.photographer}',
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          color: new Color(0xFF212121),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        text: TextSpan(
                            text: 'Photographer Url: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                  text: '${photo.photographerUrl}',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      DownloadingServices.launchURL(
                                          photo.photographerUrl);
                                    }),
                            ]),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            OutlineButton(
              onPressed: () {},
              child: Text(
                ' Download ',
                style: TextStyle(color: Colors.blue),
              ),
              splashColor: Colors.green,
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      barrierColor: Colors.transparent,
    );
  }
}
