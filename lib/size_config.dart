import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;

  static double? blockSizeH;
  static double? blockSizeW;
  static double? screenHeight;
  static double? screenWidth;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData!.size.height;
    screenWidth = _mediaQueryData!.size.width;
    blockSizeH = screenWidth! / 100;
    blockSizeW = screenHeight! / 100;
  }
}
