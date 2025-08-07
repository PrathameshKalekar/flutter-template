import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../core/theme/app_theme.dart';

void showCustomToast({
  required String title,
  required String description,
  ToastificationType type = ToastificationType.info,
  Duration duration = const Duration(seconds: 3),
}) {
  toastification.show(
    style: ToastificationStyle.flat,
    type: type,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    description: Text(
      description,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
    autoCloseDuration: duration,
    alignment: Alignment.topCenter,
    backgroundColor: Colors.transparent,
    showProgressBar: true,
    applyBlurEffect: true,
    progressBarTheme: ProgressIndicatorThemeData(
      refreshBackgroundColor: Colors.transparent,
      color: primaryColor,
      linearMinHeight: 2,
    ),
  );
}

// Convenience methods for different toast types
void showSuccessToast({required String title, required String description, Duration? duration}) {
  showCustomToast(
    title: title,
    description: description,
    type: ToastificationType.success,
    duration: duration ?? const Duration(seconds: 2),
  );
}

void showErrorToast({required String title, required String description, Duration? duration}) {
  showCustomToast(
    title: title,
    description: description,
    type: ToastificationType.error,
    duration: duration ?? const Duration(seconds: 3),
  );
}

void showInfoToast({required String title, required String description, Duration? duration}) {
  showCustomToast(
    title: title,
    description: description,
    type: ToastificationType.info,
    duration: duration ?? const Duration(seconds: 3),
  );
}

void showWarningToast({required String title, required String description, Duration? duration}) {
  showCustomToast(
    title: title,
    description: description,
    type: ToastificationType.warning,
    duration: duration ?? const Duration(seconds: 3),
  );
}
