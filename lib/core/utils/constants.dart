import 'package:flutter/foundation.dart';

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
}
