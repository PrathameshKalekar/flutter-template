
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/utils/constants.dart';
import '../../widgets/custom_toast.dart';

class ServiceController extends GetxController implements GetxService{
  ServiceController();
  
  final GetConnect _connect = GetConnect();

  /// Picks an image from the given [source] (camera or gallery), requests permission for camera (and for gallery on iOS), and returns the selected [File].
  /// Only [ImageSource.camera] or [ImageSource.gallery] are allowed.
  /// Shows a toast if permission is denied or no file is selected, and returns null in such cases.
  Future<File?> pickImage({
    required ImageSource source,
    required BuildContext context,
  }) async {
    if (source != ImageSource.camera && source != ImageSource.gallery) {
      showErrorToast(
        title: "Invalid Source",
        description: "Only camera or gallery are supported.",
      );
      return null;
    }

    PermissionStatus status = PermissionStatus.granted;

    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
      if (!status.isGranted) {
        showErrorToast(
          title: "Camera Permission Denied",
          description: "Please allow camera access to take a photo.",
        );
        return null;
      }
    } else if (source == ImageSource.gallery) {
      if (GetPlatform.isIOS) {
        status = await Permission.photos.request();
        if (!status.isGranted) {
          showErrorToast(
            title: "Gallery Permission Denied",
            description: "Please allow photo access to select from gallery.",
          );
          return null;
        }
      } else {
        status = PermissionStatus.granted;
      }
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      showErrorToast(
        title: "No Image Selected",
        description: "You did not select any image.",
      );
      return null;
    }

    return File(pickedFile.path);
  }

  Future<File?> urlToFile({required String url}) async {
   final  String fileUrl; 
    if(url.contains('http')){
      fileUrl = "${Constants.appName}$url";
    } else{
      fileUrl = url;
    }
    final response = await _connect.get(fileUrl);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/${url.split('/').last}');
    final bytes = response.bodyBytes as List<int>? ?? [];
    await tempFile.writeAsBytes(bytes);
    return tempFile;
  }
  
}