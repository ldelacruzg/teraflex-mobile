import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceUtil {
  static Future<String> getImei() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.androidId;
    }

    return 'no-imei';
  }
}
