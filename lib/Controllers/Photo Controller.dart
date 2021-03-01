import 'package:flutter_wallpaper_app/Models/Wallpaper%20Model.dart';
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
  var homeNextPageUrl;
  var categoryNextPageUrl;
  var searchNextPageUrl;

  @override
  void onInit() {
    var url = "https://api.pexels.com/v1/curated?page=1&per_page=50";
    fetchTrendingPhotos(url);
    super.onInit();
  }

  // Fetched Trending Photos
  Future<void> fetchTrendingPhotos(String url) async {
    isLoading(true);
    try {
      var wallpaperModel = await ApiServices().getTrendingPhotos(url);
      if (wallpaperModel != null) {
        photoList.assignAll(wallpaperModel.photos);
        homeNextPageUrl = wallpaperModel.nextPage;
        // page.value = wallpaperModel.page;
      }
    } catch (Exception) {
      Fluttertoast.showToast(msg: Exception.toString());
    } finally {
      isLoading(false);
    }
  }

  // Fetched Searched Photos
  //https://api.pexels.com/v1/search?query=$query&page=$page&per_page=50
  Future<void> fetchSearchedPhotos(url, String keyword) async {
    isLoading(true);
    try {
      var wallpaperModel = await ApiServices().getSearchPhotos(url);
      if (wallpaperModel != null) {
        searchKey.value = keyword;
        searchList.assignAll(wallpaperModel.photos);
        searchNextPageUrl = wallpaperModel.nextPage;
        // page.value = wallpaperModel.page;
      }
    } catch (Exception) {
      Fluttertoast.showToast(msg: Exception.toString());
    } finally {
      isLoading(false);
    }
  }

  // Fetched Categoriesed Photos
  Future<void> fetchCategoryPhotos(url, String categoryName) async {
    isLoading(true);
    try {
      var wallpaperModel = await ApiServices().getCategoryPhotos(url);
      if (wallpaperModel != null) {
        categoryKey.value = categoryName;
        categoryList.assignAll(wallpaperModel.photos);
        categoryNextPageUrl = wallpaperModel.nextPage;
        print("===================NEXT PAGE=====================");
        print(categoryNextPageUrl);
        print("===================NEXT PAGE=====================");
        // page.value = wallpaperModel.page;
      }
    } catch (Exception) {
      Fluttertoast.showToast(msg: Exception.toString());
    } finally {
      isLoading(false);
    }
  }
}
