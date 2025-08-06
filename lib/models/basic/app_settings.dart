import 'package:flutter_template/core/utils/extentions.dart';

class AppSettings {
  int? appVersion;
  String? forceUpdate;
  String? maintainanceMode;
  String? appDownload;
  int? iosAppVersion;
  String? iosForceUpdate;
  String? iosMaintainanceMode;
  String? iosAppDownload;
  String? iosOnProduction;
  String? aboutUs;
  String? contactUs;
  String? privacyPolicy;
  String? termsAndCondition;

  AppSettings({
    this.appVersion,
    this.forceUpdate,
    this.maintainanceMode,
    this.appDownload,
    this.iosAppVersion,
    this.iosForceUpdate,
    this.iosMaintainanceMode,
    this.iosAppDownload,
    this.iosOnProduction,
    this.aboutUs,
    this.contactUs,
    this.privacyPolicy,
    this.termsAndCondition,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        appVersion: (json["app_version"] as String?).toInt,
        forceUpdate: json["force_update"],
        maintainanceMode: json["maintainance_mode"],
        appDownload: json["app_download"],
        iosAppVersion: (json["ios_app_version"] as String?).toInt,
        iosForceUpdate: json["ios_force_update"],
        iosMaintainanceMode: json["ios_maintainance_mode"],
        iosAppDownload: json["ios_app_download"],
        iosOnProduction: json["ios_on_production"],
        aboutUs: json["about_us"],
        contactUs: json["contact_us"],
        privacyPolicy: json["privacy_policy"],
        termsAndCondition: json["terms_and_condition"],
      );

  Map<String, dynamic> toJson() => {
        "app_version": appVersion,
        "force_update": forceUpdate,
        "maintainance_mode": maintainanceMode,
        "app_download": appDownload,
        "ios_app_version": iosAppVersion,
        "ios_force_update": iosForceUpdate,
        "ios_maintainance_mode": iosMaintainanceMode,
        "ios_app_download": iosAppDownload,
        "ios_on_production": iosOnProduction,
        "about_us": aboutUs,
        "contact_us": contactUs,
        "privacy_policy": privacyPolicy,
        "terms_and_condition": termsAndCondition,
      };
}
