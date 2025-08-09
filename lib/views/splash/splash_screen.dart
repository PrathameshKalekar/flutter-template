import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_template/core/utils/extentions.dart';
import 'package:flutter_template/widgets/custom_button.dart';
import 'package:flutter_template/widgets/image_picker_sheet.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../controllers/basic/basic_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashInit();
    });
  }

  splashInit() {
    BasicController basicController = Get.find<BasicController>();
    basicController.fetchAppSettings().then((value) async {
      if (value.isSuccess) {
        PackageInfo info = await PackageInfo.fromPlatform();
        basicController.updateAppVersionnDetails(info.version, info.buildNumber);
        if ((Platform.isIOS ? basicController.appSettings?.iosAppVersion ?? 1 : basicController.appSettings?.appVersion ?? 1) > info.buildNumber.toInt) {
          if (!mounted) return;
          //Show Update Dialog
        } else if ((Platform.isAndroid ? basicController.appSettings?.maintainanceMode : basicController.appSettings?.iosMaintainanceMode) == 'on') {
          if (!mounted) return;
          //Show Maintenance Dialog
        } else {
          //Navigation After the success
        }
      } else {
        //Show Error Toast
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            onTap: () {
              showImagePickerSheet(context);
            },
            title: "Show Image Sheet",
          )
        ],
      ),
    );
  }
}
