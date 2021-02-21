import 'package:flutter_wallpaper_app/Models/Trending%20Wallpaper%20Model.dart';
import 'package:flutter_wallpaper_app/Services/Api%20Services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TrendingPhotoController extends GetxController {
  var isLoading = true.obs;
  var photoList = List<Photo>().obs;
  var searchList = List<Photo>().obs;
  var page = 0.obs;

  @override
  void onInit() {
    fetchPhotos();
    super.onInit();
  }

  void fetchPhotos() async {
    isLoading(true);
    try {
      var wallpaperModel = await ApiServices().getTrendingPhotos();
      if (wallpaperModel != null) {
        photoList.assignAll(wallpaperModel.photos);
        page.value = wallpaperModel.page;
        print("============INSIDE===================");
        print(wallpaperModel.photos);
      }
    } catch (Exception) {
      Fluttertoast.showToast(msg: Exception.toString());
    } finally {
      isLoading(false);
    }
  }

  void fetchSearchedPhotos(query) async {
    isLoading(true);
    try {
      var wallpaperModel = await ApiServices().searchPhotos(query);
      if (wallpaperModel != null) {
        searchList.assignAll(wallpaperModel.photos);
        page.value = wallpaperModel.page;
        if (wallpaperModel.photos.isEmpty) {
          print("============INSIDE=============");
          print(searchList);
        }
      }
    } catch (Exception) {
      Fluttertoast.showToast(msg: Exception.toString());
    } finally {
      isLoading(false);
    }
  }
}
