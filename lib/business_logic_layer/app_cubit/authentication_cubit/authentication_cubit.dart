import 'package:bebo_auto_service/business_logic_layer/app_cubit/authentication_cubit/authentication_states.dart';
import 'package:bebo_auto_service/presentation_layer/layout/app_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/components.dart';
import '../../../components/constans.dart';
import '../../../data_layer/local/cache_helper.dart';
import '../../../data_layer/models/user_model.dart';
import '../../../data_layer/network/dio_helper.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(IntStateRegister());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  IconData suffix = Icons.visibility_off_outlined;
  
  var db = FirebaseFirestore.instance ;

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
    UserModel userModel = UserModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
      uId: null,
      points: 200,
      carModel: carModel,
      year: year,
      color: color,
      plate: plate,
      transmission: transmission,
      bodyType: bodyType,
      km: km,
      chassisNo: chassisNo,
      engineNo: engineNo,
    );
    await db
        .collection('unverifiedUsers')
        .add(userModel.toMap())
        .then((value) {
      emit(RegisterSuccessState());
      db.collection('unverifiedUsers').doc(value.id).update({
        'newUserId' : value.id,
        'time' : FieldValue.serverTimestamp()
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'تم التسجيل بنجاح ... برجاء الانتظار لحين تفعيل الحساب من قبل المركز'),
        duration: Duration(seconds: 6),
        backgroundColor: Colors.green,
      ));
      DioHelper.pushNotification(
          data: {
          'to' : '/topics/admin',
          'notification' : {
          "title": "عميل جديد بأنتظار الموافقة",
          "body": '$firstName $lastName ($carModel $year)',
          "sound": "default",
          },
          'data' : {
          "docId": value.id,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
          },
          }
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
      emit(RegisterErrorState());
      print(error);
    });
  }

  Future<void> userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((userCredential)  async {
        emit(LoginSuccessState());
        print(userCredential.user!.uid);
        await CacheHelper.putString(key: 'uId', value: userCredential.user!.uid)
            .then((value) async {
          myUid = userCredential.user?.uid;
          navigateAndFinish(
            context: context,
            widget: const AppLayout(),
            animation: PageTransitionType.leftToRight,
          );
        });

      });
    }
    on FirebaseAuthException catch (e) {
      print(e.message);
      emit(LoginErrorState());
      String? errorText ;
      switch (e.message){
        case 'There is no user record corresponding to this identifier. The user may have been deleted.' : {
          errorText = 'هذا الحساب غير متوفر او لم يتم قبوله من قبل المسئول' ;
        }
        break ;
        case 'We have blocked all requests from this device due to unusual activity. Try again later.' : {
          errorText = 'برجاء المحاوله بعد قليل لتسجيلك بكلمه سر خاطئة عده مرات' ;
        }
        break ;
        case 'The password is invalid or the user does not have a password.' : {
          errorText = 'كلمه السر خاطئة' ;
        }
        break ;
        case 'An internal error has occurred. [ INVALID_LOGIN_CREDENTIALS ]' : {
          errorText = 'هذا الحساب غير متوفر او لم يتم قبوله من قبل المسئول' ;
        }
        break ;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$errorText'),
        backgroundColor: Colors.red,
      ));
    }

  }
  void resetPassword({
    required String email,
    required BuildContext context,
  }){

    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(ResetPasswordState());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password reset link was sent to $email'),
      ));
    }).catchError((error){
      if(error.toString() == '[firebase_auth/channel-error] Unable to establish connection on channel.'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please enter your email'),
          backgroundColor: Colors.red,
        ));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$email was not exist'),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

}
