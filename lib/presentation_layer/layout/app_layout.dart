import 'package:bebo_auto_service/business_logic_layer/app_cubit/app_cubit.dart';
import 'package:bebo_auto_service/business_logic_layer/app_cubit/app_states.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

import '../../components/app_locale.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {

  void getInit() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CarCubit>(context),
      child: BlocConsumer<CarCubit,CarStates>(
        listener: (context,state) {},
        builder: (context,state) {
          return Scaffold(
            body: CarCubit.get(context).screens[CarCubit.get(context).currentIndex],
            bottomNavigationBar: SizedBox(
              height: 71,
              child: BottomNavigationBar(
                backgroundColor: const Color.fromRGBO(35, 33, 33, 1.0),
                selectedItemColor: Color.fromRGBO(210, 29, 29, 1.0),
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white54,
                elevation: 20,

                unselectedFontSize: 14,
                currentIndex: CarCubit.get(context).currentIndex,
                onTap: (index){
                  CarCubit.get(context).changeBottomNav(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Icon(
                          FontAwesomeIcons.houseChimney,
                        size: 20,

                      ),
                    ),
                    label: '${getLang(context, 'Home')}',
                  ),
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Icon(
                        FontAwesomeIcons.car,
                        size: 20,
                      ),
                    ),
                    label: '${getLang(context, 'My Car')}',

                  ),
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Icon(
                        FontAwesomeIcons.list,
                        size: 20,
                      ),
                    ),
                    label: '${getLang(context, 'Price list')}',
                  ),
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Icon(
                        FontAwesomeIcons.fireFlameCurved,
                        size: 20,
                      ),
                    ),
                    label: '${getLang(context, 'Offers')}',
                  ),
                  BottomNavigationBarItem(
                    icon: const Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Icon(
                        FontAwesomeIcons.gear,
                        size: 20,
                      ),
                    ),
                    label: '${getLang(context, 'Settings')}',
                  ),
                ],
              ),
            )  /*BottomBarDoubleBullet(
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
            )*/,
          );
        },
      ),
    );
  }
}


