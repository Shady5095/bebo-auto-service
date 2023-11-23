import 'package:bebo_auto_service/business_logic_layer/rating_cubit/rating_cubit.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/local/cache_helper.dart';
import 'package:bebo_auto_service/presentation_layer/layout/app_layout.dart';
import 'package:bebo_auto_service/presentation_layer/screens/home_screen/blur_home_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/rating_screen/rating_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../../business_logic_layer/main_app_cubit/main_app_states.dart';
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
          if (state is GetUserDataSuccessState && myUid != null) {
             precacheImage(
              const CachedNetworkImageProvider(
                  'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/mazda3.png?alt=media&token=4f914e91-5ad3-43e8-9b8b-ab5057018f9a'),
              context,
            ).then(
              (value) async {
                if(MainAppCubit.get(context).userData!.email != null){
                  AuthCredential credential = EmailAuthProvider.credential(
                    email: MainAppCubit.get(context).userData!.email!,
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
                    FirebaseMessaging.instance.unsubscribeFromTopic('all');
                    myUid = null ;
                    navigateAndFinish(
                      context: context,
                      widget: const BlurHomeScreen(),
                    );
                  });
                }
                else{
                  FirebaseMessaging.instance.unsubscribeFromTopic('all');
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
            FirebaseMessaging.instance.unsubscribeFromTopic('all');
            myUid = null ;
            navigateAndFinish(
              context: context,
              widget: const BlurHomeScreen(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: displayWidth(context),
              height: displayHeight(context),
              padding: const EdgeInsets.all(60).h,
              decoration: const BoxDecoration(color: defaultBackgroundColor),
              child: Image.asset('assets/images/logo.png')
            ),
          );
        },
      ),
    );
  }
}
