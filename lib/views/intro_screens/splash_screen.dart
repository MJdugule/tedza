import 'package:flutter/material.dart';
import 'package:tedza/viewmodels/authentication_viewmodel.dart';
import 'package:tedza/views/auth/auth_screen.dart';
import 'package:tedza/views/shop/shop_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 2),
    );

    var fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    animation = fadeSlideTween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });

    _checkSessions();
  }

  _checkSessions() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {
      isLoggedIn().then((value) => value ? _navigateToShop() :
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const AuthScreen())));
    });
  }


  Future<bool> isLoggedIn()async{
     List<String> authKeys = await AuthenticationProvider().getUserAuthKeys();
     if(authKeys[0] == ""){
      return false;
     }else{
      return true;
     }
  }
   void _navigateToShop() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const ShopScreen()));
  }

  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(kSplashBackground), fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // FadeSlideTransition(
                //   additionalOffset: 0.0,
                //   animation: animation,
                //   child: Image.asset(
                //     kSplashTwo,
                //     height: 50,
                //     fit: BoxFit.contain,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FadeSlideTransition extends StatelessWidget {
  final Animation<double> animation;
  final double additionalOffset;
  final Widget child;

  const FadeSlideTransition(
      {required this.animation,
      required this.additionalOffset,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, Widget? builderChild) {
        return Transform.translate(
          offset: Offset(
            0.0,
            (32.0 + additionalOffset) * (1 - animation.value),
          ),
          child: Opacity(
            opacity: animation.value,
            child: builderChild,
          ),
        );
      },
      child: child,
    );
  }
}
