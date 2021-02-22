import 'package:flutter_wallpaper_app/Models/Trending%20Wallpaper%20Model.dart';
import 'package:flutter_wallpaper_app/Services/Api%20Services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PhotoController extends GetxController {
  var isLoading = true.obs;
  var photoList = List<Photo>().obs;
  var searchList = List<Photo>().obs;
  var categoryList = List<Photo>().obs;
  // var page = 0.obs;
  var searchKey = "".obs;
  var categoryKey = "".obs;

  @override
  void onInit() {
    fetchTrendingPhotos();
    super.onInit();
  }

  // Fetched Trending Photos
  void fetchTrendingPhotos() async {
    isLoading(true);
    try {
      var wallpaperModel = await ApiServices().getTrendingPhotos();
      if (wallpaperModel != null) {
        photoList.assignAll(wallpaperModel.photos);
        // page.value = wallpaperModel.page;
      }
    } catch (Exception) {
      Fluttertoast.showToast(msg: Exception.toString());
    } finally {
      isLoading(false);
    }
  }

  // Fetched Searched Photos
  Future fetchSearchedPhotos(query) async {
    isLoading(true);
    try {
      var wallpaperModel = await ApiServices().getSearchPhotos(query);
      if (wallpaperModel != null) {
        searchKey.value = query;
        searchList.assignAll(wallpaperModel.photos);
        // page.value = wallpaperModel.page;
      }
    } catch (Exception) {
      Fluttertoast.showToast(msg: Exception.toString());
    } finally {
      isLoading(false);
    }
  }

  // Fetched Categoriesed Photos
  void fetchCategoryPhotos(query) async {
    isLoading(true);
    try {
      var wallpaperModel = await ApiServices().getCategoryPhotos(query);
      if (wallpaperModel != null) {
        categoryKey.value = query;
        categoryList.assignAll(wallpaperModel.photos);
        // page.value = wallpaperModel.page;
      }
    } catch (Exception) {
      Fluttertoast.showToast(msg: Exception.toString());
    } finally {
      isLoading(false);
    }
  }
}
