import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/features/authentication/screens/login_screen/login_screen.dart';
import 'package:bebo_auto_service/presentation_layer/features/home/layout/app_layout.dart';
import 'package:bebo_auto_service/presentation_layer/features/more_features/about_screen/about_screen.dart';
import 'package:bebo_auto_service/presentation_layer/features/chat/screens/chat_details_screen.dart';
import 'package:bebo_auto_service/presentation_layer/features/more_features/my_profile_screen/my_profile_screen.dart';
import 'package:bebo_auto_service/presentation_layer/features/more_features/phone_numbers_screen/phone_numbers_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../../../components/components.dart';
import '../../../../data_layer/local/cache_helper.dart';
import '../../../widgets/my_alert_dialog.dart';
import '../complaint_screen/complaint_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 45.h,
        title: Text(
          'المزيد',
          style: TextStyle(
              fontSize: 22.sp
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AnimationLimiter(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
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
                  if(myUid != null)
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
                  if(myUid ==null)
                  ListTile(
                    onTap: (){
                      navigateToAnimated(
                        context: context,
                        widget: const LoginScreen(),
                      );
                    },
                    splashColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(10),
                    leading: Icon(
                      Icons.login,
                      color: defaultColor,
                      size: 24.sp,
                    ),
                    title: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: defaultColor
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
                    contentPadding: const EdgeInsets.all(10),
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
                  if(myUid != null)
                  ListTile(
                    onTap: (){
                      navigateToAnimated(
                        context: context,
                        widget: const ChatsDetailsScreen(),
                      );
                    },
                    splashColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(10),
                    leading: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0,top: 12),
                          child: Icon(
                            CupertinoIcons.chat_bubble_2,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('chats').doc(myUid).collection('messages').where('isSeen',isEqualTo: false).where('senderId',isEqualTo: 'admin').snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Icon(
                                    Icons.warning_amber,
                                    color: Colors.red,
                                    size: 10,
                                  ),
                                );
                              }
                              if (!snapshot.hasData) {
                                return const SizedBox();
                              }
                              if ((snapshot.data?.docs.isEmpty)!) {
                                return const SizedBox();
                              }
                              return CircleAvatar(
                                backgroundColor: snapshot.data!.docs.isEmpty ? Colors.transparent : defaultColor,
                                radius: 8.r,
                                child: Center(
                                  child: Text(
                                    '${snapshot.data?.docs.length}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        height: 1.2,
                                        color: snapshot.data!.docs.isEmpty ? Colors.transparent : Colors.white
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ],
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
                    contentPadding: const EdgeInsets.all(10),
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
                    onTap: (){
                      navigateToAnimated(
                        context: context,
                        widget: const AboutScreen(),
                      );
                    },
                    splashColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(10),
                    leading: Icon(
                      Icons.info_outlined,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                    title: Text(
                      'عن المركز',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white
                      ),
                    ),
                  ),
                  if(myUid != null)
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
      ),
    );
  }
  Future<void> logOut(context) async {
    await FirebaseAuth.instance.signOut();
    FirebaseMessaging.instance.unsubscribeFromTopic('all');
    FirebaseMessaging.instance.unsubscribeFromTopic(myUid??'');
    CacheHelper.removeData(
        key: 'uId'
    )?.then((value) {
      if (value) {
        myUid = null ;
        MainAppCubit.get(context).changeBottomNav(0);
        MainAppCubit.get(context).userData = null ;
        navigateAndFinish(context: context, widget: const AppLayout(),);
      }
    });
  }
}