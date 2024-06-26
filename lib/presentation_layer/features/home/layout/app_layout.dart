import 'dart:async';
import 'dart:io';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/features/chat/screens/chat_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../../../business_logic_layer/main_app_cubit/main_app_states.dart';
import '../../../../data_layer/local/cache_helper.dart';
import '../../offers/offers_screen.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  void getInit() async {
    await FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        for (var key in value.data.keys) {
          if (key == 'newOffer') {
            navigateTo(
              context: context,
              widget: const OffersScreen(),
            );
          }
          if (key == 'newMessage') {
            navigateTo(
              context: context,
              widget: const ChatsDetailsScreen(),
            );
          }
          if (key == 'notificationTitle' || key == 'notificationDescription') {
            showDialog(
              context: context,
              builder: (context) => notificationDialog(value),
            );
          }
        }
      }
      return null;
    });
  }

  Widget notificationDialog(RemoteMessage value) {
    return AlertDialog(
      icon: Icon(
        Icons.notifications_active_outlined,
        color: defaultColor,
        size: 40.sp,
      ),
      contentPadding: EdgeInsets.only(
        bottom: 4.h,
        top: 12.h,
        right: 12.w,
        left: 12.w,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      backgroundColor: defaultBackgroundColor,
      //this right here
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${value.data['notificationTitle']}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '${value.data['notificationDescription']}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
  late StreamSubscription subscription ;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      for (var key in event.data.keys) {
        if (key == 'newOffer') {
          navigateTo(
            context: context,
            widget: const OffersScreen(),
          );
        }
        if (key == 'newMessage') {
          navigateTo(
            context: context,
            widget: const ChatsDetailsScreen(),
          );
        }
        if (key == 'notificationTitle' || key == 'notificationDescription') {
          showDialog(
            context: context,
            builder: (context) => notificationDialog(event)
          );
        }
      }
    });
    getInit();
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainAppCubit>(context),
      child: BlocConsumer<MainAppCubit, MainAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return UpgradeAlert(
            upgrader: Upgrader(
              dialogStyle: Platform.isIOS
                  ? UpgradeDialogStyle.cupertino
                  : UpgradeDialogStyle.material,
              canDismissDialog: false,
              countryCode: 'eg',
              languageCode: 'ar',
              showIgnore: false,
              showLater: false,
              //debugLogging: true,
              //debugDisplayAlways: true,
              durationUntilAlertAgain: const Duration(seconds: 1),
            ),
            child: Scaffold(
              body: myUid != null
                  ? MainAppCubit.get(context)
                      .signedINScreens[MainAppCubit.get(context).currentIndex]
                  : MainAppCubit.get(context)
                      .signedOutScreens[MainAppCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color.fromRGBO(35, 33, 33, 1.0),
                selectedItemColor: const Color.fromRGBO(210, 29, 29, 1.0),
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white54,
                elevation: 20,
                selectedFontSize: 12.sp,
                unselectedFontSize: 10.sp,
                currentIndex: MainAppCubit.get(context).currentIndex,
                onTap: (index) {
                  MainAppCubit.get(context).changeBottomNav(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Icon(
                        FontAwesomeIcons.houseChimney,
                        size: 19.sp,
                      ),
                    ),
                    label: 'الرئيسية',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.car_detailed,
                      size: 19.sp,
                    ),
                    label: 'سيارتي',
                  ),
                  if (myUid != null)
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Icon(
                          FontAwesomeIcons.list,
                          size: 19.sp,
                        ),
                      ),
                      label: 'قطع الغيار',
                    ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      size: 21.sp,
                      const AssetImage('assets/icons/carSell.png'),
                    ),
                    label: 'سيارات للبيع',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            Icons.more_horiz_outlined,
                            size: 19.sp,
                          ),
                        ),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('chats')
                                .doc(myUid ??
                                    CacheHelper.getString(key: 'chassisNo'))
                                .collection('messages')
                                .where('isSeen', isEqualTo: false)
                                .where('senderId', isEqualTo: 'admin')
                                .snapshots(),
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
                                backgroundColor: snapshot.data!.docs.isEmpty
                                    ? Colors.transparent
                                    : defaultColor,
                                radius: 5.r,
                              );
                            }),
                      ],
                    ),
                    label: 'المزيد',
                  ),
                ],
              ) /*BottomBarDoubleBullet(
                color: Color.fromRGBO(210, 29, 29, 1.0),
                selectedIndex: CarCubit.get(context).currentIndex,
                backgroundColor: Color.fromRGBO(35, 33, 33, 1.0),
                circle1Color: Colors.deepOrange,
                circle2Color: Colors.blueAccent,
                onSelect: (index){
                  CarCubit.get(context).changeBottomNav(index);
                },
                items: [
                  BottomBarItem(
                    iconData: FontAwesomeIcons.houseChimney,
                    label: 'Home',
                    iconSize: 20,
                  ),
                  BottomBarItem(
                      iconData: FontAwesomeIcons.car,
                      label: 'My car',
                    iconSize: 20,
                  ),
                  BottomBarItem(
                      iconData: FontAwesomeIcons.list,
                      label: 'Price list',
                    iconSize: 20,
                  ),
                  BottomBarItem(
                      iconData: Icons.discount_outlined,
                      label: 'Offers',
                    iconSize: 20,
                  ),
                  BottomBarItem(
                    iconData: FontAwesomeIcons.gear,
                    label: 'Settings',
                    iconSize: 20,
                  ),
                ],
              )*/
              ,
            ),
          );
        },
      ),
    );
  }
}
