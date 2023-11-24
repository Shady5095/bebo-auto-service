import 'package:bebo_auto_service/business_logic_layer/maintenance_schedule_cubit/maintenance_schedule_cubit.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MaintenanceScheduleScreen extends StatefulWidget {
  final int km ;
  const MaintenanceScheduleScreen({super.key, required this.km});

  @override
  State<MaintenanceScheduleScreen> createState() =>
      _MaintenanceScheduleScreenState();

}

class _MaintenanceScheduleScreenState extends State<MaintenanceScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> m10000 = MaintenanceScheduleCubit.get(context).maintenance10000 ;
    List<String> m20000 = MaintenanceScheduleCubit.get(context).maintenance20000 ;
    List<String> m30000 = MaintenanceScheduleCubit.get(context).maintenance30000 ;
    List<int> listOfKmNum = MaintenanceScheduleCubit.get(context).currentKmMaintenanceWillDone(widget.km) ;
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'معاد الصيانة القادمة',
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: AnimationLimiter(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 500),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    Center(
                      child: Text(
                        'معاد الصيانة القادمة عند ${MaintenanceScheduleCubit.get(context).calculateNextMaintenance(widget.km).addCommaToInt()} كم',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'وستقوم بعمل الصيانة الدورية لكل 10,0000 كم وهي : -',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(m10000.length, (index) => Text(
                        '* ${m10000[index]}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp
                        ),
                      ),),
                    ),
                    if(listOfKmNum.contains(20000))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'وستقوم بعمل الصيانة الدورية لكل 20,0000 كم وهي : -',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(m20000.length, (index) => Text(
                              '* ${m20000[index]}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp
                              ),
                            ),),
                          ),
                        ],
                      ),
                    if(listOfKmNum.contains(30000))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'وستقوم بعمل الصيانة الدورية لكل 30,0000 كم وهي : -',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(m30000.length, (index) => Text(
                              '* ${m30000[index]}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp
                              ),
                            ),),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
