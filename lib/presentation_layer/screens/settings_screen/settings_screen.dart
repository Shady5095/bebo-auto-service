import 'package:bebo_auto_service/business_logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/screens/chats_screens/chat_details_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/home_screen/blur_home_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/my_profile_screen/my_profile_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/phone_numbers_screen/phone_numbers_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import '../../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../../components/components.dart';
import '../../../data_layer/local/cache_helper.dart';
import '../../widgets/my_alert_dialog.dart';
import '../complaint_screen/complaint_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'المزيد',
          style: TextStyle(
              fontSize: 22.sp
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 500),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                ListTile(
                  onTap: (){
                    navigateToAnimated(
                      context: context,
                      widget:  MyProfileScreen(userData: (MainAppCubit.get(context).userData)!),
                      animation: PageTransitionType.leftToRight
                    );
                  },
                  splashColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(10),
                  leading: Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  title: Text(
                    'تعديل الملف الشخصي',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                ),
                ListTile(
                  onTap: (){
                    navigateToAnimated(
                      context: context,
                      widget: const ComplaintScreen(),
                    );
                  },
                  splashColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(10),
                  leading: Icon(
                    CupertinoIcons.exclamationmark_bubble,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  title: Text(
                    'أرسال شكوي',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                ),
                ListTile(
                  onTap: (){
                    navigateToAnimated(
                      context: context,
                      widget: const ChatsDetailsScreen(),
                    );
                  },
                  splashColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(10),
                  leading: Icon(
                    CupertinoIcons.chat_bubble_2,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  title: Text(
                    'تواصل معنا',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                ),
                ListTile(
                  onTap: (){
                    navigateToAnimated(
                      context: context,
                      widget: const PhoneNumbersScreen(),
                    );
                  },
                  splashColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(10),
                  leading: Icon(
                    CupertinoIcons.phone,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  title: Text(
                    'ارقام التليفون و العناوين',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) =>  MyAlertDialog(
                        onTapYes: (){
                          logOut(context);
                        },
                        isFailed: true,
                        title: 'هل انت متأكد من تسجيل الخروج ؟',
                      ),
                    );
                  },
                  splashColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(10),
                  leading: Icon(
                    Icons.logout_sharp,
                    color: Colors.red,
                    size: 24.sp,
                  ),
                  title: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.red
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> logOut(context) async {
    await FirebaseAuth.instance.signOut();
    FirebaseMessaging.instance.unsubscribeFromTopic('all');
    FirebaseMessaging.instance.unsubscribeFromTopic(myUid!);
    CacheHelper.removeData(
        key: 'uId'
    )?.then((value) {
      if (value) {
        myUid = null ;
        Navigator.pushReplacement(context, PageTransition(
            type: PageTransitionType.fade,
            child: const BlurHomeScreen(),
            duration: const Duration(milliseconds: 500)
        ),
        );
      }
    });
  }
}