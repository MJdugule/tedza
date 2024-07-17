import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/repositories/internet_repository.dart';
import 'package:tedza/utilities/exception.dart';
import 'package:tedza/utilities/snackbar_utils.dart';
import 'package:tedza/utilities/user_secure_storage.dart';
import 'package:tedza/viewmodels/authentication_viewmodel.dart';

class ApiService {
  Future<Either<dynamic, dynamic>> apiInterceptor(Function function) async {
    await InternetChecker().checkInternetStatus();
    try {
      var response = await function.call();
      final errorMessage =
          ApiException.fromResponse(response.statusCode, response);
      if (errorMessage.toString() != "null") {
        if (errorMessage.toString().toLowerCase() == "jwt expired" ||
            errorMessage.toString().toLowerCase() ==
                "invalid or expired token") {
          AuthenticationProvider().clearAppDetaills();
          return Left(response);
        }
        showError(errorMessage.toString());
        return Left(response);
      } else {
        //  checkAndStoreToken(response);
        return Right(response);
      }
    } on SocketException {
      showError(kInternetErrorMessage);
      return const Left(null);
    } on HttpException {
      showError("Something went wrong");
      return const Left(null);
    } on FormatException {
      showError("An error occurred");
      return const Left(null);
    } on HandshakeException {
      showError("An Internet error occurred, please try again later");
      return const Left(null);
    } catch (e) {
      showError("Oops, something went wrong");
      return const Left(null);
    }
  }

  Future<Either<dynamic, dynamic>> multipartApiInterceptor(
      Function function) async {
    await InternetChecker().checkInternetStatus();
    try {
      var response = await function.call();
      var errorResponse = await response.stream.bytesToString();
      final errorMessage = ApiException.fromMultipartResponse(
          response.statusCode, errorResponse);
      if (errorMessage.toString() != "null") {
        if (errorMessage.toString().toLowerCase() == "jwt expired") {
          AuthenticationProvider().signOutUserFunction();
          return Left(response);
        }
        showError(errorMessage.toString());
        return Left(response);
      } else {
        //  checkAndStoreToken(response);
        return Right(response);
      }
    } on SocketException {
      showError(kInternetErrorMessage);
      return const Left(null);
    } on HttpException {
      showError("Something went wrong");
      return const Left(null);
    } on FormatException {
      showError("sorry, An error occurred");
      return const Left(null);
    } on HandshakeException {
      showError("An Internet error occurred, please try again later");
      return const Left(null);
    } catch (e) {
      showError("Oops, something went wrong");
      return const Left(null);
    }
  }

  checkAndStoreToken(responses) async {
    if (json.decode(responses.body)["result"] != null) {
      if (json.decode(responses.body)["result"]["token"] != null &&
          json.decode(responses.body)["result"]["refreshToken"] != null) {
        await UserSecureStorage.setUserCredentials(
            json.decode(responses.body)["result"]["token"].toString(),
            json.decode(responses.body)["result"]["refreshToken"].toString());
      }
    }
  }

  // checkForExpiredToken(response){
  //   if (response.statusCode == 498) {
  //       AuthenticationProvider().removeUserDataAfterLogout().then((value) =>
  //           navigatorKey.currentState!.pushAndRemoveUntil(
  //               MaterialPageRoute(builder: (context) => const SignInScreen()),
  //               (route) => false));
  //     }
  //      if (response.statusCode == 499) {
  //       AuthenticationProvider().removeUserDataAfterLogout().then((value) =>
  //           navigatorKey.currentState!.pushAndRemoveUntil(
  //               MaterialPageRoute(builder: (context) => const SignInScreen()),
  //               (route) => false));
  //     }
  // }

  // checkForException(response){

  //    if (response.statusCode == 200 || response.statusCode == 201) {

  //    return response;
  //   } else {
  //     if(response.statusCode == 498){
  //       return;
  //     }
  //      if(response.statusCode == 404){

  //      return;
  //     }
  //     final errorMessage = FailureException.fromError(response).toString();
  //     BPSnackBarUtilities().showSnackBar(
  //       message: errorMessage,
  //       snackbarType: SNACKBARTYPE.error,
  //     );
  //   }
  // }

  void showError(String message) {
    TZSnackBarUtilities().showSnackBar(
      message: message,
      snackbarType: SNACKBARTYPE.error,
    );
  }
}
