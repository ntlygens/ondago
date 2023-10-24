import 'dart:ui' as ui;

class DeviceDetect {
  late bool isTablet;
  late bool isPhone;

  final double devicePixelRatio = ui.window.devicePixelRatio;
  final ui.Size dSize = ui.window.physicalSize;

  bool getDeviceType() {
    double width = dSize.width;
    double height = dSize.height;
    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    }
    else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    }
    else {
      isTablet = false;
      isPhone = true;
    }
    return isTablet;
  }

}

