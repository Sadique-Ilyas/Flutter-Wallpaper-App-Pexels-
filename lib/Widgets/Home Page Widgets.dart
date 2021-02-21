import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wallpaper_app/Controllers/Trending%20Photo%20Controller.dart';
import 'package:flutter_wallpaper_app/Screens/Details%20Page.dart';
import 'package:flutter_wallpaper_app/Screens/Search%20Page.dart';
import 'package:get/get.dart';

class HomePageWidgets {
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
  TextEditingController controller = TextEditingController();
  Widget textField(context) {
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
                  FocusScope.of(context).requestFocus(FocusNode());
                  Get.off(() => SearchPage(), arguments: controller.text);
                  photoController.fetchSearchedPhotos(controller.text);
                  controller.clear();
                }),
          ),
          hintText: "Search Wallpapers...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onSubmitted: (value) {
        FocusScope.of(context).requestFocus(FocusNode());
        Get.off(() => SearchPage(), arguments: controller.text);
        photoController.fetchSearchedPhotos(controller.text);
        controller.clear();
      },
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.search,
      autofocus: false,
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

  //StaggeredGridView
  final TrendingPhotoController photoController =
      Get.put(TrendingPhotoController());
  Widget staggeredGridView() {
    return Obx(() {
      if (photoController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else {
        return StaggeredGridView.countBuilder(
            itemCount: photoController.photoList.length,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Get.to(() => DetailsPage(),
                        arguments: photoController.photoList[index]);
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: photoController.photoList[index],
                        child: CachedNetworkImage(
                            imageUrl:
                                "${photoController.photoList[index].src.medium}"),
                      )));
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.fit(1);
            });
      }
    });
  }

  // Prev/Next Page Button
  Widget prevNextPageButton() {
    return Obx(() => photoController.page.value != 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              photoController.page.value != 1
                  ? OutlineButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.navigate_before),
                          Text('Prev Page')
                        ],
                      ),
                    )
                  : Container(),
              OutlineButton(
                onPressed: () {},
                child: Row(
                  children: [Text('Next Page'), Icon(Icons.navigate_next)],
                ),
              )
            ],
          )
        : Container());
  }
}
