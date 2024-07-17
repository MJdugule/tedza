

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tedza/styles/themes.dart';
import 'package:tedza/utilities/app_status_bar.dart';
import 'package:tedza/utilities/pref_utils.dart';
import 'package:tedza/viewmodels/authentication_viewmodel.dart';
import 'package:tedza/viewmodels/shop_viewmodel.dart';
import 'package:tedza/views/intro_screens/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
   HttpOverrides.global = MyHttpOverride();
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtils.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //ios
      statusBarBrightness: PrefUtils.getUserThemePreference() == true
          ? Brightness.dark
          : Brightness.light,
      statusBarColor: Colors.transparent,
      //andriod
      statusBarIconBrightness: PrefUtils.getUserThemePreference() == true
          ? Brightness.light
          : Brightness.dark,
    ));

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => ThemeProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => AuthenticationProvider()),
          // ChangeNotifierProvider(
          //     create: (BuildContext context) => ChatBoxViewModel()),
          // ChangeNotifierProvider(
          //     create: (BuildContext context) => DashBoardViewModel()),
          // ChangeNotifierProvider(
          //     create: (BuildContext context) => PayBillsViewModel()),
          // ChangeNotifierProvider(
          //     create: (BuildContext context) => CheckOutViewModel()),
          ChangeNotifierProvider(
              create: (BuildContext context) => ShopViewModel()),
          //     ChangeNotifierProvider(
          //     create: (BuildContext context) => AcademyViewModel()), 
          // ChangeNotifierProvider(
          //     create: (BuildContext context) => SettingsViewModel()),ChangeNotifierProvider(
          //     create: (BuildContext context) => HomeViewModel()),
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return StatusBar(
            light: PrefUtils.getUserThemePreference() == true ? false : true,
            child: MaterialApp(
                      title: 'PerryPays',
                      debugShowCheckedModeBanner: false,
                      themeMode: themeProvider.themeMode,
                      theme: TedzaTheme.lightMode,
                      darkTheme: TedzaTheme.darkMode,
                      navigatorKey: navigatorKey,
                      scaffoldMessengerKey: scaffoldKey,
                      home: const SplashScreen())
              
          );
        });
  }
}
