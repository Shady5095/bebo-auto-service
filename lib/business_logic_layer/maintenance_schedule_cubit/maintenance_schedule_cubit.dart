import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'maintenance_schedule_state.dart';

class MaintenanceScheduleCubit extends Cubit<MaintenanceScheduleState> {
  MaintenanceScheduleCubit() : super(MaintenanceScheduleInitial());

  static MaintenanceScheduleCubit get(context) => BlocProvider.of(context);

  List<String> maintenance10000 = [
    'تغيير زيت المحرك وفلتر الزيت',
    'تغيير فلتر التكييف',
    'فحص منظومة الفرامل',
    'فحص السيور',
    'فحص كاوتش الكولبن',
    'فحص جلب المقصات',
    'فحص مياه التبريد',
    'فحص زيت الباور',
    'تبديل الاطارات',
  ];

  List<String> maintenance20000= [
    'تغيير فلتر الهواء',
    'فحص العفشة',
    'فحص البطارية',
    'فحص منظومة التبريد',
    'فحص فلتر البنزين ومنظومة الوقود',
  ];

  List<String> maintenance30000= [
    'تغيير بوجيهات',
    'تغيير زيت الفرامل',
    'فحص دايره التكييف',
    'فحص منظومه العادم',
    'فحص زيت الفتيس',
  ];

  int calculateNextMaintenance(int km) {
    // For simplicity, let's assume that maintenance should be done every 10000 km
    int maintenanceInterval = 10000;

    int remainingKm = km % maintenanceInterval;

    if (remainingKm == 0) {
      // If the car has already been maintenance, calculate for the next interval
      return km ;
    } else {
      // If the car hasn't been maintenance, calculate the remaining km for the next interval
      return km + maintenanceInterval - remainingKm;
    }
  }

  List<int> currentKmMaintenanceWillDone(int km){
    List<int> currentKmMaintenanceWillDone = [10000];
    int nextMaintenance = calculateNextMaintenance(km);
    if(nextMaintenance % 20000 == 0 ){
      currentKmMaintenanceWillDone.add(20000);
    }
    if(nextMaintenance % 30000 == 0 ){
      currentKmMaintenanceWillDone.add(30000);
    }
    return currentKmMaintenanceWillDone ;
  }
}
