import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wallpaper_app/Controllers/Photo%20Controller.dart';
import 'package:flutter_wallpaper_app/Screens/Details%20Page.dart';
import 'package:get/get.dart';

class SearchPageWidgets {
  // AppBar
  static Widget appBar() {
    return AppBar(
      centerTitle: true,
      title: RichText(
          text: TextSpan(
              text: "Flutter ",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              children: [
            TextSpan(
                text: "Wallpaper",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))
          ])),
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  //TextField
  TextEditingController controller = TextEditingController();
  Widget textField(context, String value) {
    controller.text = value;
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    photoController.fetchSearchedPhotos(controller.text);
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
          ),
          hintText: "Search Wallpapers...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onSubmitted: (value) {
        if (controller.text.isNotEmpty) {
          FocusScope.of(context).requestFocus(FocusNode());
          photoController.fetchSearchedPhotos(value);
        }
        FocusScope.of(context).requestFocus(FocusNode());
      },
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.search,
      autofocus: false,
    );
  }

  //StaggeredGridView
  String searchKey;
  final PhotoController photoController = Get.put(PhotoController());
  Widget staggeredGridView() {
    return Obx(() {
      if (photoController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (photoController.searchList.isEmpty) {
        return Text("No Search Results. Try using any other keyword.");
      } else {
        return Column(
          children: [
            Text('Search Results for \"${photoController.searchKey}\"'),
            StaggeredGridView.countBuilder(
                itemCount: photoController.searchList.length,
                padding: EdgeInsets.all(10),
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Get.to(() => DetailsPage(),
                            arguments: photoController.searchList[index]);
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Hero(
                            tag: photoController.searchList[index],
                            child: CachedNetworkImage(
                                imageUrl:
                                    "${photoController.searchList[index].src.medium}"),
                          )));
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.fit(1);
                }),
          ],
        );
      }
    });
  }

  // Prev/Next Page Button
  // Widget prevNextPageButton() {
  //   return Obx(() => photoController.page.value != 0
  //       ? Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             photoController.page.value != 1
  //                 ? OutlineButton(
  //                     onPressed: () {},
  //                     child: Row(
  //                       children: [
  //                         Icon(Icons.navigate_before),
  //                         Text('Prev Page')
  //                       ],
  //                     ),
  //                   )
  //                 : Container(),
  //             OutlineButton(
  //               onPressed: () {},
  //               child: Row(
  //                 children: [Text('Next Page'), Icon(Icons.navigate_next)],
  //               ),
  //             )
  //           ],
  //         )
  //       : Container());
  // }
}
