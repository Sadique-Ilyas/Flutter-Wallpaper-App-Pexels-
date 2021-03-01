import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wallpaper_app/Models/CategoryList.dart';
import 'package:flutter_wallpaper_app/Controllers/Photo%20Controller.dart';
import 'package:flutter_wallpaper_app/Models/Categories.dart';
import 'package:flutter_wallpaper_app/Screens/Category%20page.dart';
import 'package:flutter_wallpaper_app/Screens/Details%20Page.dart';
import 'package:flutter_wallpaper_app/Screens/Search%20Page.dart';
import 'package:get/get.dart';

class HomePageWidgets {
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
                text: "Pexels",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))
          ])),
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
                  if (controller.text.isNotEmpty) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Get.to(() => SearchPage(), arguments: controller.text);
                    var url =
                        "https://api.pexels.com/v1/search?query=${controller.text}&per_page=50";
                    photoController.fetchSearchedPhotos(url, controller.text);
                    controller.clear();
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                }),
          ),
          hintText: "Search Wallpapers...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onSubmitted: (value) {
        if (controller.text.isNotEmpty) {
          FocusScope.of(context).requestFocus(FocusNode());
          Get.to(() => SearchPage(), arguments: controller.text);
          var url = "https://api.pexels.com/v1/search?query=$value&per_page=50";
          photoController.fetchSearchedPhotos(url, value);
          controller.clear();
        }
        FocusScope.of(context).requestFocus(FocusNode());
      },
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.search,
      autofocus: false,
    );
  }

  //Horizontal ListView
  Widget horizontalListView() {
    List<Categories> _list = CategoryList.categoriesList;
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.to(() => CategoryPage(), arguments: _list[index].categoryName);
            var url =
                "https://api.pexels.com/v1/search?query=${_list[index].categoryName}&per_page=50";

            photoController.fetchCategoryPhotos(url, _list[index].categoryName);
          },
          child: Container(
            alignment: Alignment.center,
            height: 20,
            width: 70,
            margin: EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    _list[index].categoryImage,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    _list[index].categoryName,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: _list.length,
    );
  }

  //StaggeredGridView
  final PhotoController photoController = Get.put(PhotoController());
  Widget staggeredGridView() {
    return Obx(() {
      if (photoController.isLoading.value) {
        return SpinKitRipple(color: Colors.blue);
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

  Future<void> nextPage() async {
    return await photoController
        .fetchTrendingPhotos(photoController.homeNextPageUrl);
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
