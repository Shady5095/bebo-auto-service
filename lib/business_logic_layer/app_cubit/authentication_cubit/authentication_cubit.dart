import 'package:bebo_auto_service/business_logic_layer/app_cubit/authentication_cubit/authentication_states.dart';
import 'package:bebo_auto_service/data_layer/repository/firebase/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/constans.dart';
import '../../../data_layer/local/cache_helper.dart';
import '../../../data_layer/models/user_model.dart';


class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(IntStateRegister());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  IconData suffix = Icons.visibility_off_outlined;
  FirebaseAuthRepo? firebaseAuthRepo;

  void changeSuffixIcon() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(PasswordChangeRegister());
  }

  Future<void> userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String carModel,
    required String year,
    required String color,
    required String plate,
    required String transmission,
    required String bodyType,
    required String km,
    required String chassisNo,
    required String engineNo,
    required BuildContext context,
  }) async {
    emit(RegisterLoadingState());
    await firebaseAuthRepo?.sendUnverifiedUserData(
        firstName: firstName,
        lastName: lastName,
        password: password,
        email: email,
        phone: phone,
        carModel: carModel,
        year: year,
        color: color,
        plate: plate,
        transmission: transmission,
        bodyType: bodyType,
        km: km,
        chassisNo: chassisNo,
        engineNo: engineNo
    ).then((value) {
      emit(RegisterSuccessState());
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('تم التسجيل بنجاح ... برجاء الانتظار لحين تفعيل الحساب من قبل المركز'),
        duration: Duration(seconds: 6),
        backgroundColor: Colors.green,
      ));
    }).catchError((error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
      emit(RegisterErrorState());
      print(error);
    });
  }

}