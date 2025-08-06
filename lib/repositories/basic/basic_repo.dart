import 'package:flutter_template/core/services/api_service.dart';
import 'package:flutter_template/core/utils/constants.dart';
import 'package:get/get.dart';

class BasicRepo {
  final ApiService apiService;
  BasicRepo({required this.apiService}); 

  Future<Response> fetchAppSettings()async => await apiService.getRequest(Constants.appSettings, "fetchAppSettings");
}