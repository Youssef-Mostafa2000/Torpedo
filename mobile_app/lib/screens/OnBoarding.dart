import 'dart:async';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// OnBoarding page

class OnBoardingContent {
  final String image;
  final String title;
  final String description;
  final double? height;
  final double? width;

  OnBoardingContent(
      {required this.image,
      required this.title,
      required this.description,
      required this.height,
      required this.width});
}

// OnBoarding pages

final List<OnBoardingContent> pages = [
  OnBoardingContent(
    image: 'assets/images/Asset1.png',
    width: 153.5,
    height: 220.5,
    title: 'تسليم الطرود بعناية فائقة',
    description: 'نقدم طرودك بعناية فائقة، يتم التعامل مع اغراضك بدقة واهتمام.',
  ),
  OnBoardingContent(
    image: 'assets/images/Asset6.png',
    width: 253.5,
    height: 222.5,
    title: 'تجربة مريحة لتتبع الطرود',
    description:
        'تابع طرودك بكل سهولة، ابق على اطّلاع حول رحلتها من المخزن الى العميل.',
  ),
  OnBoardingContent(
    image: 'assets/images/Asset5.png',
    width: 205.5,
    height: 222.5,
    title: 'توصيل سريع في جميع المناطق',
    description:
        'استمتع بتوصيل سريع لجميع المحافظات، سنقوم بتوصيل طلباتك في وقت قياسي.',
  ),
];

// OnBoarding Widget

class OnBoardingWidget extends StatelessWidget {
  final OnBoardingContent content;
  const OnBoardingWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(150),
                  topRight: Radius.circular(150),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffDDE5EC), Colors.white],
                ),
              ),
              width: 300,
              height: 405,
            ),
            Image(
              image: AssetImage(content.image),
              width: content.width,
              height: content.height,
              fit: BoxFit.fill,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          content.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            content.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  double _progressValue = 1 / 3;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // initialize page controller
    _pageController = PageController(initialPage: 0);

    // automatic scroll
    /*_timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageIndex < 3) {
        //_pageIndex++;
        setState(() {
          _pageIndex++;
          _pageController.animateToPage(_pageIndex,
              duration: const Duration(microseconds: 350),
              curve: Curves.easeIn);
        });
      } else {
        setState(() {
          _pageIndex = 0;
          _pageController.animateToPage(_pageIndex,
              duration: const Duration(microseconds: 350),
              curve: Curves.easeIn);
        });
      }
    });*/

    // animation
    if (_pageController.hasClients) {
      _pageController.animateToPage(_pageIndex,
          duration: const Duration(microseconds: 350), curve: Curves.easeIn);
    }
  }

  @override
  void dispose() {
    // dispose everything
    _pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        // padding: const EdgeInsets.symmetric(vertical: 40.0),
        padding: const EdgeInsets.only(top: 70.0, bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Spacer(
                  flex: 1,
                ),
                TextButton(
                  onPressed: () {
                    // go to home page
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      overlayColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text(
                    'تخطي',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemCount: pages.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnBoardingWidget(
                  content: pages[index],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            NextButton(
              pageIndex: _pageIndex,
              onPressed: () {
                setState(() {
                  if (_pageIndex < 3) {
                    if (_pageIndex == 2) {
                      // go to home page
                      print('Home');
                    } else {
                      _pageIndex++;
                      _pageController.animateToPage(_pageIndex,
                          duration: const Duration(microseconds: 350),
                          curve: Curves.easeIn);
                    }
                    print(_pageIndex);
                  } else {
                    _pageIndex = 0;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Next button

class NextButton extends StatelessWidget {
  final int pageIndex;
  final VoidCallback onPressed;
  NextButton({super.key, required this.pageIndex, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    //const int x = 1;
    return Stack(
      alignment: Alignment.center,
      children: [
        pageIndex == 0
            ? const SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: 1 / 3,
                  color: Color(0xff033f73),
                ),
              )
            : pageIndex == 1
                ? const SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: 2 / 3,
                      color: Color(0xff033f73),
                    ),
                  )
                : const SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: 3 / 3,
                      color: Color(0xff033f73),
                    ),
                  ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          child: const Icon(
            Icons.chevron_right,
            size: 50,
          ),
        )
      ],
    );
  }
}
