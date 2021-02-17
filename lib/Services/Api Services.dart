import 'package:flutter_wallpaper_app/Models/Trending%20Wallpaper%20Model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // Fetching Trending Photo
  static Future<List<Photo>> getTrendingPhotos() async {
    var header = {
      "Authorization":
          "563492ad6f91700001000001de5b80c374894ab99fb1321e01867559"
    };
    try {
      var response = await http.get(
          "https://api.pexels.com/v1/curated?page=1&per_page=20",
          headers: header);
      var jsonString = response.body;
      print(jsonString);
      return trendingWallpaperModelFromJson(jsonString).photos;
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }
}
