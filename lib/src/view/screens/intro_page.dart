import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/feature/auth/login/lets_you_in.dart';
import 'package:movie_app/src/widgets/button.dart';

import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool onLastPage = false;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff201c24),
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 1);
              });
            },
            controller: controller,
            children: [
              // page 1
              Stack(
                children: [
                  Positioned(
                    top: -60,
                    left: -70,
                    child: Image.asset(
                      'assets/Group 1.png',
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/Rectangle 2443.svg',
                    height: 120.h,
                    fit: BoxFit.cover,
                  ),
                ],
              ),

              // page 2
              Stack(
                children: [
                  Image.asset(
                    'assets/Image.png',
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                  SvgPicture.asset(
                    'assets/Overlay.svg',
                    height: 120.h,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: 2,
                  axisDirection: Axis.horizontal,
                  effect: const SlideEffect(
                      spacing: 5.0,
                      radius: 10.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      dotColor: Color(0xff828285),
                      activeDotColor: Color(0xffff2f2f)),
                ),
                SizedBox(
                  width: 35.h,
                  child: Text(
                    'Watch movies TV, Virtual Reality',
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 4.h,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 40.h,
                  child: Text(
                    'Watch Funflix anywhere. Cancel at any time.',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: GoogleFonts.rubik(
                      color: const Color(0xff6d6d6e),
                      fontSize: 1.8.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                onLastPage
                    ? Button(
                        width: double.infinity,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LetsYouIn()));
                        },
                        title: 'Get Started',
                      )
                    : Button(
                        width: double.infinity,
                        onTap: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        },
                        title: 'Next',
                      ),
                SizedBox(
                  height: 3.h,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
