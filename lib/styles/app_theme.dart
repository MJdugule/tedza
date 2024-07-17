
import 'package:flutter/material.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/utilities/pref_utils.dart';

class AppTheme {
  AppTheme();

  final kModalStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(kPaddingMM),
    boxShadow: const [
      BoxShadow(
          offset: Offset(0, 4),
          spreadRadius: 5,
          color: Colors.black26,
          blurRadius: 10)
    ],
    color: PrefUtils.getUserThemePreference() == true ? kLightBlack : kWhiteTwo,
    shape: BoxShape.rectangle,
  );

  final kModalMarginOne = const EdgeInsets.only(
      top: kPaddingFIVE, left: kPaddingMM, right: kPaddingMM, bottom: 90);
  final kModalMarginThree = const EdgeInsets.only(
      top: kPaddingFIVE, left: kPaddingMM, right: kPaddingMM, bottom: 130);
  final kModalMarginTwo = const EdgeInsets.only(
      top: kPaddingXL, left: kPaddingMM, right: kPaddingMM, bottom: kPaddingMM);

  final kModalPaddingOne = const EdgeInsets.only(
      top: kPaddingSS, left: kPaddingMM, right: kPaddingMM, bottom: kPaddingMM);

  final kModalPaddingTwo = const EdgeInsets.only(
      top: kPaddingTF, left: kPaddingMM, right: kPaddingMM, bottom: kPaddingTF);

  final kTabPadding = const EdgeInsets.fromLTRB(
      kPaddingMM, kPaddingXL, kPaddingMM, kPaddingXXS);
  final kTabPaddingTwo =
      const EdgeInsets.fromLTRB(kPaddingMM, 0, kPaddingMM, kPaddingXXS);
  final kListPadding =
      const EdgeInsets.fromLTRB(kPaddingXL, 0, kPaddingXL, kPaddingF);
      final kListPaddingTwo =
      const EdgeInsets.fromLTRB(kPaddingXL, 0, kPaddingXL, kPaddingXL);
  final Divider kDivider = Divider(
    height: kPaddingTwo,
    thickness: 1.5,
    color:
        PrefUtils.getUserThemePreference() == true ? kDarkGrey : kMainColorFade,
  );
  final kListShape = RoundedRectangleBorder(
    side: BorderSide(
        color: PrefUtils.getUserThemePreference() == true
            ? kDarkGrey
            : kMainColorFade,
        width: 1),
    borderRadius: BorderRadius.circular(10),
  );
  TextStyle kSnackBarStyle = const TextStyle(
      fontSize: kFontS, fontWeight: FontWeight.w400, color: kWhite);
  TextStyle kSnackBarStyleTwo = const TextStyle(
      fontSize: kFontXSL, fontWeight: FontWeight.w600, color: kWhite);
}
