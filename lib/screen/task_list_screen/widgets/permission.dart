import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> storagePermission() async {
  final DeviceInfoPlugin info =
      DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';
  final AndroidDeviceInfo androidInfo = await info.androidInfo;
  final double androidVersion =
      double.parse(androidInfo.version.release.toString());

  bool havePermission = false;

  if (androidVersion >= 13) {
    final request = await [
      // Permission.storage,
      Permission.manageExternalStorage,
    ].request(); //import 'package:permission_handler/permission_handler.dart';

    havePermission =
        request[Permission.manageExternalStorage] == PermissionStatus.granted;
  } else {
    final status = await Permission.storage.request();
    havePermission = status.isGranted;
  }

  if (!havePermission) {
    // if no permission then open app-setting
    // await openAppSettings();
  }

  return havePermission;
}

Future<bool> permission() async {
  final permission = await storagePermission();
  if (permission == false) {
    notficationError();
    return false;
  } else {
    return true;
  }
}

void notficationError({String? message}) {
  Get.snackbar(
    'خطا',
    message ?? 'دسترسی به حافظه امکان‌پذیر نیست',
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black87,
    borderColor: Colors.red,
    borderWidth: 3,
    borderRadius: 10,
    margin: const EdgeInsets.all(2),
    icon: const Icon(
      Icons.error_outline,
      color: Colors.red,
      size: 35,
    ),
    snackStyle: SnackStyle.FLOATING,
  );
}

void notficationSuccess([String? message]) {
  Get.snackbar(
    'موفق',
    message ?? 'عملیات با موفقیت انجام شد',
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black87,
    borderColor: Colors.green,
    borderWidth: 3,
    borderRadius: 10,
    margin: const EdgeInsets.all(4),
    icon: const Icon(
      Icons.check_circle_outline,
      color: Colors.green,
      size: 35,
    ),
    snackStyle: SnackStyle.FLOATING,
  );
}
