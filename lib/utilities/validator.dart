import 'package:tedza/constants/constant.dart';

class Validator {
  String? validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Phone number is required';
    } else if (!(regexMobile.hasMatch(phoneNumber))) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return kEmptyEmailError;
    } else if (!(regexEmail.hasMatch(email))) {
      return kInvalidEmailError;
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return kEmptyPasswordError;
    }
    return null;
  }

  String? validateSolidPassword(String password, bool validity) {
    if (password.isEmpty) {
      return kEmptyPasswordError;
    } else if (validity == false) {
      return kInvalidPasswordError;
    }
    return null;
  }

  String? validateChangePassword(String password, String confirmPassword) {
    if (password.isEmpty) {
      return kEmptyPasswordError;
    } else if (confirmPassword.isNotEmpty && password != confirmPassword) {
      return kPasswordMatchError;
    }
    return null;
  }

  String? validateName(String name) {
    if (name.isEmpty) {
      return 'Name is required';
    } else if (!(regexName.hasMatch(name))) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? validateTextField(String text) {
    if (text.isEmpty) {
      return 'Field is required';
    } else if (text.length < 3) {
      return 'Text length must not be less than 3';
    }
    return null;
  }
}
