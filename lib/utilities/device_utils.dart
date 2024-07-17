import 'package:flutter/material.dart';

enum ScreenType { mobile, tablet, desktop }

class FormFactor {
  static double desktop = 1024;
  static double tablet = 768;
  static double handset = 425;
}

ScreenType getFormFactor(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > FormFactor.desktop) return ScreenType.desktop;
  if (deviceWidth > FormFactor.tablet) return ScreenType.tablet;
  //if (deviceWidth > FormFactor.handset) return ScreenType.Mobile;
  return ScreenType.mobile;
}

enum ScreenSize { normal, large, extraLarge }

ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > FormFactor.desktop) return ScreenSize.extraLarge;
  if (deviceWidth > FormFactor.tablet) return ScreenSize.large;
  //if (deviceWidth > 300) return ScreenSize.Normal;
  return ScreenSize.normal;
}
