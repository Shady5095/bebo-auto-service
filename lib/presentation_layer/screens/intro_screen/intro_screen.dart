import 'package:bebo_auto_service/business_logic_layer/app_cubit/app_cubit.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/local/cache_helper.dart';
import 'package:bebo_auto_service/presentation_layer/screens/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/app_locale.dart';

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
          stops: [
            0.25,
            0.5,
            0.75,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,

        ),
      ),
      child: Column(
        children: [
          if(displayAspectRatio(context) >= 0.7)
            SizedBox(
              height: 30.h,
            ),
          if(displayAspectRatio(context) <= 0.7)
          SizedBox(
            height: (displayHeight(context) >= 775 && displayAspectRatio(context) <= 0.6 ) ? 115.h : 75.h,
          ),
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
              '${getLang(context, 'New concept of car maintenance in Egypt')}',
            textAlign: TextAlign.center,
            style: GoogleFonts.almarai(
              decoration: TextDecoration.none,
              color: Colors.white54,
              fontSize: 14.sp,
            )
          ),
          SizedBox(
              height: (displayHeight(context) >= 775 && displayAspectRatio(context) <= 0.6 ) ? 75.h : 30.h,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Padding(
              padding: const EdgeInsets.only(left: 50).w,
              child: Image(
                image: AssetImage('assets/images/intro.png'),
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.w,
                  height: 50.h,
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isEnglish = true ;
                        });
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: ListTile(
                        minLeadingWidth: 10.w,
                        titleAlignment: ListTileTitleAlignment.center,
                        contentPadding: const EdgeInsets.only(left: 42).w,
                        horizontalTitleGap: 10.w,
                        enabled: true,
                        leading: CircleAvatar(
                          radius: 11.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 10.r,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 7.r,
                              backgroundColor: isEnglish ? defaultColor : Colors.transparent,
                            ),
                          ),
                        ),
                        title: Text(
                          'English',
                          style: TextStyle(
                              color: Colors.grey[400],
                              decoration: TextDecoration.none,
                              fontSize: 22.sp
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200.w,
                  height: 50.h,
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isEnglish = false ;
                        });
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: ListTile(
                        minLeadingWidth: 10.w,
                        titleAlignment: ListTileTitleAlignment.center,
                        contentPadding: const EdgeInsets.only(left: 42).w,
                        horizontalTitleGap: 18.w,
                        enabled: true,
                        leading: CircleAvatar(
                          radius: 11.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 10.r,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 7.r,
                              backgroundColor: !isEnglish ? defaultColor : Colors.transparent,
                            ),
                          ),
                        ),
                        title: Text(
                          'العربية',
                          style: GoogleFonts.cairo(
                              color: Colors.grey[400],
                              decoration: TextDecoration.none,
                              fontSize: 22.sp
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          defaultButton(
            onTap: (){
              navigateToAnimated(
                context: context,
                widget: OnBoarding(),
                animation: PageTransitionType.rightToLeftWithFade
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
                  '${getLang(context, 'Get Started')}',
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
