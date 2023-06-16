import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/device_util.dart';

extension SizeSizeExtension on num {

  double get ww => DeviceUtil.isUsingDeskTopUI
      ? (DeviceUtil.isWebDesktop ? toDouble() * 1.1 : toDouble())
      : ScreenUtil().setWidth(this);

  double get wh => DeviceUtil.isUsingDeskTopUI
      ? (DeviceUtil.isWebDesktop ? toDouble() * 1.1 : toDouble())
      : ScreenUtil().setHeight(this);

  //height by textScaleFactor
  double get whts => DeviceUtil.isUsingDeskTopUI
      ? (DeviceUtil.isWebDesktop ? toDouble() * 1.1 : toDouble())
      : ScreenUtil().setHeight(this) * DeviceUtil.textScaleFactor;

  double get wht => DeviceUtil.isUsingDeskTopUI
      ? (DeviceUtil.isWebDesktop ? toDouble() * 1.1 : toDouble())
      : (DeviceUtil.isWebMobile
      ? this * DeviceUtil.scaleText * 1.2
      : this * DeviceUtil.scaleText);

  double get wr => ScreenUtil().radius(this);


  double get wsp => DeviceUtil.isUsingDeskTopUI
      ? (DeviceUtil.isWebDesktop ? toDouble() * 1.1 : toDouble())
      : (DeviceUtil.isWebMobile
          ? this * DeviceUtil.scaleText * 1.2
          : this * DeviceUtil.scaleText);

  double get wspn => DeviceUtil.isUsingDeskTopUI
      ? (DeviceUtil.isWebDesktop ? toDouble() : toDouble())
      : this * DeviceUtil.scaleText;

  double get wsw => ScreenUtil().screenWidth * this;

  double get wsh => ScreenUtil().screenHeight * this;
}
