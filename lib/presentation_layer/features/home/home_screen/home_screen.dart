import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/models/user_model.dart';
import 'package:bebo_auto_service/presentation_layer/features/points/points_screen.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../../../business_logic_layer/main_app_cubit/main_app_states.dart';
import '../../offers/offers_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  late AnimationController carAnimationController ;
  late AnimationController pointsTextAnimationController ;
  late AnimationController helloTextAnimationController ;
  late AnimationController button1AnimationController ;
  late AnimationController button2AnimationController ;
  late Animation<Offset> carSlidingAnimation ;
  late Animation<Offset> pointsTextSlidingAnimation ;
  late Animation<Offset> helloTextSlidingAnimation ;
  late Animation<Offset> button1Animation ;
  late Animation<Offset> button2Animation ;

  @override
  void initState() {
    super.initState();
    initCarAnimation();
    initPointsTextAnimation();
    initHelloTextAnimation();
    initButtonsAnimation();
  }

  @override
  void dispose() async {
    carAnimationController.dispose();
    pointsTextAnimationController.dispose();
    helloTextAnimationController.dispose();
    button1AnimationController.dispose();
    button2AnimationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainAppCubit,MainAppStates>(
      listener: (context,state){},
      builder: (context,state){
        UserModel? userData = MainAppCubit.get(context).userData ;
        return Scaffold(
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
                            top: 60.h,
                            child: AnimatedBuilder(
                                animation: helloTextSlidingAnimation,
                                builder: (context,_) {
                                  return SlideTransition(
                                    position: helloTextSlidingAnimation,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10).w,
                                      child: Text(
                                        'أهلا,${userData!.firstName}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 27.sp,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                          Positioned(
                            top: 165.h,
                            child: AnimatedBuilder(
                                animation: pointsTextSlidingAnimation,
                                builder: (context,_) {
                                  return SlideTransition(
                                    position: pointsTextSlidingAnimation,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10).w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Countup(
                                            begin: 0,
                                            end: userData!.points!.toDouble(),
                                            duration: const Duration(milliseconds: 1500),
                                            separator: ',',
                                            style: GoogleFonts.dosis(
                                                color: Colors.white,
                                                fontSize: 60.sp,
                                                height: 0.8,
                                                fontWeight: FontWeight.w600
                                            ),
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
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: displayWidth(context) <= 385 ? displayWidth(context)*0.21 : displayWidth(context) > 600 ?  displayWidth(context)*0.25 : displayWidth(context)*0.16,
                            child: AnimatedBuilder(
                                animation: carSlidingAnimation,
                                builder: (context, _) {
                                  return SlideTransition(
                                    position: carSlidingAnimation,
                                    child: Image(
                                      width: displayWidth(context) <= 385 ? 330.w :  displayWidth(context) > 600 ? 315.w : 350.w,
                                      image: const AssetImage('assets/images/mazda3.png'),
                                    ),
                                  );
                                }
                            ),
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
                          builder: (context,_) {
                            return SlideTransition(
                              position: button1Animation,
                              child: defaultButton(
                                onTap: (){
                                  navigateToAnimated(
                                    widget: const OffersScreen(),
                                    context: context,
                                  );
                                },
                                text: 'الأطلاع علي احدث العروض',
                                width: double.infinity,
                                height: 37.h,
                                textColor: Colors.white,
                                isUppercase: false,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: defaultColor
                                ),
                              ),
                            );
                          }
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      AnimatedBuilder(
                          animation: button2Animation,
                          builder: (context,_) {
                            return SlideTransition(
                              position: button2Animation,
                              child: defaultButton(
                                onTap: (){
                                  navigateToAnimated(
                                    context: context,
                                    widget: const PointsScreen(),
                                  );
                                },
                                text: 'تقدم النقاط',
                                width: double.infinity,
                                height: 37.h,
                                textColor: Colors.white,
                                isUppercase: false,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromRGBO(49, 47, 47, 1.0)
                                ),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void initCarAnimation(){
    carAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    carSlidingAnimation = Tween<Offset>(begin: const Offset(5 , 0) , end:  const Offset(0 , 0)).animate(
      CurvedAnimation(
          parent: carAnimationController,
          curve: Curves.fastLinearToSlowEaseIn
      ),
    );
    carAnimationController.forward();
  }

  Future<void> initPointsTextAnimation() async {
    pointsTextAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    pointsTextSlidingAnimation = Tween<Offset>(begin: const Offset(-2 , 0) , end:  const Offset(0 , 0)).animate(
      CurvedAnimation(
          parent: pointsTextAnimationController,
          curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    if(mounted){
      pointsTextAnimationController.forward();
    }
  }

  void initHelloTextAnimation(){
    helloTextAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    helloTextSlidingAnimation = Tween<Offset>(begin: const Offset(-5 , 0) , end:  const Offset(0 , 0)).animate(
      CurvedAnimation(
          parent: helloTextAnimationController,
          curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    helloTextAnimationController.forward();
  }

  Future<void> initButtonsAnimation() async {
    button1AnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    button1Animation = Tween<Offset>(begin: const Offset(0 , 7) , end:  const Offset(0 , 0)).animate(
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
    button2Animation = Tween<Offset>(begin: const Offset(0 , 7) , end:  const Offset(0 , 0)).animate(
      CurvedAnimation(
        parent: button2AnimationController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 300));
    button2AnimationController.forward();
  }
}
