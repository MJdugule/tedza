import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/res/widget/app_spinner.dart';
import 'package:tedza/res/widget/check_box.dart';
import 'package:tedza/res/widget/entry_field.dart';
import 'package:tedza/res/widget/flat_button.dart';
import 'package:tedza/res/widget/password_verification_widget.dart';
import 'package:tedza/utilities/snackbar_utils.dart';
import 'package:tedza/viewmodels/authentication_viewmodel.dart';

class SignUpScreen extends StatefulWidget {
  final Function(int) onTabChange;
  const SignUpScreen({super.key, required this.onTabChange});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: kPaddingTF,
            right: kPaddingTF,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  SizedBox(height: kSpaceXXS,),
              const SizedBox(
                height: kSpaceXXL,
              ),
              Text("Create your account",
                  style: Theme.of(context).textTheme.headlineSmall),

              Text("Fill in the details to sign up",
                  style: Theme.of(context).textTheme.titleMedium),
              verticalSpaceMedium,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TZTextField(
                      hintText: "First Name",
                      errorText: authenticationProvider.firstName.error,
                      controller: firstNameController,
                      onChanged: (value) => authenticationProvider
                          .validateFirstName(value.trim()),
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(width: kPaddingM),
                  Expanded(
                    child: TZTextField(
                      hintText: "Last Name",
                      errorText: authenticationProvider.lastName.error,
                      controller: lastNameController,
                      onChanged: (value) =>
                          authenticationProvider.validateLastName(value.trim()),
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              verticalSpaceTiny,
              TZTextField(
                hintText: "Email",
                controller: emailController,
                errorText: authenticationProvider.email.error,
                onChanged: (value) =>
                    authenticationProvider.validateEmail(value.trim()),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              verticalSpaceTiny,
           
            
              TZPasswordField(
                obscureText: true,
                hintText: "Password",
                controller: passwordController,
                errorText: authenticationProvider.password.error,
                onChanged: (value) {
                  authenticationProvider.checkPasswordValidation(value);
                  authenticationProvider.validateSignUpPassword(value);
                },
              ),
              verticalSpaceSmall,
              PPPasswordVerificationWidget(
                text: "Minimum of 8 Characters",
                valid: authenticationProvider.eightChars,
              ),
              PPPasswordVerificationWidget(
                text: "Uppercase Character",
                valid: authenticationProvider.upperCaseChar,
              ),
              PPPasswordVerificationWidget(
                text: "Number",
                valid: authenticationProvider.number,
              ),
              // PPPasswordVerificationWidget(
              //   text: "Special Characters",
              //   valid: authenticationProvider.specialChar,
              // ),
              verticalSpaceMedium,
              Row(
                children: [
                  PPCheckBox(
                    isChecked: authenticationProvider.acceptTerms,
                    onTapCheck: () => authenticationProvider.userAcceptTerms(),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                          text: "I agree to all ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColor.kGreyNeutral.shade500),
                          children: [
                            TextSpan(
                                text: "Terms & Conditions",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: AppColor.kPrimaryColor,
                                      // fontWeight: FontWeight.w500,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // urlUtilities.openWebsiteUrl(
                                    //     context, kTerms);
                                  }),
                          ]),
                    ),
                  ),
                ],
              ),
              verticalSpaceMedium,
              authenticationProvider.loading
                  ? const AppSpinner()
                  : PPFlatButton(
                      active: authenticationProvider.isValidSignUp,
                      pressState: () async {
                        FocusScope.of(context).unfocus();

                        if (!authenticationProvider.isValidSignUp) {
                          PPSnackBarUtilities().showSnackBar(
                              message: "Please complete form to register",
                              snackbarType: SNACKBARTYPE.error);
                          return;
                        }

                        authenticationProvider.signUpUser();
                      },
                      textColor: kWhite,
                      text: "Sign Up",
                      buttonColor: kMainColorDark,
                    ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Already have an account? ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColor.kGreyNeutral.shade500),
                        children: [
                          TextSpan(
                              text: "Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColor.kPrimaryColor,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => widget.onTabChange(0)),
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
