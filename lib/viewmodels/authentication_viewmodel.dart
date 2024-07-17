import 'package:flutter/material.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/main.dart';
import 'package:tedza/models/auth_user.dart';
import 'package:tedza/models/validation_model.dart';
import 'package:tedza/repositories/authentication_repository.dart';
import 'package:tedza/utilities/pref_utils.dart';
import 'package:tedza/utilities/snackbar_utils.dart';
import 'package:tedza/utilities/user_secure_storage.dart';
import 'package:tedza/views/auth/auth_screen.dart';
import 'package:tedza/views/shop/shop_screen.dart';

class AuthenticationProvider extends ChangeNotifier {
  ValidationModel _email = ValidationModel(value: null, error: null);
  ValidationModel _password = ValidationModel(value: null, error: null);
  ValidationModel _oldPassword = ValidationModel(value: null, error: null);
  final ValidationModel _newPassword =
      ValidationModel(value: null, error: null);
  ValidationModel _confirmNewPassword =
      ValidationModel(value: null, error: null);
  ValidationModel _firstName = ValidationModel(value: null, error: null);
  ValidationModel _lastName = ValidationModel(value: null, error: null);
  ValidationModel _phoneNumber = ValidationModel(value: null, error: null);
  ValidationModel _otp = ValidationModel(value: null, error: null);
  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  final AuthUser _authenticationUser = AuthUser();
  String? _avatar;

  AuthUser get authenticationUser => _authenticationUser;
  ValidationModel get email => _email;
  ValidationModel get password => _password;
  ValidationModel get oldPassword => _oldPassword;
  ValidationModel get newPassword => _newPassword;
  ValidationModel get confirmNewPassword => _confirmNewPassword;
  ValidationModel get firstName => _firstName;
  ValidationModel get lastName => _lastName;
  ValidationModel get phoneNumber => _phoneNumber;
  ValidationModel get otp => _otp;
  String? get avatar => _avatar;

  bool _eightChars = false;
  bool _specialChar = false;
  bool _upperCaseChar = false;
  bool _number = false;
  bool _acceptTerms = false;

  bool get eightChars => _eightChars;
  bool get specialChar => _specialChar;
  bool get upperCaseChar => _upperCaseChar;
  bool get number => _number;
  bool get acceptTerms => _acceptTerms;

  // RecoverPasswordStepState _currentState = RecoverPasswordStepState.emailForm;
  // RecoverPasswordStepState get currentState => _currentState;

  // NotificationRepository notificationRepository = NotificationRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  bool _resendOtp = false;
  bool get resendOtp => _resendOtp;
  bool _resending = false;
  bool get resending => _resending;

  setOTP(bool resendOTP, {bool? resending}) async {
    _resendOtp = resendOTP;
    _resending = resending!;

    notifyListeners();
  }

  setAvatar(String avatar) async {
    _avatar = avatar;

    notifyListeners();
  }

  checkPasswordValidation(String passwordText) {
    _eightChars = passwordText.length >= 8;
    _number = passwordText.contains(regexNumber, 0);
    _upperCaseChar = passwordText.contains(regexUpperCase, 0);
    // _specialChar =
    //     passwordText.isNotEmpty && passwordText.contains(regexSpecialCharacter);
    notifyListeners();
  }

  bool get validPassword {
    return _eightChars && _number && _upperCaseChar;
  }

  void validateSignUpPassword(String passwordText) {
    if (passwordText.isEmpty) {
      _password = ValidationModel(value: null, error: kEmptyPasswordError);
    } else if (validPassword == false) {
      _password = ValidationModel(value: null, error: kInvalidPasswordError);
    } else {
      _password = ValidationModel(value: passwordText, error: null);
    }
    notifyListeners();
  }

  void validateOldPassword(String passwordText) {
    if (passwordText.isEmpty) {
      _oldPassword = ValidationModel(value: null, error: kEmptyPasswordError);
    } else if (passwordText.length < 8) {
      _oldPassword = ValidationModel(
          value: null, error: "Password must be up to 8 characters");
    } else if (!passwordText.contains(regexNumber, 0)) {
      _oldPassword =
          ValidationModel(value: null, error: "Password must contain a number");
    } else if (!passwordText.contains(regexUpperCase, 0)) {
      _oldPassword = ValidationModel(
          value: null, error: "Password must have an upper case character");
    } else if (!passwordText.contains(regexSpecialCharacter)) {
      _oldPassword = ValidationModel(
          value: null, error: "Password must have contain a special character");
    } else {
      _oldPassword = ValidationModel(value: passwordText, error: null);
    }

    notifyListeners();
  }

  void validateSignInPassword(String passwordText) {
    if (passwordText.isEmpty) {
      _password = ValidationModel(value: null, error: kEmptyPasswordError);
    } else if (passwordText.length < 8) {
      _password = ValidationModel(
          value: null, error: "Password must be up to 8 characters");
    } else if (!passwordText.contains(regexNumber, 0)) {
      _password =
          ValidationModel(value: null, error: "Password must contain a number");
    } else if (!passwordText.contains(regexUpperCase, 0)) {
      _password = ValidationModel(
          value: null, error: "Password must have an upper case character");
    }  else {
      _password = ValidationModel(value: passwordText, error: null);
    }
    notifyListeners();
  }

  void validateEmail(String emailText) {
    if (emailText.isEmpty) {
      _email = ValidationModel(value: null, error: kEmptyEmailError);
    } else if (!(regexEmail.hasMatch(emailText))) {
      _email = ValidationModel(value: null, error: kInvalidEmailError);
    } else {
      _email = ValidationModel(value: emailText, error: null);
    }
    notifyListeners();
  }

  void validateFirstName(String firstNameText) {
    if (firstNameText.isEmpty) {
      _firstName =
          ValidationModel(value: null, error: 'First name is required');
    } else if (!(firstNameText.length >= 2)) {
      _firstName =
          ValidationModel(value: null, error: 'Must be at least 2 characters');
    } else if (!(regexName.hasMatch(firstNameText))) {
      _firstName = ValidationModel(
          value: null, error: 'Please enter a valid first name');
    } else {
      _firstName = ValidationModel(value: firstNameText, error: null);
    }
    notifyListeners();
  }

  void validateLastName(String lastNameText) {
    if (lastNameText.isEmpty) {
      _lastName = ValidationModel(value: null, error: 'Last name is required');
    } else if (!(lastNameText.length >= 2)) {
      _lastName =
          ValidationModel(value: null, error: 'Must be at least 2 characters');
    } else if (!(regexName.hasMatch(lastNameText))) {
      _lastName =
          ValidationModel(value: null, error: 'Please enter a valid last name');
    } else {
      _lastName = ValidationModel(value: lastNameText.trim(), error: null);
    }
    notifyListeners();
  }

  void validatePhoneNumber(String phoneNumberText) {
    if (phoneNumberText.isEmpty) {
      _phoneNumber =
          ValidationModel(value: null, error: 'Phone number is required');
    } else if (!(regexMobile.hasMatch(phoneNumberText))) {
      _phoneNumber = ValidationModel(
          value: null, error: 'Please enter a valid phone number');
    } else {
      _phoneNumber =
          ValidationModel(value: phoneNumberText.trim(), error: null);
    }
    notifyListeners();
  }

  void userAcceptTerms() {
    _acceptTerms = !_acceptTerms;
    notifyListeners();
  }

  bool validateOtpField(String otp) {
    bool valid = false;

    if (otp.isEmpty) {
      valid = false;
      _otp = ValidationModel(value: null, error: 'OTP is required');
    } else if (!otp.contains(regexOTP)) {
      valid = false;
      _otp = ValidationModel(value: null, error: 'OTP is invalid');
    } else if (otp.length < 6) {
      valid = false;
      _otp = ValidationModel(
          value: null, error: 'OTP must not be less than 6 digits');
    } else {
      valid = true;
      _otp = ValidationModel(value: otp.trim(), error: null);
    }
    notifyListeners();

    return valid;
  }

  void validateConfirmPassword(String passwordText, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      _confirmNewPassword =
          ValidationModel(value: null, error: kEmptyPasswordError);
    } else if (confirmPassword.isNotEmpty && passwordText != confirmPassword) {
      _confirmNewPassword =
          ValidationModel(value: null, error: kPasswordMatchError);
    } else {
      _confirmNewPassword =
          ValidationModel(value: confirmPassword.trim(), error: null);
    }
    notifyListeners();
  }

  bool get isValidOTP {
    return _otp.value != null;
  }

  bool get isValidChangePassword {
    return _password.value != null &&
        _oldPassword.value != null &&
        _confirmNewPassword.value != null;
  }

  // void changeVerificationFormStateToEmail() {
  //   _currentState = RecoverPasswordStepState.emailForm;
  //   notifyListeners();
  // }

  // void changeVerificationFormStateToOtp() {
  //   _currentState = RecoverPasswordStepState.verificationForm;
  //   notifyListeners();
  // }

  // void changeVerificationFormStateToPassword() {
  //   _currentState = RecoverPasswordStepState.passwordForm;
  //   notifyListeners();
  // }

  bool get isValidSignUp {
    return _firstName.value != null &&
        _lastName.value != null &&
        _email.value != null &&
        _password.value != null &&
        _acceptTerms != false;
  }

  bool get isValidSignIn {
    return _email.value != null && _password.value != null;
  }

  bool get isValidEmail {
    return _email.value != null;
  }

  bool get isValidPassword {
    return _password.value != null;
  }

  bool get isValidResetPassword {
    return _password.value != null && confirmNewPassword.value != null;
  }

  bool get isValidAvatar {
    return _avatar != null;
  }

  Future signUpUser() async {
    setLoading(true);

    AuthUser authUser = AuthUser(
        email: email.value.toString().trim(),
        password: password.value.toString().trim(),
        firstName: firstName.value.toString().trim(),
        lastName: lastName.value.toString().trim());
    // phoneNumber: phoneNumber.value.toString().trim());
    final response = await authenticationRepository.signUpTheUser(authUser);

    if (response == true) {
      await submitDataForSignIn();
    }

    setLoading(false);
    notifyListeners();
    return response;
  }

  //Sign In
  Future submitDataForSignIn() async {
    AuthUser authUser = AuthUser(
      email: email.value.toString(),
      password: password.value.toString(),
    );
    setLoading(true);
    final response = await authenticationRepository.signInTheUser(authUser);
    if (response == true) {
      setLoading(false);
      navigateToHome();
    } else {
      setLoading(false);
    }
    setLoading(false);
    notifyListeners();
  }

  Future deleteUserAccount(String password) async {
    // print('DATA: ${email.value}, ${password.value}');
    AuthUser authUser = AuthUser(
      email: PrefUtils.getUserData()!.email.toString(),
      password: password.toString(),
    );
    setLoading(true);
    final response = await authenticationRepository.signInTheUser(authUser);
    if (response == true) {
      final signinResponse = await authenticationRepository.deleteUserAccount();

      if (signinResponse == true) {
        clearAppDetaills();
        setLoading(false);
      } else {
        navigatorKey.currentState?.pop();
        setLoading(false);
      }
    } else {
      clearFormData();
      navigatorKey.currentState?.pop();
      setLoading(false);
    }
    // setLoading(false);
    notifyListeners();
  }

//SignOut
  Future signOutUserFunction() async {
    setLoading(true);
    // final status = await authenticationRepository.signOutUser();
    // // print(status);
    // if (status == true) {
      clearAppDetaills();
    // }
    setLoading(false);
    notifyListeners();
  }

  Future<List<String>> getUserAuthKeys() async {
    List<String> tokens = await UserSecureStorage.getUserCredentials();

    return tokens;
  }

  Future saveUserData(String email, String firstname, String lastname) async {
    // PrefUtils.deleteUserFromMemory();

    await PrefUtils.putEmail(email);
    await PrefUtils.setUserDetails(firstname, lastname);
  }

  Future getCurrentUser() async {
    // PrefUtils.deleteUserFromMemory();
    // print(userID);

    // setLoading(true);
    final response = await authenticationRepository.getCurrentUser();
    if (response != false) {
      setLoading(false);
    }
  }

  void deleteAccount() {
    setLoading(true);

    Future.delayed(const Duration(seconds: 6), () {
      setLoading(false);
      navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return const AuthScreen();
        },
      ), (route) => false);
    });
  }

  void clearAppDetaills() {
    setLoading(true);

    navigatorKey.currentState?.pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const AuthScreen();
      },
    ), (route) => false);
    // changeVerificationFormStateToEmail();
    // notificationRepository.cancelNotification();
    UserSecureStorage.deleteUserDetails();
    PrefUtils.deleteUserFromWallet();
    // PrefUtils.deleteUserFromMemory();
    setLoading(false);
  }

  clearFormData() {
    _firstName.value = null;
    _lastName.value = null;
    _phoneNumber.value = null;
    _password.value = null;
    _oldPassword.value = null;
    _newPassword.value = null;
    _email.value = null;
    _avatar = null;
    _eightChars = false;
    _specialChar = false;
    _upperCaseChar = false;
    _number = false;
    notifyListeners();
    // validPassword = false;
  }

  void navigateToAuthScreen() {
    clearFormData();
    navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const AuthScreen();
      },
    ), (route) => false);
  }

  // void navigateToForgotPasswordScren() {
  //   navigatorKey.currentState!.push(MaterialPageRoute(
  //     builder: (context) {
  //       return const ForgotPasswordScreen();
  //     },
  //   ));
  // }

  void navigateToHome() {
    clearFormData();
    navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const ShopScreen();
      },
    ), (route) => false);
  }

  void showErrorMessage(String message) {
    TZSnackBarUtilities().showSnackBar(
      message: message,
      snackbarType: SNACKBARTYPE.error,
    );
  }
}
