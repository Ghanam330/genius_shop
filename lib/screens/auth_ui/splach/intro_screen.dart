import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../utils/screen_utils.dart';

class IntroScreen extends StatefulWidget {


  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int pageCount = 0;

  final PageController _controller = PageController();

  void setPageCount(int aPageCount) {
    setState(() {
      pageCount = aPageCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return Scaffold(
      body: Column(
        children: [
          IllustrationPageView(_controller, setPageCount),
          TextView(pageCount),
        ],
      ),
    );
  }
}

class TextView extends StatelessWidget {
  final int pageCount;

  const TextView(this.pageCount);
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {
        'title': 'مرحبًا بك في تطبيقنا',
        'desc':
            'مرحبًا بك في تطبيقنا ، نأمل أن تستمتع بالتسوق معنا.',
      },
      {
        'title': 'اصبح الشراء عبر الانترنت أسهل',
        'desc':
            'يمكنك الشراء في أي مكان وزمان ، فقط باستخدام هاتفك الذكي!',
      },
      {
        'title': 'توصيل سريع',
        'desc':
            'نحن نقدم لك توصيل سريع ومجاني للطلبات التي تزيد عن .',
      },
    ];
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Column(
          children: [
            const Spacer(),
            Text(
              data[pageCount]['title']!,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: kTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            Text(
              data[pageCount]['desc']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kTextColorAccent,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageIndicator(pageCount, 0),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                PageIndicator(pageCount, 1),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                PageIndicator(pageCount, 2),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                 Navigator.of(context).pushNamed(loginScreen);
              },
              child: const Text(
                'هيا بنا',
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator(this.pageCount, this.index);

  final int pageCount;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      width: pageCount == index
          ? getProportionateScreenWidth(32)
          : getProportionateScreenWidth(8),
      height: getProportionateScreenWidth(8),
      decoration: BoxDecoration(
        color: pageCount == index ? kPrimaryGreen : kFillColorPrimary,
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(4),
        ),
      ),
    );
  }
}

class IllustrationPageView extends StatelessWidget {
  final controller;
  final Function(int) callback;

  const IllustrationPageView(
    this.controller,
    this.callback,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        color: kAccentGreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                     Navigator.of(context).pushNamed(loginScreen);
                  },
                  child: Text(
                    'تخطي',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: kTextColor,
                        ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(20),
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (pageNum) {
                  callback(pageNum);
                },
                children: [
                  SvgPicture.asset(
                    'assets/images/illu1.svg',
                  ),
                  SvgPicture.asset(
                    'assets/images/illu2.svg',
                  ),
                  SvgPicture.asset(
                    'assets/images/illu3.svg',
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
          ],
        ),
      ),
    );
  }
}
