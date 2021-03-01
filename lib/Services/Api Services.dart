import 'package:flutter_wallpaper_app/Models/Wallpaper%20Model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  var header = {
    "Authorization": "563492ad6f91700001000001de5b80c374894ab99fb1321e01867559"
  };

  // Fetching Trending Photos
  Future<WallpaperModel> getTrendingPhotos(url) async {
    try {
      var response = await http.get(
          url,
          headers: header);
      var jsonString = response.body;
      return trendingWallpaperModelFromJson(jsonString);
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  // Fetching Search Photos
  Future<WallpaperModel> getSearchPhotos(url) async {
    try {
      var response = await http.get(
          url,
          headers: header);
      var jsonString = response.body;
      print(jsonString);
      return trendingWallpaperModelFromJson(jsonString);
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  // Fetching Category Photos
  Future<WallpaperModel> getCategoryPhotos(url) async {
    try {
      var response = await http.get(
          url,
          headers: header);
      var jsonString = response.body;
      print(jsonString);
      return trendingWallpaperModelFromJson(jsonString);
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }
}
