import 'package:bebo_auto_service/business_logic_layer/main_app_cubit/main_app_cubit.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../data_layer/local/cache_helper.dart';
import '../../widgets/my_alert_dialog.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      if(CacheHelper.getBool(key: 'pointsDialogSeen')==null){
        await showDialog(context: context, builder: (context)=> MyAlertDialog(
          actions: const [],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Icon(
                  CupertinoIcons.gift,
                  color: defaultColor,
                  size: 70.sp,
                )
              ),
              Text(
                'دلوقتي مع كل صيانه هتعملها ليك نقاط تقدر تستبدلها بخصم علي صيانتك القادمه ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp
                ),
              ),
              Text(
                '100 نقطه = 100 جنيه ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp
                ),
              ),
            ],
          ),
        ));
        CacheHelper.putBool(key: 'pointsDialogSeen', value: true);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'تقدم النقاط',
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context)=> MyAlertDialog(
              actions: const [],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Icon(
                        CupertinoIcons.gift,
                        color: defaultColor,
                        size: 70.sp,
                      )
                  ),
                  Text(
                    'دلوقتي مع كل صيانه هتعملها ليك نقاط تقدر تستبدلها بخصم علي صيانتك القادمه ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp
                    ),
                  ),
                  Text(
                    '100 نقطه = 100 جنيه ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp
                    ),
                  ),
                ],
              ),
            ));
          }, icon:  Icon(
            CupertinoIcons.info,
            size: 20.sp,
          ))
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration:  BoxDecoration(
                color: const Color.fromRGBO(2, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'قم بعمل 3 صيانات متتاليه واربح ${pointsGainedAcordingToCarYear(context)} نقطه ',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  LayoutBuilder(
                    builder: (context,constrains) {
                      return LinearPercentIndicator(
                        width: constrains.maxWidth,
                        isRTL: true,
                        linearGradient: const LinearGradient(colors: [
                          defaultColor,
                          Color.fromRGBO(161, 18, 18, 1.0)
                        ]),
                        barRadius: const Radius.circular(15),
                        lineHeight: 14.0,
                        percent: MainAppCubit.get(context).userData!.serviceStreak == null ? 0 : (MainAppCubit.get(context).userData!.serviceStreak!/3).toDouble(),
                        backgroundColor: Colors.grey[800],
                        //progressColor: defaultColor,
                      );
                    }
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        MainAppCubit.get(context).userData!.serviceStreak == null ? '0/3' : '${MainAppCubit.get(context).userData!.serviceStreak}/3',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String pointsGainedAcordingToCarYear(context){
    if(MainAppCubit.get(context).userData!.year! < 2015 ){
      return '300' ;
    }
    else {
      return '450' ;
    }
  }
}
