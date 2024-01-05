import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/features/onboarding/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool isEnglish = false ;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.01),
            Colors.white.withOpacity(0.25),
            Colors.black.withOpacity(0.01),
          ],
          stops: const [
            0.25,
            0.5,
            0.75,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,

        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /*if(displayAspectRatio(context) >= 0.7)
            SizedBox(
              height: 30.h,
            ),
          if(displayAspectRatio(context) <= 0.7)
          SizedBox(
            height: (displayHeight(context) >= 775 && displayAspectRatio(context) <= 0.6 ) ? 115.h : 75.h,
          ),*/
          Column(
            children: [
              Text(
                  'Bebo Auto Service',
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w600
                )
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                  'مفهوم جديد لصيانه السيارات في مصر',
                textAlign: TextAlign.center,
                style: GoogleFonts.almarai(
                  decoration: TextDecoration.none,
                  color: Colors.grey,
                  fontSize: 14.sp,
                )
              ),
            ],
          ),
          /*SizedBox(
              height: (displayHeight(context) >= 775 && displayAspectRatio(context) <= 0.6 ) ? 75.h : 30.h,
          ),*/
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Padding(
              padding: const EdgeInsets.only(left: 50).w,
              child: const Image(
                image: AssetImage('assets/images/intro.png'),
              ),
            ),
          ),
          /*SizedBox(
            height: 25.h,
          ),*/
          defaultButton(
            onTap: (){
              navigateToAnimated(
                context: context,
                widget: const OnBoarding(),
                animation: PageTransitionType.leftToRightWithFade
              );
            },
            decoration: BoxDecoration(
              color: defaultColor,
              borderRadius: BorderRadius.circular(25),
            ),
            width: MediaQuery.of(context).size.width * 0.60,
            height: 42.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ابدأ',
                  style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp
                  )
                ),
                SizedBox(
                  width: 10.w,
                ),
                Icon(
                   CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
