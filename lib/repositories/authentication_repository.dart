
import 'package:tedza/data/network_service.dart';
import 'package:tedza/models/auth_user.dart';

class AuthenticationRepository {
  AuthenticationRepository();
  
  Future signUpTheUser(AuthUser authUser,) {
    return NetworkService().signUpTheUser(authUser);
  }

  Future signInTheUser(AuthUser authUser) {
    return NetworkService().signInTheUser(authUser);
  }

  Future submitPasswordForForgotPassword(email, AuthUser authUser, password, confirmPassword,) {
    return NetworkService().submitPasswordForForgotPassword(email, authUser, password, confirmPassword, );
  }
  
  Future changePassword(oldPassword, newPassword, confirmPassword,) {
    return NetworkService().changePassword(
      oldPassword,
      newPassword,
      confirmPassword,
    );
  }

  Future getCurrentUser(){
    return NetworkService().getCurrentUser();
  }
  
  Future updateUserProfile(firstNmame, lastName, phoneNumber){
    return NetworkService().updateUserProfile(firstNmame, lastName, phoneNumber);
  }
  Future updateUserFcmToken(token){
    return NetworkService().updateUserFcmToken(token);
  }

  // Future validateOtpForForgotPassword(String email, String otp) {
  //   return NetworkService().forgotPasswordOtpVerification(email, otp);
  // }

  // Future changePasswordForForgotPassword(String password) {
  //   return NetworkService().forgotPasswordChange(password);
  // }

  // Future changePassword(String oldPassword, String newPassword, String userId) {
  //   return NetworkService().changePassword(oldPassword, newPassword, userId);
  // }

  Future signOutUser() {
    return NetworkService().logoutUser();
  } 
  
  Future deleteUserAccount() {
    return NetworkService().deleteUserAccount();
  }
}
