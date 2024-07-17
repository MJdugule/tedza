import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tedza/data/api_service.dart';
import 'package:tedza/data/api_urls.dart';
import 'package:tedza/data/server_config.dart';
import 'package:tedza/models/auth_user.dart';
import 'package:tedza/utilities/pref_utils.dart';
import 'package:tedza/utilities/user_secure_storage.dart';
import 'package:tedza/viewmodels/authentication_viewmodel.dart';

class NetworkService {
  ApiService apiService = ApiService();
  Future signUpTheUser(
    AuthUser authUser,
  ) async {
    var res = await apiService.apiInterceptor(() async {
      return await http.post(
        Uri.parse(APIPathHelper().signUpUser),
        body: {
          "name": "${authUser.firstName}${authUser.lastName}",
          "role": "customer",
          "email": authUser.email,
          "avatar": "https://picsum.photos/800",
          "password": authUser.password,
        },
      );
    });
    return res.fold((l) {
      return false;
    }, (r) async {
       PrefUtils.setUserData(r.body);
      return true;
    });
  }

  Future signInTheUser(AuthUser authUser) async {
    var response = await apiService.apiInterceptor(() async {
      return http.post(
        Uri.parse(APIPathHelper().userSignInUrl),
        body: {
          "email": authUser.email,
          "password": authUser.password,
        },
      );
    });
    return response.fold((l) => false, (r) async {

      var userResponse = jsonDecode(r.body);
      await UserSecureStorage.setUserCredentials(
          userResponse["access_token"],
          userResponse["refresh_token"]);
     
      return true;
    });
  }

  Future getCurrentUser() async {
    List<String> authKeys = await AuthenticationProvider().getUserAuthKeys();
    var response = await apiService.apiInterceptor(() async {
      return http.get(
          Uri.parse(
              "${APIPathHelper().getCurrentUser}/${PrefUtils.getUserData()!.id.toString()}"),
          headers: {
            headerKeyAuthorization: authKeys[0],
            headerRefreshToken: authKeys[1]
          });
    });
    return response.fold((l) => false, (r) async {
      // print(r.body);
      PrefUtils.setUserData(r.body);

      return true;
    });
  }

  Future updateUserProfile(firstName, lastName, phoneNumber) async {
    List<String> authKeys = await AuthenticationProvider().getUserAuthKeys();
    var response = await apiService.apiInterceptor(() async {
      return http.patch(
          Uri.parse(
              "${APIPathHelper().updateUser}/${PrefUtils.getUserData()!.id.toString()}"),
          headers: {
            headerKeyAuthorization: authKeys[0],
            headerRefreshToken: authKeys[1]
          },
          body: {
            "firstname": firstName,
            "lastname": lastName,
            "phone_no": phoneNumber,
          });
    });
    return response.fold((l) => false, (r) async {
      // print(r.body);
      PrefUtils.setUserData(r.body);

      return true;
    });
  }

  Future logoutUser() async {
    var response = await apiService.apiInterceptor(() async {
      List<String> authKeys = await AuthenticationProvider().getUserAuthKeys();
      return await http.get(Uri.parse(APIPathHelper().logoutUrl), headers: {
        headerKeyAuthorization: authKeys[0],
        headerRefreshToken: authKeys[1]
      });
    });
    return response.fold((l) => false, (r) async {
      return true;
    });
  }

  Future deleteUserAccount() async {
    var response = await apiService.apiInterceptor(() async {
      List<String> authKeys = await AuthenticationProvider().getUserAuthKeys();
      return await http.delete(
          Uri.parse(
              "${APIPathHelper().deleteUrl}/${PrefUtils.getUserData()!.id.toString()}"),
          headers: {
            headerKeyAuthorization: authKeys[0],
            headerRefreshToken: authKeys[1]
          });
    });
    return response.fold((l) => false, (r) async {
      return true;
    });
  }

  //Store
  Future getAllShopProduct() async {
    var response = await apiService.apiInterceptor(() async {
      List<String> authKeys = await AuthenticationProvider().getUserAuthKeys();
      return await http.get(Uri.parse(APIPathHelper().getAllShopProduct),
          headers: {
            headerKeyAuthorization: authKeys[0],
            headerRefreshToken: authKeys[1]
          });
    });
    return response.fold((l) => false, (r) async {
      final ppProductModel = jsonDecode(r.body);
      // print(ppProductModel);
      return ppProductModel;
    });
  }

 

}
