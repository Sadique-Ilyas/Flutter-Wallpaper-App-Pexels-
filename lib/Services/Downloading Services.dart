import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadingServices {
  static askPermission(String url) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = await getDirectory();
      final taskId = await downloadFile(directory, url);
    } else {
      Fluttertoast.showToast(msg: "Grant Permissions for Downloading");
    }
  }

  static Future<Directory> getDirectory() async {
    return await getExternalStorageDirectory();
  }

  static Future<String> downloadFile(Directory directory, String url) async {
    return await FlutterDownloader.enqueue(
      url: url,
      savedDir: directory.path,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: 'Could not launch \"$url\"');
    }
  }
}
