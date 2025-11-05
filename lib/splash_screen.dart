import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5F33E1),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInLeft(
              duration: Duration(milliseconds: 900),
              child: Image.asset("assets/images/Tasky.png"),
            ),
            BounceInDown(
              from: 50,
              delay: Duration(milliseconds: 900),
              duration: Duration(milliseconds: 600),
              child: Image.asset("assets/images/y.png"),
            ),
          ],
        ),
      ),
    );
  }
}
