import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/utils/extentions.dart';
import 'package:flutter_template/core/utils/helpers.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/constants.dart';
import '../custom_button.dart';
import '../custom_toast.dart';

showPermissionDialog(BuildContext context, Permission permission) {
  showDialog(
    context: context,
    builder: (context) => PermissionDialog(permission: permission),
  );
}

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key, required this.permission});
  final Permission permission;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: white,
      child: Padding(
        padding: Constants.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Permission Request",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 12),
            Text(
              '"${Constants.appName}" needs access to your ${permission.toString().split(".").last.toCapitalize} to continue this action',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () {
                      Helper(context).pop();
                    },
                    type: ButtonType.secondary,
                    title: "Cancel",
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                                         onTap: () async {
                       final permissionName = permission.toString().split(".").last;
                       log('🔐 Permission Request: $permissionName - Starting permission check', name: 'PermissionRequest');
                       
                       final status = await permission.status;
                       log('🔐 Permission Status: $permissionName - Current status: ${status.name}', name: 'PermissionRequest');
                       
                       if (status.isGranted) {
                         log('✅ Permission Granted: $permissionName - User already has permission', name: 'PermissionRequest');
                         showSuccessToast(
                           title: "Permission Granted",
                           description: "You can now use this feature",
                         );
                         Helper(context).pop();
                       } else if (status.isPermanentlyDenied) {
                         log('❌ Permission Permanently Denied: $permissionName - Opening app settings', name: 'PermissionRequest');
                         showErrorToast(
                           title: "Permission Required",
                           description: "Please enable permission from app settings",
                         );
                         Helper(context).pop();
                         await openAppSettings();
                         log('🔧 App Settings Opened: $permissionName - User directed to settings', name: 'PermissionRequest');
                       } else if (status.isDenied) {
                         log('⚠️ Permission Denied: $permissionName - Requesting permission', name: 'PermissionRequest');
                         final result = await permission.request();
                         log('🔐 Permission Request Result: $permissionName - Result: ${result.name}', name: 'PermissionRequest');
                         
                         if (result.isGranted) {
                           log('✅ Permission Granted: $permissionName - User granted permission', name: 'PermissionRequest');
                           showSuccessToast(
                             title: "Permission Granted",
                             description: "You can now use this feature",
                           );
                           Helper(context).pop();
                         } else {
                           log('❌ Permission Still Denied: $permissionName - User denied permission', name: 'PermissionRequest');
                           showErrorToast(
                             title: "Permission Denied",
                             description: "This feature requires permission to work",
                           );
                         }
                       } else if (status.isRestricted) {
                         log('🚫 Permission Restricted: $permissionName - System restricted access', name: 'PermissionRequest');
                         showErrorToast(
                           title: "Permission Restricted",
                           description: "Permission is restricted by system settings",
                         );
                         Helper(context).pop();
                       } else if (status.isLimited) {
                         log('📱 Permission Limited: $permissionName - Limited access granted', name: 'PermissionRequest');
                         showInfoToast(
                           title: "Limited Access",
                           description: "You have limited access to this feature",
                         );
                         Helper(context).pop();
                       } else {
                         log('❓ Unknown Permission Status: $permissionName - Status: ${status.name}', name: 'PermissionRequest');
                         final result = await permission.request();
                         log('🔐 Permission Request Result: $permissionName - Result: ${result.name}', name: 'PermissionRequest');
                         
                         if (result.isGranted) {
                           log('✅ Permission Granted: $permissionName - User granted permission', name: 'PermissionRequest');
                           showSuccessToast(
                             title: "Permission Granted",
                             description: "You can now use this feature",
                           );
                           Helper(context).pop();
                         } else {
                           log('❌ Permission Denied: $permissionName - User denied permission', name: 'PermissionRequest');
                           showErrorToast(
                             title: "Permission Denied",
                             description: "This feature requires permission to work",
                           );
                         }
                       }
                     },
                    title: "Allow",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
