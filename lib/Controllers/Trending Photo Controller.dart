import 'package:flutter_wallpaper_app/Models/Trending%20Wallpaper%20Model.dart';
import 'package:flutter_wallpaper_app/Services/Api%20Services.dart';
import 'package:get/get.dart';

class TrendingPhotoController extends GetxController{
  var isLoading = true.obs;
  var photoList = List<Photo>().obs;

  @override
  void onInit() {
    fetchPhotos();
    super.onInit();
  }

  void fetchPhotos() async {
    isLoading(true);
    try {
      var photos = await ApiServices.getTrendingPhotos();
      if(photos != null) {
        photoList.assignAll(photos);
      }
    }
    catch(Exception) {
      print(Exception);
    }
    finally {
      isLoading(false);
    }
  }
}