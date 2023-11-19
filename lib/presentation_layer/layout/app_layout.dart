import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/screens/chats_screens/chat_details_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/offers_screens/offers_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

import '../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../business_logic_layer/main_app_cubit/main_app_states.dart';

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
        }
      }
      return null;
    });
  }

  @override
  void initState() {
    super.initState();
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
      }
    });
    getInit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainAppCubit>(context),
      child: BlocConsumer<MainAppCubit, MainAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: MainAppCubit.get(context)
                .screens[MainAppCubit.get(context).currentIndex],
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
                BottomNavigationBarItem(
                  icon:  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Icon(
                      FontAwesomeIcons.list,
                      size: 19.sp,
                    ),
                  ),
                  label: 'قطع الغيار',
                ),
                BottomNavigationBarItem(
                  icon:  ImageIcon(
                    size: 21.sp,
                    const AssetImage(
                      'assets/icons/carSell.png'
                    ),
                  ),
                  label: 'سيارات للبيع',
                ),
                BottomNavigationBarItem(
                  icon:  Stack(
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
                              radius: 5.r,
                            );
                          }
                      ),
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
          );
        },
      ),
    );
  }
}
