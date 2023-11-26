import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/features/my_car/screens/invoices_screen/invoices_screen.dart';
import 'package:bebo_auto_service/presentation_layer/features/my_car/screens/maintenance_schedule_screen/maintenance_schedule_screen.dart';
import 'package:bebo_auto_service/presentation_layer/features/my_car/screens/my_car_reports_sceens/listed_reports_screen.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../../../../business_logic_layer/main_app_cubit/main_app_states.dart';
import '../../../../../data_layer/models/user_model.dart';
import '../../../../widgets/my_alert_dialog.dart';


class MyCarScreen extends StatefulWidget {
  const MyCarScreen({Key? key}) : super(key: key);

  @override
  State<MyCarScreen> createState() => _MyCarScreenState();
}

class _MyCarScreenState extends State<MyCarScreen> {
  List menuItemsDetails = [
    {
      'title': 'الفواتير والصيانات السابقه',
      'description': 'أحصل علي كل الفواتير السابقه ومواعيدها'
    },
    {
      'title': 'معاد الصيانه القادم',
      'description': 'أحصل على جدول الصيانة وموعد الصيانة التالي'
    },
    {
      'title': 'تقرير عن سيارتي',
      'description': 'أحصل على تقرير مفصل عن كل قطعة وحالتها '
    },
  ];
  var formKey = GlobalKey<FormState>();
  var kmController = TextEditingController();
  double oldKm =0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainAppCubit,MainAppStates>(
      listener: (context,state){},
      builder: (context,state){
        oldKm = MainAppCubit.get(context).userData!.km!.toDouble() ;
        UserModel? userData = MainAppCubit.get(context).userData ;
        return Scaffold(
          backgroundColor: defaultBackgroundColor,
          appBar: AppBar(
            backgroundColor: defaultBackgroundColor,
            elevation: 0,
            toolbarHeight: 45.h,
            title: Text(
              'سيارتي',
              style: TextStyle(
                  fontSize: 22.sp
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 9).w,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.11,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            //height: MediaQuery.of(context).size.height * 0.25,
                            padding: const EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(2, 0, 0, 0.3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 28.h,
                                ),
                                Text(
                                  '${userData!.carModel} ${userData.year}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      //height: 0.5.h,
                                      fontSize: 22.sp),
                                ),
                                Text(
                                  '${userData.bodyType} | ${userData.transmission}',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14.sp,
                                    //height: 1.4.sp,
                                  ),
                                ),
                                Text(
                                  '${userData.plate}',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14.sp,
                                    //height: 1.4.sp,
                                  ),
                                ),
                                Text(
                                  '${userData.km!.addCommaToInt()} كم ',
                                  style: TextStyle(
                                    color: defaultColor,
                                    fontSize: 14.sp,
                                    //height: 1.2.h,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'شاسيه : ',
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12.sp,
                                            height: 1.2.h,
                                          ),
                                        ),
                                        Text(
                                          '${MainAppCubit.get(context).userData!.chassisNo}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            height: 1.2.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'ماتور : ',
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12.sp,
                                            height: 1.2.h,
                                          ),
                                        ),
                                        Text(
                                          '${MainAppCubit.get(context).userData!.engineNo}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            height: 1.2.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Center(
                          child: Image(
                            width: displayWidth(context) * 0.7,
                            height: displayHeight(context) * 0.18,
                            image: CachedNetworkImageProvider(userData.carImage??'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_red.png?alt=media&token=dbf503b1-7c2f-4f9b-b1e8-8eebbf4ead5b'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimationLimiter(
                  child: ListView.builder(
                    itemCount: menuItemsDetails.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: buildMenuItems(menuItemsDetails[index] , context , index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMenuItems(Map<String,dynamic> menuModel , BuildContext context , int index) => InkWell(
    onTap: (){
      switch(index) {
        case  0 :
        {
          navigateToAnimated(
              context: context,
              widget: const InvoicesScreen(),
              animation: PageTransitionType.leftToRight
          );
        }
        break ;
        case  1 :
        {
          showDialog(context: context, builder: (context)=>updateKmDialog());
        }
        break ;
        case  2 :
        {
          navigateToAnimated(
            context: context,
            widget: const ListedReportsScreen()
          );
        }
        break ;
      }

    },
    child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            height: 90.h,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(2, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(15).r
            ),
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.zero ,
                      bottomLeft: Radius.zero ,
                      bottomRight:  const Radius.circular(20).r ,
                      topRight: const Radius.circular(20).r ,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${menuModel['title']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Expanded(
                        child: Text(
                          '${menuModel['description']}',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 11.sp
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
  );

  Widget updateKmDialog()=> MyAlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'برجاء ادخال عداد الكيلومتر الحالي لعرض معاد الصيانة القادم',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                controller: kmController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                ],
                style: TextStyle(
                    color: Theme.of(context)
                        .secondaryHeaderColor,
                    fontSize: 13.sp),
                decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.all(5),
                    labelStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                    prefixIconColor: Theme.of(context)
                        .secondaryHeaderColor,
                    suffixIconColor: Theme.of(context)
                        .secondaryHeaderColor,
                    labelText: 'عداد الكيلومتر الحالي',
                    prefixIcon: const Icon(
                        CupertinoIcons.speedometer),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .secondaryHeaderColor,
                        ))),
                autovalidateMode:
                AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء ادخال البيانات';
                  }
                  if (value != '' &&
                      value.toDouble() < oldKm) {
                    return 'العداد الحالي اقل من العداد السابق';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultButton(
          onTap: () {
            if (formKey.currentState!.validate()) {
              navigateToAnimated(
                context: context,
                widget: MaintenanceScheduleScreen(km: kmController.text.toInt()),
              );
            }
          },
          text: 'تم',
          width: displayWidth(context) * 0.23,
          height: 28.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: defaultColor,
          ),
        ),
      ),
    ],
  );
}
