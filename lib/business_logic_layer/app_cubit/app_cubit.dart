import 'dart:convert';

import 'package:bebo_auto_service/presentation_layer/screens/home_screen/home_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/my_car_screen/my_car_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/offers_screen/offers_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/price_list_screen/price_list_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/settings_screen/settings_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_layer/local/cache_helper.dart';
import 'app_states.dart';

class CarCubit extends Cubit<CarStates> {
  CarCubit() : super(IntStateCar());

  static CarCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0 ;

  List<Widget> screens = [
    const HomeScreen(),
    const MyCarScreen(),
    const PriceListScreen(),
    const OffersScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index ;
    emit(ChangeBottomNavState());
  }

  late List categoriesGrid ;
  Future<void> categoriesGridJson() async {
    final String response = await rootBundle.loadString('assets/part_categories_grid.json');
    final data = await json.decode(response);
    categoriesGrid = data['items'];
  }

  bool? isArabic ;
  void appLang({
    bool? fromShared ,
    bool? isArabic,
  }){
    if(fromShared != null){
      this.isArabic = fromShared ;
      emit(ChangeAppLang());
    }
    else if(isArabic != null) {
      this.isArabic = isArabic ;
      CacheHelper.putBool(key: 'isArabic', value: isArabic).then((value) {
        emit(ChangeAppLang());
      });
    }
    else
    {
      this.isArabic = null ;
      CacheHelper.removeData(key: 'isArabic',)?.then((value) {
        emit(ChangeAppLang());
      });
    }
  }
}