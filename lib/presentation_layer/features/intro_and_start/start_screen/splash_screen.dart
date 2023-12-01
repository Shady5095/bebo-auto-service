import 'package:bebo_auto_service/business_logic_layer/rating_cubit/rating_cubit.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/local/cache_helper.dart';
import 'package:bebo_auto_service/presentation_layer/features/home/layout/app_layout.dart';
import 'package:bebo_auto_service/presentation_layer/features/home/home_screen/blur_home_screen.dart';
import 'package:bebo_auto_service/presentation_layer/features/rating/rating_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../../../business_logic_layer/main_app_cubit/main_app_states.dart';
import 'create_password_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainAppCubit>(context)..getUserData(),
      child: BlocConsumer<MainAppCubit, MainAppStates>(
        listener: (context, state)  {
          if(state is ChassisNoCheckState){
            if(state.isChassisNoExist){
              navigateAndFinish(
                  context: context,
                  widget: CreatePasswordForFirstTimeScreen(chassisNo: CacheHelper.getString(key: 'chassisNo')!)
              );
            }
            else {
              navigateAndFinish(
                context: context,
                widget: const BlurHomeScreen(),
              );
            }
          }
          if (state is GetUserDataSuccessState && myUid != null && FirebaseAuth.instance.currentUser != null) {
             precacheImage(
               CachedNetworkImageProvider(
                  state.userModel.carImage??'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_red.png?alt=media&token=dbf503b1-7c2f-4f9b-b1e8-8eebbf4ead5b'),
              context,
            ).then(
              (value) async {
                if(state.userModel.email != null){
                  AuthCredential credential = EmailAuthProvider.credential(
                    email: state.userModel.email!,
                    password: CacheHelper.getString(key: 'password')??'0',
                  );
                  // ReAuthenticate with old password to check if password change or not
                  await FirebaseAuth.instance.currentUser!
                      .reauthenticateWithCredential(credential).then((value) {
                    RatingCubit.get(context).isLastServiceRated().then((value) {
                      if(value == null){
                        navigateAndFinish(
                          context: context,
                          widget: const AppLayout(),
                        );
                      }
                      else{
                        navigateAndFinish(
                          context: context,
                          widget: RatingScreen(serviceDocId: value),
                        );
                      }
                    });
                  }).catchError((error){
                    if(context.mounted){
                      FirebaseAuth.instance.signOut();
                      FirebaseMessaging.instance.unsubscribeFromTopic('all');
                      CacheHelper.removeData(key: 'uId');
                      myUid = null ;
                      navigateAndFinish(
                        context: context,
                        widget: const BlurHomeScreen(),
                      );
                    }
                  });
                }
                else{
                  FirebaseAuth.instance.signOut();
                  FirebaseMessaging.instance.unsubscribeFromTopic('all');
                  CacheHelper.removeData(key: 'uId');
                  myUid = null ;
                  navigateAndFinish(
                    context: context,
                    widget: const BlurHomeScreen(),
                  );
                }
              },
            );
          }
          if (state is GetUserDataErrorState){
            FirebaseAuth.instance.signOut();
            FirebaseMessaging.instance.unsubscribeFromTopic('all');
            CacheHelper.removeData(key: 'uId');
            myUid = null ;
            navigateAndFinish(
              context: context,
              widget: const BlurHomeScreen(),
            );
          }
          /*else
            {
              myUid = null ;
              FirebaseAuth.instance.signOut();
              FirebaseMessaging.instance.unsubscribeFromTopic('all');
              CacheHelper.removeData(key: 'uId');
              navigateAndFinish(
                context: context,
                widget: const BlurHomeScreen(),
              );
            }*/
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(60).h,
                decoration: const BoxDecoration(color: defaultBackgroundColor),
                child: Image.asset('assets/images/logo.png')
              ),
            ),
          );
        },
      ),
    );
  }
}
