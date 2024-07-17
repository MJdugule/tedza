import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/res/widget/app_spinner.dart';
import 'package:tedza/res/widget/entry_field.dart';
import 'package:tedza/res/widget/flat_button.dart';
import 'package:tedza/viewmodels/authentication_viewmodel.dart';

class SignInScreen extends StatefulWidget {
  final Function(int) onTabChange;
  const SignInScreen({super.key, required this.onTabChange});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              Text("Welcome back!",
                  style: Theme.of(context).textTheme.headlineSmall),

              Text("Fill in your login details",
                  style: Theme.of(context).textTheme.titleMedium),

              verticalSpaceMedium,
              TZTextField(
                hintText: "Email Address",
                controller: emailController,
                errorText: authenticationProvider.email.error,
                onChanged: (value) =>
                    authenticationProvider.validateEmail(value),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              verticalSpaceTiny,
              TZTextField(
                hintText: "Password",
                // suffixIcon: true,
                controller: passwordController,
                errorText: authenticationProvider.password.error,
                onChanged: (value) {
                  authenticationProvider.validateSignInPassword(value);
                },
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              verticalSpaceSmall,
              GestureDetector(
                onTap: () {
                  // authenticationProvider.navigateToForgotPasswordScren();
                },
                child: Text("Forgot Password?",
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: kMainColorDark)),
              ),
              verticalSpaceMedium,
              authenticationProvider.loading
                  ? const AppSpinner()
                  : PPFlatButton(
                      active: authenticationProvider.isValidSignIn,
                      pressState: () async {
                        FocusScope.of(context).unfocus();
                        if (!authenticationProvider.isValidSignIn) {
                          authenticationProvider.showErrorMessage(
                            "Please complete form to sign in",
                          );
                          return;
                        }
                        authenticationProvider.submitDataForSignIn();
                      },
                      textColor: kWhite,
                      text: "Login",
                      buttonColor: kMainColorDark,
                    ),

              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: kGrey),
                        children: [
                          TextSpan(
                              text: "Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: kMainColorDark,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => widget.onTabChange(1)),
                        ]),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
