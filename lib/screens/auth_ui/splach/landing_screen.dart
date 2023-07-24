import 'package:flutter/material.dart';


import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../utils/screen_utils.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body:Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
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
                    'مرحبًا بكم في متجر عبقرينو ',
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
              'لدينا أكثر من  10000+ منتج متاح لكم جميعًا.',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: kTextColorAccent,
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(onboarding);
              },
              child: Text('ابدأ الآن'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}