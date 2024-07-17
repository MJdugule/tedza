
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

 

  Future getCurrentUser(){
    return NetworkService().getCurrentUser();
  }
  
  Future updateUserProfile(firstNmame, lastName, phoneNumber){
    return NetworkService().updateUserProfile(firstNmame, lastName, phoneNumber);
  }

  Future signOutUser() {
    return NetworkService().logoutUser();
  } 
  
  Future deleteUserAccount() {
    return NetworkService().deleteUserAccount();
  }
}
