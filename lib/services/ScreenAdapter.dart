import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  init(context) {
    ScreenUtil.init(context, designSize: const Size(750, 1334));
  }

  static height(double height) {
    return ScreenUtil().setHeight(height);
  }

  static width(double width) {
    return ScreenUtil().setWidth(width);
  }

  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }
}
