import 'package:flutter_wallpaper_app/Models/Trending%20Wallpaper%20Model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  var header = {
      "Authorization":
          "563492ad6f91700001000001de5b80c374894ab99fb1321e01867559"
    };
  // Fetching Trending Photo
  Future<TrendingWallpaperModel> getTrendingPhotos() async {
    try {
      var response = await http.get(
          "https://api.pexels.com/v1/curated?page=5&per_page=50",
          headers: header);
      var jsonString = response.body;
      print(jsonString);
      return trendingWallpaperModelFromJson(jsonString);
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  // Search Photos
  Future<TrendingWallpaperModel> searchPhotos(query) async {
    try {
      var response = await http.get(
          "https://api.pexels.com/v1/search?query=$query&per_page=50",
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
