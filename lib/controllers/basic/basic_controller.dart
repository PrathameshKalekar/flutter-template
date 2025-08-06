import 'dart:developer';

import 'package:flutter_template/models/api_service/response_mode.dart';
import 'package:flutter_template/models/basic/app_settings.dart';
import 'package:get/get.dart';

import '../../repositories/basic/basic_repo.dart';

class BasicController extends GetxController implements GetxService {
  final BasicRepo basicRepo;
  BasicController({required this.basicRepo});

  bool isLoading = false;
  String appVersion = "1.0.0";
  String buildNumber = "1";
  updateAppVersionnDetails(String appVersion, String buildNumber) {
    log("******* $appVersion **********", name: "App Version");
    log("******* $buildNumber **********", name: "Build Number");
    appVersion = appVersion;
    buildNumber = buildNumber;
    update();
  }

  AppSettings? appSettings;
  Future<ApiResponse> fetchAppSettings() async {
    isLoading = true;
    update();
    ApiResponse apiResponse;
    try {
      Response response = await basicRepo.fetchAppSettings();
      if (response.statusCode == 200) {
        appSettings = AppSettings.fromJson(response.body['data']);
        apiResponse = ApiResponse(true, response.body["message"] ?? "App Settings fetched successfully");
      } else {
        apiResponse = ApiResponse(false, response.body["message"] ?? "Something went wrong");
      }
    } catch (error) {
      apiResponse = ApiResponse(false, error.toString());
      log("******* ${error.toString()} **********", name: "Error in fetchAppSettings()");
    } finally {
      isLoading = false;
      update();
    }
    return apiResponse;
  }
}
