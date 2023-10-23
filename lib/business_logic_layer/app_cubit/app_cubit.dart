import 'dart:convert';

import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/models/user_model.dart';
import 'package:bebo_auto_service/presentation_layer/screens/home_screen/home_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/my_car_screen/my_car_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/offers_screen/offers_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/price_list_screen/price_list_screen.dart';
import 'package:bebo_auto_service/presentation_layer/screens/settings_screen/settings_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  var db = FirebaseFirestore.instance;

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

  UserModel? userData ;
  Future<void> getUserData() async {
    if(myUid != null){
      await db.collection('verifiedUsers').doc(myUid).get().then((value) {
        userData = UserModel.fromJson(value.data()!);
        emit(GetUserDataSuccessState());
      }).catchError((error){
        emit(GetUserDataErrorState());
      });
    }
  }
  Future<void> updateUserData({
  required String firstName,
  required String lastName,
  required String phone,
  required BuildContext context,
}) async {
    emit(UpdateUserDataLoadingState());
      await db.collection('verifiedUsers').doc(myUid).update({
        'firstName' : firstName,
        'lastName' : lastName,
        'phone' : phone,
      }).then((value) {
        getUserData();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('تم تحديث البيانات بنجاح'),
          backgroundColor: Colors.green,
        ));
      }).catchError((error){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ));
        emit(UpdateUserDataErrorState());
      });
  }
  Future<void> updateUserPassword({
  required String newPassword,
  required String currentPassword,
    required BuildContext context,
}) async {
    emit(UpdateUserPasswordLoadingState());
    AuthCredential credential = EmailAuthProvider.credential(
        email: userData!.email!,
        password: currentPassword,
    );
     // ReAuthenticate
    await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential).then((value) {
      // updatePassword
      FirebaseAuth.instance.currentUser?.updatePassword(newPassword).then((value) {
        emit(UpdateUserDataSuccessState());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('تم تغيير كلمه السر بنجاح'),
          backgroundColor: Colors.green,
        ));
      }).catchError((error){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ));
        emit(UpdateUserDataErrorState());
      });
    }).catchError((error){
      emit(UpdateUserDataErrorState());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('كلمه السر الحالية خاطئة'),
        backgroundColor: Colors.red,
      ));
    });

  }
}