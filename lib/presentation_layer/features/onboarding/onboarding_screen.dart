import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/features/home/layout/app_layout.dart';
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
        widget: const AppLayout(),
        animation: PageTransitionType.rightToLeft);
  }
  List<BoardingModel> boarding = [
    BoardingModel(
      image1: 'assets/images/onBoarding1.jpeg',
      image2: 'assets/images/maintenance.png',
      image2Alignment: AlignmentDirectional.bottomCenter,
      title: 'دليل شامل عن سيارتك',
      body: 'تقدر دلوقتي تشوف جميع فواتير الصيانه و تعرف معاد الصيانه القادم ويمكنك فحص كل قطعه في السياره والحصول علي تقرير بحاله السياره',
    ),
    BoardingModel(
      image1: 'assets/images/onBoarding2.jpg',
      image2: 'assets/images/report.png',
      image2Alignment: AlignmentDirectional.bottomStart,
      title: 'الأطلاع علي جميع قطع الغيار',
      body: 'يمكنك معرفه توافر جميع قطع الغيار واسعارها',
    ),
    BoardingModel(
      image1: 'assets/images/onBoarding3.jpg',
      image2: 'assets/images/report.png',
      image2Alignment: AlignmentDirectional.bottomStart,
      title: 'فلوسك رجعالك نقاط',
      body: 'دلوقتي مع كل صيانه هتعملها تقدر تجمع نقط تستبدلها في صيانتك القادمه',
    ),
    BoardingModel(
      image1: 'assets/images/onBoarding4.jpeg',
      image2: 'assets/images/price.png',
      image2Alignment: AlignmentDirectional.bottomEnd,
      title: 'بيع واشتري بضمان المركز',
      body: 'دلوقتي تقدر تبيع عربيتك بعد الفحص من المركز وعربيتك هتنزل علي التطبيق بجميع تفاصيل حاله كل جزء في السياره',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      //appBar: AppBar(),
      body: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) {
              setState(() {
                if (index == boarding.length - 1) {
                  isLast = true;
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              });
            },
            controller: boarderController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => buildScreenItem(boarding[index],index),
            itemCount: boarding.length,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
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
                      radius: 22.r,
                      child: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.white,
                        size: 23.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildScreenItem(BoardingModel model,int index) => Stack(
        children: [
          Image(
            image: AssetImage(model.image1),

            height: displayHeight(context),
            width: displayWidth(context),
            fit: BoxFit.cover,
          ),
          if(index != 1)
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            top: index == 1 ? -330.h:330.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25.sp,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                 SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    model.body,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          /*SizedBox(
            height: 75.h,
          ),*/
        ],
      );
}
