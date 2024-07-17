import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/viewmodels/authentication_viewmodel.dart';
import 'package:tedza/views/auth/sign_in_screen.dart';
import 'package:tedza/views/auth/sign_up_screen.dart.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _navigateToTab(int tabIndex) {
    _tabController.animateTo(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
     final authenticationProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
      
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: kWhite,
        systemNavigationBarContrastEnforced: true,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,),
      child: Scaffold(
        backgroundColor: kMainColorDark,
        body: Padding(
          padding: const EdgeInsets.only(top: kPaddingFF),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              verticalSpaceMedium,
              Container(
                padding: const EdgeInsets.only(
                  top: kPaddingTF,
                  left: kPaddingTF,
                  right: kPaddingTF,
                ),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: kWhiteTwo),
                child: TabBar(
                  controller: _tabController,
                  onTap: (index){
                    authenticationProvider.clearFormData();
                  },
                  tabs: const [
                    Tab(
                      text: "Login",
                      // height: kHeight(59, context),
                    ),
                    Tab(
                      text: "Sign Up",
                      // height: kHeight(59, context),
                    ),
                  ],
                  dividerColor: AppColor.kGreyNeutral.shade300,
                 dividerHeight: 1,
                  unselectedLabelColor: AppColor.kGreyNeutral.shade300,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontSize: 16),
                  labelColor: AppColor.kPrimaryColor,
                  indicatorWeight: 2,
                  indicatorColor: AppColor.kPrimaryColor.shade500,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SignInScreen(
                      onTabChange: _navigateToTab,
                    ),
                    SignUpScreen(
                      onTabChange: _navigateToTab,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
