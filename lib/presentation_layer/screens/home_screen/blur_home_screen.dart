import 'dart:ui';

import 'package:bebo_auto_service/business_logic_layer/app_cubit/app_cubit.dart';
import 'package:bebo_auto_service/business_logic_layer/app_cubit/app_states.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/screens/register_screen/register_screen.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login_screen/login_screen.dart';

class BlurHomeScreen extends StatefulWidget {
  const BlurHomeScreen({Key? key}) : super(key: key);

  @override
  State<BlurHomeScreen> createState() => _BlurHomeScreenState();
}

class _BlurHomeScreenState extends State<BlurHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController carAnimationController;

  late AnimationController pointsTextAnimationController;

  late AnimationController text2AnimationController;

  late AnimationController button1AnimationController;

  late AnimationController button2AnimationController;

  late Animation<Offset> carSlidingAnimation;

  late Animation<Offset> pointsTextSlidingAnimation;

  late Animation<Offset> text2SlidingAnimation;

  late Animation<Offset> button1Animation;

  late Animation<Offset> button2Animation;

  bool isShowSecondText = false;

  @override
  void initState() {
    super.initState();
    initCarAnimation();
    initPointsTextAnimation();
    initButtonsAnimation();
    carAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          initText2Animation();
        });
      }
    });
  }

  @override
  void dispose() async {
    carAnimationController.dispose();
    pointsTextAnimationController.dispose();
    button1AnimationController.dispose();
    button2AnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarCubit, CarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: defaultBackgroundColor,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 385.h,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [
                                0.1,
                                0.65,
                              ],
                              colors: [
                                Color.fromRGBO(254, 79, 79, 1.0),
                                Color.fromRGBO(35, 33, 33, 1.0),
                              ]),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 165.h,
                                child: AnimatedBuilder(
                                    animation: pointsTextSlidingAnimation,
                                    builder: (context, _) {
                                      return SlideTransition(
                                        position: pointsTextSlidingAnimation,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10).w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Countup(
                                                begin: 0,
                                                end: 3000,
                                                duration: const Duration(
                                                    milliseconds: 1500),
                                                separator: ',',
                                                style: GoogleFonts.dosis(
                                                    color: Colors.white,
                                                    fontSize: 60.sp,
                                                    height: 0.8,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                'نقاط',
                                                style: GoogleFonts.dosis(
                                                    color: Colors.white,
                                                    fontSize: 60.sp,
                                                    height: 0.8,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: AnimatedBuilder(
                                    animation: carSlidingAnimation,
                                    builder: (context, _) {
                                      return SlideTransition(
                                        position: carSlidingAnimation,
                                        child: Image(
                                          width: displayWidth(context) <= 385
                                              ? 270.w
                                              : 305.w,
                                          image: const AssetImage(
                                            'assets/images/mazda3copy.png',
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedBuilder(
                              animation: button1Animation,
                              builder: (context, _) {
                                return SlideTransition(
                                  position: button1Animation,
                                  child: defaultButton(
                                    onTap: () {
                                      print(pointsTextSlidingAnimation
                                          .isCompleted);
                                    },
                                    text: 'حجز الصيانة',
                                    width: double.infinity,
                                    height: 37.h,
                                    textColor: Colors.white,
                                    isUppercase: false,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: defaultColor),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 15.h,
                          ),
                          AnimatedBuilder(
                              animation: button2Animation,
                              builder: (context, _) {
                                return SlideTransition(
                                  position: button2Animation,
                                  child: defaultButton(
                                    onTap: () {},
                                    text: 'أستبدال النقط',
                                    width: double.infinity,
                                    height: 37.h,
                                    textColor: Colors.white,
                                    isUppercase: false,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromRGBO(
                                            49, 47, 47, 1.0)),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (carAnimationController.isCompleted)
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 10.0),
                duration: const Duration(seconds: 2),
                builder: (_, value, child) {
                  return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: value,
                        sigmaY: value,
                      ),
                      child: child);
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            if (carAnimationController.isCompleted)
              Center(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: displayHeight(context) * 0.27,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0.0, end: 1.0),
                                duration: const Duration(seconds: 2),
                                builder: (_, value, child) {
                                  Future.delayed(Duration(seconds: 1), () {
                                    if (!isShowSecondText) {
                                      setState(() {
                                        isShowSecondText = true;
                                        initText2Animation(); // <-- Code run after delay
                                      });
                                    }
                                  });
                                  return Opacity(opacity: value, child: child);
                                },
                                child: Text(
                                  'اهلا بك في مركز بيبو اوتو',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              if (isShowSecondText)
                                TweenAnimationBuilder<double>(
                                  tween: Tween<double>(begin: 0.0, end: 1.0),
                                  duration: const Duration(seconds: 1),
                                  builder: (_, value, child) {
                                    return Opacity(
                                        opacity: value, child: child);
                                  },
                                  child: Text(
                                    'سجل عربيتك دلوقتي للاستمتاع بجميع خدمات الأبلكيشن',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                      color: Colors.grey[500],
                                      fontSize: 15.sp,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              if (isShowSecondText)
                                AnimatedBuilder(
                                    animation: text2SlidingAnimation,
                                    builder: (context, _) {
                                      return SlideTransition(
                                        position: text2SlidingAnimation,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              defaultButton(
                                                onTap: () {
                                                  navigateTo(
                                                    context: context,
                                                    widget:
                                                        const RegisterScreen(),
                                                  );
                                                },
                                                text: 'سجل',
                                                width: displayWidth(context) *
                                                    0.70,
                                                height: 37.h,
                                                textColor: Colors.white,
                                                isUppercase: false,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: defaultColor),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              defaultButton(
                                                onTap: () {},
                                                text: 'عن المركز',
                                                width: displayWidth(context) *
                                                    0.70,
                                                height: 37.h,
                                                textColor: Colors.white,
                                                isUppercase: false,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: const Color.fromRGBO(
                                                      49, 47, 47, 1.0),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'لديك حساب ؟',
                                                    style: GoogleFonts.cairo(
                                                        color: Theme.of(context)
                                                            .secondaryHeaderColor,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontSize: 14.sp),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      navigateTo(
                                                          context: context,
                                                          widget:
                                                              const LoginScreen());
                                                    },
                                                    child: Text(
                                                      'تسجيل الدخول',
                                                      style: TextStyle(
                                                          fontSize: 13.sp),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void initCarAnimation() {
    carAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    carSlidingAnimation =
        Tween<Offset>(begin: const Offset(5, 0), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
          parent: carAnimationController, curve: Curves.fastLinearToSlowEaseIn),
    );
    carAnimationController.forward();
  }

  Future<void> initPointsTextAnimation() async {
    pointsTextAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    pointsTextSlidingAnimation =
        Tween<Offset>(begin: const Offset(-2, 0), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: pointsTextAnimationController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      pointsTextAnimationController.forward();
    }
  }

  Future<void> initText2Animation() async {
    text2AnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    text2SlidingAnimation =
        Tween<Offset>(begin: const Offset(0, 10), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: text2AnimationController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      text2AnimationController.forward();
    }
  }

  Future<void> initButtonsAnimation() async {
    button1AnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    button1Animation =
        Tween<Offset>(begin: const Offset(0, 7), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: button1AnimationController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    button1AnimationController.forward();

    ///button2
    button2AnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    button2Animation =
        Tween<Offset>(begin: const Offset(0, 7), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: button2AnimationController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 300));
    button2AnimationController.forward();
  }
}
