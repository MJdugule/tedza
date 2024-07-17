import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//colors

class AppColor {
  AppColor._();

  static const kWhiteColor = Colors.white;
  static const kBackgroundColor = Color(0XFFD2120F);
  static const kActiveCircleColor = Color(0XFF2D2B2E);
  static const kInactiveCircleColor = Color(0XFF2D2B2E);

  static const kGreyNeutral = MaterialColor(0XFF000000, {
    50: Color(0xFFFFFFFF),
    100: Color(0xFFF2F4F7),
    200: Color(0xFFEAECF0),
    300: Color(0xFFC4C4C4),
    400: Color(0xFF98A2B3),
    500: Color(0xFF667085),
    600: Color(0xFF475467),
    700: Color(0xFF344054),
    800: Color(0xFF1D2939),
    900: Color(0xFF000000),
  });

  static const kPrimaryColor = MaterialColor(
    0xFF0057FD,
    {
      50: Color(0xFFCCDDFF),
      100: Color(0xFF99BCFE),
      200: Color(0xFF669AFE),
      300: Color(0xFF669AFE),
      400: Color(0xFF3379FD),
      500: Color(0xFF0046CA),
      600: Color(0xFF003498),
      700: Color(0xFF002365),
      800: Color(0xFF001A4C),
      900: Color(0xFF001133),
    },
  );

  static const kErrorColor = MaterialColor(
    0xFFF80000,
    {
      200: Color(0xFFF0B0AF),
      400: Color(0xFFE1615F),
      600: Color(0xFFD93937),
      800: Color(0xFFD2120F),
      1000: Color(0xFFF80000),
    },
  );

  static const kSuccessColor = MaterialColor(
    0xFF008000,
    {
      200: Color(0xFFCCE6CC),
      400: Color(0xFF80BF80),
      600: Color(0xFF2B952B),
      800: Color(0xFF006B00),
      900: Color(0xFF004000),
    },
  );
}

const Color kMainColorDark = Color(0xFF0057FD);
const Color kMainColorLight = Color(0xFF0057FD);
const Color kMainColorFade = Color(0xFFf1e7fe);
const Color kSecondaryColorLight = Color(0xFF03dac5);
const Color kSecondaryColorDark = Color(0xFF018786);
const Color kDarkGrey = Color(0xFF3e3e3e);
const Color kDeepGrey = Color(0xFF7b7b7b);
const Color kMediumGrey = Color(0xFFd4d2db);
const Color kLightWhite = Color(0x80FFFFFF);
const Color kWhite = Color(0xFFFFFFFF);
const Color kWhiteTwo = Color(0xFFFAFAFA);
const Color kLightGrey = Color(0xFFF5F5F5);
const Color kLightGreyTwo = Color(0xFFFAF9F9);
const Color kLightGreyThree = Color(0xFFe5e5e5);
const Color kShadowColor = Color(0xFFB0cce1);
const Color kGrey = Color(0xFFC5C5C5);
const Color kLightBlack = Color(0xFF191919);
const Color kBlack = Color(0xFF000000);
const Color kRed = Color(0xFFFF4949);
const Color kGreen = Color(0xFF13ce66);
const Color kOrange = Color(0xFFffc82c);
const Color kBlue = Color(0xFF1fb6ff);

// Padding
const double kPaddingTwo = 2.0;
const double kPaddingFOUR = 4.0;
const double kPaddingFIVE = 5.0;
const double kPaddingSIX = 6.0;
const double kPaddingXXS = 8.0;
const double kPaddingSS = 10.0;
const double kPaddingS = 12.0;
const double kPaddingThirteen = 13.0;
const double kPaddingM = 14.0;
const double kPaddingMM = 16.0;
const double kPaddingL = 18.0;
const double kPaddingXL = 20.0;
const double kPaddingTF = 25.0;
const double kPaddingTH = 30.0;
const double kPaddingXXL = 32.0;
const double kPaddingTHIRTYFIVE = 35.0;
const double kPaddingFORTY = 40.0;
const double kPaddingF = 50.0;
const double kPaddingFF = 55.0;
const double kPaddingSIXTY = 60.0;
const double kPaddingXXXL = 65.0;
const double kPaddingSF = 75.0;
const double kPaddingE = 80.0;
const double kPaddingH = 100.0;

// Spacing
const double kSpaceXX = 5.0;
const double kSpaceXXS = 8.0;
const double kSpaceSS = 10.0;
const double kSpaceS = 12.0;
const double kSpaceM = 14.0;
const double kSpaceMM = 16.0;
const double kSpaceL = 18.0;
const double kSpaceXL = 20.0;
const double kSpaceXXL = 32.0;

//font sizes
const double kFontVVS = 8;
const double kFontVS = 10;
const double kFontXS = 11;
const double kFontSS = 12.0;
const double kFontSSS = 13.0;
const double kFontS = 14.0;
const double kFontSL = 15.0;
const double kFontXSL = 18.0;
const double kFontM = 20.0;
const double kFontL = 22.0;
const double kFontXL = 28.0;

//String formatters
final df = DateFormat('MMM dd, yyyy');
final datef = DateFormat('MMMM dd, yyyy');
final yrFormat = DateFormat('yyyy');
final timeFormat = DateFormat("HH:mm");
final formatter = NumberFormat('#,###.#');

//fontstyles
const TextStyle kLargeTextStyle = TextStyle(
  color: kBlack,
  fontSize: kFontM,
  fontWeight: FontWeight.bold,
  height: 1.3,
);

const TextStyle kLargeTextStyleDark = TextStyle(
  color: kWhiteTwo,
  fontSize: kFontM,
  fontWeight: FontWeight.bold,
  height: 1.3,
);

const TextStyle kRegularTextStyle = TextStyle(
  color: kDarkGrey,
  fontSize: kFontSL,
  fontWeight: FontWeight.w400,
  height: 1.3,
);

const TextStyle kRegularTextStyleDark = TextStyle(
  color: kLightGreyThree,
  fontSize: kFontSL,
  fontWeight: FontWeight.w400,
  height: 1.3,
);

const TextStyle kSmallTextStyle = TextStyle(
  color: kGrey,
  fontSize: kFontSS,
  fontWeight: FontWeight.w700,
  height: 1.0,
);

const TextStyle kFormHeaderTextStyle = TextStyle(
  fontFamily: 'Poppins',
  color: kDarkGrey,
  fontSize: kFontS,
  fontWeight: FontWeight.w700,
  height: 1.3,
);

const TextStyle kFormHeaderTextStyleDark = TextStyle(
  color: kLightGreyTwo,
  fontSize: kFontS,
  fontWeight: FontWeight.w700,
  height: 1.3,
);

const TextStyle kVerySmallTextStyle = TextStyle(
  color: kDeepGrey,
  fontSize: kFontXS,
  fontWeight: FontWeight.w400,
  height: 1.0,
);

const TextStyle kLargeTextStyleTwo = TextStyle(
  color: kBlack,
  fontSize: kFontM,
  fontWeight: FontWeight.w500,
  height: 1.2,
);

const TextStyle kLargeTextStyleDarkTwo = TextStyle(
  color: kWhiteTwo,
  fontSize: kFontM,
  fontWeight: FontWeight.w500,
  height: 1.2,
);

const TextStyle kBottomBarText = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    fontSize: kFontXS,
    height: 1.2,
    color: kLightBlack,
    letterSpacing: 0);

const TextStyle kBottomBarTextDark = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    fontSize: kFontXS,
    height: 1.2,
    color: kWhite,
    letterSpacing: 0);

const TextStyle kErrorTextStyle = TextStyle(
  color: kRed,
  fontSize: kFontXS,
  fontWeight: FontWeight.w400,
  height: 1.0,
);

//assets
const String kSplash = 'assets/icons/idea.svg';
const String kLogo = 'assets/icons/billing_logo.svg';
const String kEmptyFolder = 'assets/images/emptyFolder.png';
const String kSlider1 = 'assets/images/slide1.png';
const String kBlackCap = 'assets/images/bCap.png';
const String kGreyCap = 'assets/images/greyCap.png';
const String kHand = 'assets/images/handBand.png';
const String kBucketCap = 'assets/images/bucketCap.png';
const String kvideoBanner = 'assets/images/videoBanner.png';
const String kvBanner1 = 'assets/images/vBanner1.png';
const String kvBanner2 = 'assets/images/vBanner2.png';
const String kvBanner3 = 'assets/images/vBanner3.png';
const String klike = 'assets/images/like.png';
const String kdislike = 'assets/images/dislike.png';
const String ksuccess = 'assets/images/success.png';
const String kSummitSuccesss = 'assets/images/summitsuccess.svg';
const String kSlider2 = 'assets/images/slide2.png';
const String kSlider3 = 'assets/images/brownCard.png';

//animations
const kDuration = Duration(milliseconds: 300);
const kCurve = Curves.ease;

//Horizontal Spacing
Widget horizontalSpaceTiny = const SizedBox(width: 5.0);
Widget horizontalSpaceSmall = const SizedBox(width: 10.0);
Widget horizontalSpaceRegular = const SizedBox(width: 18.0);
Widget horizontalSpaceMedium = const SizedBox(width: 25.0);
Widget horizontalSpaceLarge = const SizedBox(width: 50.0);

// Vertical Spacing
Widget verticalSpaceTiny = const SizedBox(height: 5.0);
Widget verticalSpaceSmall = const SizedBox(height: 10.0);
Widget verticalSpaceRegular = const SizedBox(height: 18.0);
Widget verticalSpaceMedium = const SizedBox(height: 25);
Widget verticalSpaceLarge = const SizedBox(height: 50.0);
Widget verticalSpaceMassive = const SizedBox(height: 120.0);

//default safearea
EdgeInsets safeAreaPadding =
    EdgeInsets.fromLTRB(16, 50, 16, Platform.isIOS ? 30 : 0);


//auth validator strings
final RegExp regexEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
final RegExp regexNumber = RegExp(r'\d');
final RegExp regexUpperCase = RegExp(r'[A-Z]');
final RegExp regexSpecialCharacter = RegExp(r'[_!@#$%&*.~?]');
final RegExp regexMobile = RegExp(r'(^[0-9]{10,12}$)');
final RegExp regexName = RegExp(r'^[A-Za-z ]+$');
final RegExp regexStreetName = RegExp(r'^[A-Za-z0-9, ]+$');
final RegExp regexOTP = RegExp(r'[0-9,\b]');
final RegExp regexZip =
    RegExp(r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$", caseSensitive: false);
const String kEmptyEmailError = 'Email is required';
const String kInvalidEmailError = 'Please enter a valid email address';
const String kEmptyPasswordError = 'Password is required';
const String kInvalidPasswordError = 'Please enter a valid password';
const String kPasswordMatchError = 'Passwords do not match';
const String kUserExists =
    "User already registered, \nPlease provide valid credentials.";
const String kUnknownErrorOccured =
    "An unknown error occured, \ntry again later.";
const String kOtpInvalid = "OTP is invalid, please check \nand try again.";
const String kInvalidCredentials =
    'Unable to sign in with provided \ncredentials';
const String kInvalidEmail = 'Email is incorrect';
const String kInvalidUser = 'User does not exist';
const String kRequestFailed = 'Request failed, please \ntry again later.';
const String kSuccessOtp = 'OTP has been sent successfully.';
const String kFailedPasswordChange = 'Password could not be changed.';
const String kInternetErrorMessage =
    'Please check your internet connection and try again';

List carouselList = [
  kSlider1,
  kSlider1,
  kSlider2,
  kSlider3,
];



