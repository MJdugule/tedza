import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tedza/constants/constant.dart';
enum StatusbarType { light, dark }

extension StatusbarTypeExtension on StatusbarType {
  bool get isLight => this == StatusbarType.light;
  bool get isDark => this == StatusbarType.dark;
}

class StatusBar extends StatelessWidget {
  final bool light;
  final Widget child;
  final Color color;

  const StatusBar({
    super.key,
    required this.child,
    required this.light,
    this.color = kWhiteTwo
  });

  // const StatusBar.dark({
  //   Key? key,
  //   required this.child,
  //   this.color = AppColor.kGreyNeutral,
  //   this.statusbarType = StatusbarType.dark,
  // })  : 
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
  
    switch (light) {
      case true:
        return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark 
      .copyWith(
      
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: kWhite,
        systemNavigationBarContrastEnforced: true,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,),
      child: child,
    );
   
    
      case false:
          return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
      
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: kWhite,
        systemNavigationBarContrastEnforced: false,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,),
      child: child,
    );
    }
    
  }
}

