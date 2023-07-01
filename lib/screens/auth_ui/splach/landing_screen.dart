import 'package:flutter/material.dart';


import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../utils/screen_utils.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/landing.png',
                fit: BoxFit.cover,
              ),
            ),
            IntroWidget()
          ],
        ),
      ),
    );
  }
}

class IntroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
            20,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Welcome to Genius Shop',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: kTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              'We have more than 10,000+  available for all of you.',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: kTextColorAccent,
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(onboarding);
              },
              child: Text('Get Started'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}