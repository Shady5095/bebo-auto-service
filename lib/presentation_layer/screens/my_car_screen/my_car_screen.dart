import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../components/app_locale.dart';

class MyCarScreen extends StatelessWidget {
  const MyCarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List menuItemsDetails = [
      {
        'title': '${getLang(context, 'Maintenance reports and receipts')}',
        'description': '${getLang(context, 'Maintenance reports and receipts..')}'
      },
      {
        'title': '${getLang(context, 'Maintenance schedule')}',
        'description': '${getLang(context, 'Maintenance schedule..')}'
      },
      {
        'title': '${getLang(context, 'Report on my car')}',
        'description': '${getLang(context, 'Report on my car..')}'
      },
    ];
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        backgroundColor: defaultBackgroundColor,
        elevation: 0,
        title: Text(
          '${getLang(context, 'My Car')}',
          style: TextStyle(
            fontSize: 22.sp
          ),
        ),
      ),
      body: Column(
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
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.25,
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
                            height: 48.h,
                          ),
                          Text(
                            'Mazda 3 2022',
                            style: TextStyle(
                                color: Colors.white,
                                height: 0.3.h,
                                fontSize: 22.sp),
                          ),
                          Text(
                            '${getLang(context, 'Sedan')} | ${getLang(context, 'Automatic')}',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14.sp,
                              height: 1.2.h,
                            ),
                          ),
                          Text(
                            ' ا ع ل 134',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14.sp,
                              height: 1.2.h,
                            ),
                          ),
                          Text(
                            '23,129 ${getLang(context, 'Km')}',
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 14.sp,
                              height: 1.2.h,
                            ),
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
                      image: AssetImage('assets/images/mazda3.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: menuItemsDetails.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: buildMenuItems(menuItemsDetails[index] , context),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget buildMenuItems(Map<String,dynamic> menuModel , BuildContext context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: 80.h,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color.fromRGBO(2, 0, 0, 0.3),
              borderRadius: BorderRadius.circular(20).r
          ),
          child: Row(
            children: [
              Container(
                width: 8.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: defaultColor,
                  borderRadius: BorderRadius.only(
                    topLeft: isArabic(context) ? Radius.zero : Radius.circular(20).r ,
                    bottomLeft: isArabic(context) ? Radius.zero : Radius.circular(20).r,
                    bottomRight: isArabic(context) ? Radius.circular(20).r : Radius.zero,
                    topRight: isArabic(context) ? Radius.circular(20).r : Radius.zero,
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
      );
}
