import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/features/home/home_screen/blur_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../components/components.dart';
import '../../../data_layer/local/cache_helper.dart';

class BoardingModel {
  late final String image1;

  late final String image2;

  late final AlignmentGeometry image2Alignment;

  late final String title;

  late final String body;

  BoardingModel({
    required this.image1,
    required this.image2,
    required this.image2Alignment,
    required this.title,
    required this.body,
  });
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boarderController = PageController();

  bool isLast = false;

  void onSubmit() {
    CacheHelper.putData(key: 'onBoarding', value: true);
    navigateAndFinish(
        context: context,
        widget: const BlurHomeScreen(),
        animation: PageTransitionType.rightToLeft);
  }

  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boarding = [
      BoardingModel(
        image1: 'assets/images/onboarding111.png',
        image2: 'assets/images/maintenance.png',
        image2Alignment: AlignmentDirectional.bottomCenter,
        title: '',
        body: '',
      ),
      BoardingModel(
        image1: 'assets/images/onboarding2.png',
        image2: 'assets/images/report.png',
        image2Alignment: AlignmentDirectional.bottomStart,
        title: '',
        body: '',
      ),
      BoardingModel(
        image1: 'assets/images/onboarding3.png',
        image2: 'assets/images/price.png',
        image2Alignment: AlignmentDirectional.bottomEnd,
        title: '',
        body: '',
      ),
    ];
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      //appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 30).h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    onSubmit();
                  },
                  child: Text(
                    'تخطي',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  if (index == boarding.length - 1) {
                    isLast = true;
                  } else {
                    setState(() {
                      if (index == boarding.length - 1) {
                        isLast = false;
                      }
                    });
                  }
                });
              },
              physics: const BouncingScrollPhysics(),
              controller: boarderController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => buildScreenItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0).h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: boarderController,
                  count: boarding.length,
                  effect:  ExpandingDotsEffect(
                    dotColor: Colors.white,
                    activeDotColor: defaultColor,
                    expansionFactor: 2,
                    spacing: 10,
                    dotWidth: 8.w,
                    dotHeight: 8.h,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (isLast == false) {
                      boarderController.nextPage(
                        duration: const Duration(
                          milliseconds: 2000,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else {
                      onSubmit();
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: defaultColor,
                    radius: 20.r,
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                      size: 23.sp,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildScreenItem(BoardingModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: (displayHeight(context) >= 790 &&
                    displayAspectRatio(context) <= 0.6)
                ? 300.w
                : 250.w,
            height: (displayHeight(context) >= 790 &&
                    displayAspectRatio(context) <= 0.6)
                ? 280.h
                : 200.h,
            image: AssetImage(model.image1),
          ),
          Text(
            model.title,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30.sp,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              model.body,
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white54,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          /*SizedBox(
            height: 75.h,
          ),*/
        ],
      );
}
