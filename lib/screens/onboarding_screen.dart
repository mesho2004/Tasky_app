import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky/onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String routeName = 'OnboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int index = 0;
  PageController controller = PageController();
  List<OnboardingData> onBoardingList = dataOnBoarding();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //image
            SizedBox(
              height: 240,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(onBoardingList[index].image);
                },
                itemCount: onBoardingList.length,
              ),
            ),
            SizedBox(height: 22),
            SmoothPageIndicator(
              controller: controller,
              count: onBoardingList.length,
              effect: ExpandingDotsEffect(
                spacing: 10,
                radius: 10,
                dotWidth: 15,
                dotHeight: 5,
              ),
            ),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text(
                    onBoardingList[index].title,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  Text(
                    onBoardingList[index].description,
                    style: TextStyle(fontSize: 16, color: Color(0xff6E6A7C)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 117),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                  color: Color(0xff5F33E1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 48,
                  onPressed: () {
                    if (index < onBoardingList.length - 1) {
                      controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, 'LoginScreen');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      index < onBoardingList.length - 1
                          ? 'Next'
                          : 'Get Started',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
