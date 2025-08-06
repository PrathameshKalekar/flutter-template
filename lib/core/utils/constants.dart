import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Constants {
  static const bool isProduction = true;
  static String get baseUrl {
    if (kReleaseMode || isProduction) return "https://api.example.com";
    return "https://api.example.com";
  }

  static const String appName = "App Name";

  //Basic API Endpoints
  static const String appSettings = "/app-settings";

  //Shared Preferences Keys
  static const String userToken = "userToken";

  //Numerical Constants
  static const screenPadding = EdgeInsets.symmetric(horizontal: 16,vertical: 12);
  static const width12 = SizedBox(width: 12);
  static const width16 = SizedBox(width: 16);
  static const width20 = SizedBox(width: 20);
  static const height12 = SizedBox(height: 12);
  static const height16 = SizedBox(height: 16);
  static const height20 = SizedBox(height: 20);
}
