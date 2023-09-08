// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

DisplaySnackBar(BuildContext context, String content, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.white,
        onPressed: () {
          // Navigator.pop(context);
        },
      ),
    ),
  );
}

List<BoxShadow> shadow = [
  BoxShadow(
    color: Colors.green.shade300,
    blurRadius: 5,
    spreadRadius: 3,
    offset: const Offset(2, 2),
  ),
  BoxShadow(
      color: Colors.grey.shade50,
      blurRadius: 5,
      spreadRadius: 3,
      offset: const Offset(-4, -4)),
];

Future<bool> requestStoragePermission(Permission permission) async {
  // AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
  // if (build.version.sdkInt >= 30) {
  var re = await Permission.manageExternalStorage.request();
  if (re.isGranted) {
    return true;
  } else {
    return false;
  }
  // }
  // else {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result.isGranted) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }
}
