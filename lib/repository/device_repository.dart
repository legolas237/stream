import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

class DeviceRepository {
  static late DeviceInfoPlugin _deviceInfoPlugin;

  static late Map<String, dynamic> _deviceInfo;
  static Map<String, dynamic> get deviceInfo => _deviceInfo;

  static Future<void> initForPlatform() async {
    _deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        DeviceRepository._readAndroidBuildData(
            await _deviceInfoPlugin.androidInfo,
        );
      } else if (Platform.isIOS) {
        DeviceRepository._readIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      _deviceInfo['Error'] = 'Failed to get platform version.';
    }
  }

  static void _readAndroidBuildData(AndroidDeviceInfo build) {
    _deviceInfo = <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  static void _readIosDeviceInfo(IosDeviceInfo data) {
    _deviceInfo = <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  static String deviceId() {
    var result = '';

    try {
      if (Platform.isAndroid) {
        result = "${_deviceInfo['id']}_${_deviceInfo['model']}";
      } else if (Platform.isIOS) {
        result = "${_deviceInfo['name']}_${_deviceInfo['model']}_${_deviceInfo['identifierForVendor']}";
      }
    } on PlatformException {
      result = '';
    }

    return result;
  }

  static String osRelease() {
    var result = '';

    try {
      if (Platform.isAndroid) {
        result = "Android ${_deviceInfo['version.release']} (SDK ${_deviceInfo['version.sdkInt']})";
      } else if (Platform.isIOS) {
        result = "IOS ${_deviceInfo['systemName']}";
      }
    } on PlatformException {
      result = '';
    }

    return result;
  }

  static String deviceFullName() {
    var result = '';

    try {
      if (Platform.isAndroid) {
        result = "${_deviceInfo['brand']} ${_deviceInfo['model']}";
      } else if (Platform.isIOS) {
        result = "${_deviceInfo['name']} ${_deviceInfo['model']}";
      }
    } on PlatformException {
      result = '';
    }

    return result;
  }

  static String deviceName() {
    var result = '';

    try {
      if (Platform.isAndroid) {
        result = _deviceInfo['brand'];
      } else if (Platform.isIOS) {
        result = _deviceInfo['name'];
      }
    } on PlatformException {
      result = '';
    }

    return result;
  }

  static String deviceModel() {
    var result = '';

    try {
      if (Platform.isAndroid) {
        result = _deviceInfo['model'];
      } else if (Platform.isIOS) {
        result = _deviceInfo['model'];
      }
    } on PlatformException {
      result = '';
    }

    return result;
  }
}
