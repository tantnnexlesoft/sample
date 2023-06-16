
import 'dart:io';
import 'dart:math';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtil {
  static String? appVersion;
  static String? appOs;
  static String? deviceToken;
  static double scaleText = 1.0;
  static double textScaleFactor = 1.0;
  static bool isWebDesktop = false;
  static bool isTabletOrIpad = false;
  static bool isUsingDeskTopUI = false;
  static bool isUsingMobileViewOnDeskTopUI = false;
  static bool isLandscapeMode = false;
  static bool isWebMobile = false;
  static bool isSetConfigMultiPlatforms = false;
  static List<DeviceOrientation> deviceOrientation = [];

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion ??= packageInfo.version;
    return packageInfo.version;
  }

  static String getOsType() {
    var platformName = '';
    if (kIsWeb) {
      platformName = "web";
    } else {
      if (Platform.isAndroid) {
        platformName = "adr";
      } else if (Platform.isIOS) {
        platformName = "ios";
      } else if (Platform.isFuchsia) {
        platformName = "fuchsia";
      } else if (Platform.isLinux) {
        platformName = "linux";
      } else if (Platform.isMacOS) {
        platformName = "macOS";
      } else if (Platform.isWindows) {
        platformName = "windows";
      }
    }
    appOs ??= platformName;
    return platformName;
  }

  static Future<DeviceInfo> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo? iOS;
    AndroidDeviceInfo? android;
    WebDeviceInfo? webDeviceInfo;
    AndroidId? androidId;
    if (kIsWeb) {
      final packageInfo = await PackageInfo.fromPlatform();
      webDeviceInfo = WebDeviceInfo(
          appName: packageInfo.appName, appVersion: packageInfo.version);
    } else if (Platform.isIOS) {
      iOS = await deviceInfo.iosInfo;
    } else if (Platform.isAndroid) {
      android = await deviceInfo.androidInfo;
      androidId = const AndroidId();
    }
    return DeviceInfo(iOS, android, webDeviceInfo, androidId);
  }

  static void initConfigForPlatform(BoxConstraints boxConstraints) {
    if (isSetConfigMultiPlatforms) {
      return;
    }
    isWebDesktop = kIsWeb &&
        (defaultTargetPlatform != TargetPlatform.iOS &&
            defaultTargetPlatform != TargetPlatform.android);
    final size = min(boxConstraints.maxWidth, boxConstraints.maxHeight);

    if ((defaultTargetPlatform == TargetPlatform.iOS) &&
        (size >= 540 || (kIsWeb && size > 430))) {
      isTabletOrIpad = true;
    }

    if (defaultTargetPlatform == TargetPlatform.android &&
        (size >= 540 || (kIsWeb && size >= 430))) {
      //600 is not working on samsung tab a in lanscape mode
      isTabletOrIpad = true;
    }

    if ((defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) &&
        kIsWeb &&
        !isTabletOrIpad) {
      isWebMobile = true;
    }

    isUsingDeskTopUI = isWebDesktop || isTabletOrIpad;
    setPreferredOrientations();
    isSetConfigMultiPlatforms = true;
  }

  static void setPreferredOrientations() async {
    if (!isTabletOrIpad) {
      deviceOrientation = [DeviceOrientation.portraitUp];
    } else {
      deviceOrientation = [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ];
    }
    await SystemChrome.setPreferredOrientations(deviceOrientation);

  }
}


class WebDeviceInfo {
  final String appName;
  final String appVersion;
  final String platformName = "web";

  WebDeviceInfo({
    required this.appName,
    required this.appVersion,
  });
}

class DeviceInfo {
  final IosDeviceInfo? iosDeviceInfo;
  final AndroidDeviceInfo? androidDeviceInfo;
  final WebDeviceInfo? webDeviceInfo;
  final AndroidId? androidId;

  DeviceInfo(
      this.iosDeviceInfo,
      this.androidDeviceInfo,
      this.webDeviceInfo,
      this.androidId,
      );

  String? get osVersion {
    if (kIsWeb) {
      return webDeviceInfo?.appVersion;
    }
    if (Platform.isIOS) {
      return iosDeviceInfo?.systemVersion;
    } else if (Platform.isAndroid) {
      return androidDeviceInfo?.version.release;
    }
    return null;
  }

  // Future<String> getDeviceId(IStorageHelper storageHelper) async {
  //   String deviceId = "";
  //   if (kIsWeb) {
  //     deviceId = await storageHelper.getDeviceIdForWeb();
  //   } else if (Platform.isIOS) {
  //     deviceId = iosDeviceInfo?.identifierForVendor ?? "";
  //   } else if (Platform.isAndroid) {
  //     deviceId = await androidId?.getId() ?? "";
  //   }
  //   return deviceId;
  // }
}