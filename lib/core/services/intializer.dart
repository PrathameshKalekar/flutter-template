import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/basic/basic_controller.dart';
import '../../controllers/service/service_controller.dart';
import '../../repositories/basic/basic_repo.dart';
import '../utils/constants.dart';
import 'api_service.dart';

class Initializer {
   init() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => ApiService(appBaseUrl: Constants.baseUrl, sharedPreferences: sharedPreferences));
   try {
    Get.lazyPut(()=> ApiService(appBaseUrl: Constants.baseUrl, sharedPreferences: Get.find()));
    //Initialize Repositories
    Get.lazyPut(()=> BasicRepo(apiService: Get.find()));

    //Initialize Controllers
    Get.lazyPut(()=> BasicController(basicRepo: Get.find()));
    Get.lazyPut(()=> ServiceController());
   } catch (e) {
    log("******* ${e.toString()} **********",name: "Error in Initializer");
   }
   }

}