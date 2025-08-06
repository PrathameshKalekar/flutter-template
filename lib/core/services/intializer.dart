import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import 'api_service.dart';

class Initializer {
   init() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => ApiService(appBaseUrl: Constants.baseUrl, sharedPreferences: sharedPreferences));
   try {
    Get.lazyPut(()=> ApiService(appBaseUrl: Constants.baseUrl, sharedPreferences: Get.find()));
    //Initialize Repositories
    

    //Initialize Controllers
   } catch (e) {
    log("******* ${e.toString()} **********",name: "Error in Initializer");
   }
   }

}