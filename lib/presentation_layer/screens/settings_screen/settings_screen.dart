import 'package:bebo_auto_service/business_logic_layer/app_cubit/app_cubit.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../components/app_locale.dart';
import '../../../components/components.dart';
import '../../../data_layer/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${getLang(context, 'Settings')}',
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
                  onTap: (){},
                  splashColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(10),
                  leading: Icon(
                    CupertinoIcons.person,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  title: Text(
                    '${getLang(context, 'Profile')}',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                ),
                ListTile(
                  onTap: (){
                    CarCubit.get(context).appLang(isArabic: !isArabic(context));
                  },
                  splashColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(10),
                  leading: Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  title: Text(
                    '${getLang(context, 'Change Language')}',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                ),
                ListTile(
                  onTap: (){},
                  splashColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(10),
                  leading: Icon(
                    FontAwesomeIcons.car,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  title: Text(
                    '${getLang(context, 'Change my car info')}',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                ),
                ListTile(
                  onTap: (){},
                  splashColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(10),
                  leading: Icon(
                    CupertinoIcons.phone,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  title: Text(
                    '${getLang(context, 'Contact us')}',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white
                    ),
                  ),
                ),
                ListTile(
                  onTap: (){},
                  splashColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(10),
                  leading: Icon(
                    Icons.logout_sharp,
                    color: Colors.red,
                    size: 24.sp,
                  ),
                  title: Text(
                    '${getLang(context, 'Log out')}',
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
}
