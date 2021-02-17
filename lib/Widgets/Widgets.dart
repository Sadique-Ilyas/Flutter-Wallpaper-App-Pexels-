import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wallpaper_app/Controllers/Trending%20Photo%20Controller.dart';
import 'package:flutter_wallpaper_app/Screens/Details%20Page.dart';
import 'package:get/get.dart';

class Widgets {
  // AppBar
  static Widget appBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Flutter ',
            style: TextStyle(color: Colors.blue),
          ),
          Text(
            'Wallpaper ',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  //TextField
  static Widget textField() {
    return TextField(
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          hintText: "Search Wallpapers...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

  //Horizontal ListView
  static Widget horizontalListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          height: 20,
          width: 60,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(10)),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: 20,
    );
  }

  //GridView
  final TrendingPhotoController photoController =
      Get.put(TrendingPhotoController());
  Widget gridView() {
    return Obx(() {
      if (photoController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return StaggeredGridView.countBuilder(
            itemCount: photoController.photoList.length,
            padding: EdgeInsets.all(10),
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Get.to(DetailsPage(),
                        arguments: photoController.photoList[index]);
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          imageUrl:
                              "${photoController.photoList[index].src.medium}")));
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.fit(1);
            });
        // return GridView.count(
        //     shrinkWrap: true,
        //     crossAxisCount: 2,
        //     childAspectRatio: 0.6,
        //     mainAxisSpacing: 6.0,
        //     physics: ClampingScrollPhysics(),
        //     crossAxisSpacing: 6.0,
        //     children: photoController.photoList
        //         .map((photo) => InkWell(
        //               onTap: () {
        //                 Get.to(DetailsPage(), arguments: photo);
        //               },
        //               child: ClipRRect(
        //                 borderRadius: BorderRadius.circular(10),
        //                 child: Image.network(
        //                   photo.src.portrait,
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //             ))
        //         .toList());
      }
    });
  }
}
