import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedza/models/auth_user.dart';

class PrefUtils {
  static PrefUtils? _prefUtils;
  static SharedPreferences? _preferences;

//keys
  static const String userFirstTimeKey = 'first_time';
  static const String userThemeKey = 'pref_theme';
  static const String userLanguageKey = 'language';
  static const String emailKey = 'emails';
  static const String walletKey = 'wallet';
  static const String userDataKey = 'user_data';
  static const String userDetails = 'user_details';
  static const String notifing = 'notify';
  static const String admin = 'admin';
  static const String currentBusinessId = 'current_business_id';

  static Future<PrefUtils?> getInstance() async {
    if (_prefUtils == null) {
      // keep local instance till it is fully initialized.
      var prefStorage = PrefUtils._();
      await prefStorage._init();
      _prefUtils = prefStorage;
    }
    return _prefUtils;
  }

  PrefUtils._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool? getIsUserFirstTimeInApp() {
    if (_preferences == null) return false;
    return _preferences!.getBool(userFirstTimeKey);
  }

  static Future<bool>? putUserFirstTimeInApp(bool userFirstTime) {
    if (_preferences == null) return null;
    return _preferences!.setBool(userFirstTimeKey, userFirstTime);
  }

  static bool? getUserThemePreference() {
    if (_preferences == null) return false;
    return _preferences!.getBool(userThemeKey) ?? false;
  }

  static Future<bool>? saveUserThemePreference(bool userTheme) {
    if (_preferences == null) return null;
    return _preferences!.setBool(userThemeKey, userTheme);
  }

  static Future<bool>? setNotification(bool notify){
     if (_preferences == null) return null;
    return _preferences!.setBool(notifing, notify);
  }
  
  static bool? getNotification(){
     if (_preferences == null) return null;
    return _preferences!.getBool(notifing) ?? false;
  }

  static saveUserLanguagePreference(String userLanguage) {
    if (_preferences == null) return null;
    return _preferences!.setString(userLanguageKey, userLanguage);
  }

  static String? getUserCurrentBusinessId() {
    if (_preferences == null) return null;
    return _preferences!.getString(currentBusinessId);
  }

  static saveUserCurrentBusinessId(String businessId) {
    if (_preferences == null) return null;
    return _preferences!.setString(currentBusinessId, businessId);
  }

  static deleteUserCurrentBusinessId() {
    if (_preferences == null) return null;
    return _preferences!.remove(currentBusinessId);
  }

  // get string
  static String getEmail() {
    if (_preferences == null) return "";
    return _preferences!.getString(emailKey) ?? "";
  }

  // put string
  static putEmail(String email) {
    if (_preferences == null) return "";
    return _preferences!.setString(emailKey, email);
  }

  static Future setUserDetails(
    String firstname,
    String lastname,
  ) async {
    await _preferences!.setString(userDataKey, '$firstname;$lastname');
  }

  static Future setUserData(String userData) async {
    await _preferences!.setString(userDetails, userData);
  }
  
  static Future setAdminData(String adminData) async {
    await _preferences!.setString(admin, adminData);
  }

  static Future setUserWallet(String userWallet) async {
    await _preferences!.setString(walletKey, userWallet);
  }

  static List<String>? getUserdetails() {
    if (_preferences == null) return null;
    String? authAndCookie = _preferences!.getString(userDataKey) ?? ' ; ';
    final firstAndLastNameList = authAndCookie.split(';');
    final firstname = firstAndLastNameList[0];
    final lastname = firstAndLastNameList[1];

    //final finalRetrievedCookie = lastname[1];
    return [firstname, lastname];
  }

  static AuthUser? getUserData() {
    if (_preferences == null) return null;
    String? authUser = _preferences!.getString(userDetails) ?? '';
    var userDecode = jsonDecode(authUser);
    var user = AuthUser.fromJson(userDecode);
    return user;
  }
  

  static void deleteUserFromWallet() {
    _preferences!.getKeys();
    for (String key in _preferences!.getKeys()) {
      if (key == walletKey) {
        _preferences!.remove(key);
      }
    
    }
  }

  // static Future<List<String>> saveUser() async {
  //   String? authAndCookie = await _storage.read(key: _authKey) ?? '';
  //   final authAndCookieList = authAndCookie.split(';');
  //   final retrievedAuthToken = authAndCookieList[0];
  //   final retrievedCookie = authAndCookieList[1];

  //   final finalRetrievedCookie = retrievedCookie[1];
  //   return [retrievedAuthToken, finalRetrievedCookie];
  // }

  // static Future saveUserInMemory(String userData) async {
  //   if (_preferences == null) return null;
  //   _preferences!.setString(userDataKey, userData);
  //   //print(userData);
  // }

  // static Future<User?> getUserFromMemory() async {
  //   // if (_preferences == null) return '';
  //   String? user = _preferences!.getString(userDataKey);

  //   var response;

  //   if (user == null) {
  //     //the userRepository caches the data so we try to get it just in case
  //     response = await NetworkHelper.getUserData();
  //     if (response['status'] == 200) {
  //       user = _preferences!.getString(userDataKey);
  //       // print('User: $user');
  //     } else {
  //       //print('User does not exist: $user');
  //       return null;
  //     }
  //   }

  //   try {
  //     //print('User****: $user');
  //     return User.fromJson(json.decode(user!));
  //   } catch (e) {
  //     print('ERROR ${e.toString()}');
  //     return null;
  //   }
  // }

  static void deleteUserFromMemory() {
    _preferences!.getKeys();
    for (String key in _preferences!.getKeys()) {
      if (key == userDataKey) {
        _preferences!.remove(key);
      }
      if (key == currentBusinessId) {
        _preferences!.remove(key);
      }
    }
  }
}
