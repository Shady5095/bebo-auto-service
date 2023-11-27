import 'package:bebo_auto_service/business_logic_layer/main_app_cubit/main_app_cubit.dart';
import 'package:bebo_auto_service/presentation_layer/features/intro_and_start/start_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../../../components/constans.dart';
import '../../../../data_layer/local/cache_helper.dart';
import '../../home/home_screen/blur_home_screen.dart';
import '../intro_screen/intro_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool? onBoarding = CacheHelper.getBool(key: 'onBoarding');
    myUid = CacheHelper.getString(key: 'uId');
    Widget startScreen() {
      if(onBoarding==true){
        if(myUid!=null){
          return const SplashScreen();
        }
        else if(CacheHelper.getString(key: 'chassisNo') != null) {
          MainAppCubit.get(context).isChassisNoAccepted(CacheHelper.getString(key: 'chassisNo')!);
          return const SplashScreen();
        }

          else {
            return const BlurHomeScreen();
          }
        }
      return const IntroScreen();
      }
    return startScreen();
    }
}
