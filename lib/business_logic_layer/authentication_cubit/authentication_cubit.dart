import 'package:bebo_auto_service/components/car_images_url.dart';
import 'package:bebo_auto_service/presentation_layer/features/home/layout/app_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/components.dart';
import '../../components/constans.dart';
import '../../data_layer/local/cache_helper.dart';
import '../../data_layer/models/user_model.dart';
import '../../data_layer/network/dio_helper.dart';
import '../main_app_cubit/main_app_cubit.dart';
import 'authentication_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(IntStateRegister());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  IconData suffix = Icons.visibility_off_outlined;

  var db = FirebaseFirestore.instance;

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
    required int year,
    required String color,
    required String plate,
    required String transmission,
    required String bodyType,
    required int km,
    required String chassisNo,
    required String engineNo,
    required BuildContext context,
  }) async {
    emit(RegisterLoadingState());
    bool isChassisNoExists = await isChassisNoExistsBefore(chassisNo);
    if(isChassisNoExists){
      emit(ChassisNoExistsBeforeState());
    }
    else{
      String carImageUrl = carPhotoUrl(carModel: carModel, carYear: year, carColor: color);
      UserModel userModel = UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
        uId: null,
        points: 100,
        carModel: carModel,
        year: year,
        color: color,
        plate: plate,
        transmission: transmission,
        bodyType: bodyType,
        km: km,
        chassisNo: chassisNo,
        engineNo: engineNo,
        serviceStreak: 0,
        carImage: carImageUrl,
      );
      await db.collection('unverifiedUsers').add(userModel.toMap()).then((value) {
        emit(RegisterSuccessState());
        db.collection('unverifiedUsers').doc(value.id).update(
            {'newUserId': value.id, 'time': FieldValue.serverTimestamp()});
        DioHelper.pushNotification(data: {
          'to': '/topics/admin',
          'notification': {
            "title": "عميل جديد بأنتظار الموافقة",
            "body": '$firstName $lastName ($carModel $year)',
            "sound": "default",
          },
          'data': {
            "newUserDocId": value.id,
            "click_action": "FLUTTER_NOTIFICATION_CLICK"
          },
        });
        FirebaseMessaging.instance.subscribeToTopic(chassisNo); // to send to customer notification when he accepted
        CacheHelper.putString(key: 'chassisNo', value: chassisNo);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ));
        emit(RegisterErrorState());
      });
    }
  }

  Future<bool> isChassisNoExistsBefore(String chassisNo) async {
    bool isExists = false ;
    await db.collection('unverifiedUsers').get().then((value) {
      for(var doc in value.docs){
        if(doc.data()['chassisNo'] == chassisNo){
          isExists =  true ;
        }
      }
    });
    if(!isExists){
      await db.collection('verifiedUsers').get().then((value) {
        for(var doc in value.docs){
          if(doc.data()['chassisNo'] == chassisNo){
            isExists =  true ;
          }
        }
      });
    }
    return isExists ;
  }

  Future<void> userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: '$email@gmail.com',
        password: password,
      )
          .then((userCredential) async {
        await CacheHelper.putString(key: 'password', value: password);
        await CacheHelper.putString(key: 'uId', value: userCredential.user!.uid)
            .then((value) async {
          myUid = userCredential.user?.uid;
          await MainAppCubit.get(context).getUserData().then((value) async {
            await precacheImage(
               CachedNetworkImageProvider(
                  value!.carImage??'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/carImages%2FMazda3%2F2021-2024%2Fmazda3_2020_red.png?alt=media&token=dbf503b1-7c2f-4f9b-b1e8-8eebbf4ead5b'),
              context,
            ).then((value) {
              emit(LoginSuccessState());
              db.collection('verifiedUsers').doc(userCredential.user!.uid).get().then((value) {
                if(value.exists){
                  navigateAndFinish(
                    context: context,
                    widget: const AppLayout(),
                    animation: PageTransitionType.leftToRight,
                  );
                  FirebaseMessaging.instance.subscribeToTopic('all');
                  FirebaseMessaging.instance.subscribeToTopic(myUid!);
                }
                else{
                  myUid = null ;
                  FirebaseMessaging.instance.unsubscribeFromTopic('all');
                  CacheHelper.removeData(key: 'uId');
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('تم حذف حسابك'),
                    backgroundColor: Colors.red,
                  ));
                  userCredential.user!.delete();
                }
              });
            });
          });
        });
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      String? errorText;
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          {
            errorText = 'هذا الحساب غير متوفر او لم يتم قبوله من قبل المسئول';
          }
          break;
        case 'We have blocked all requests from this device due to unusual activity. Try again later.':
          {
            errorText =
                'برجاء المحاوله بعد قليل لتسجيلك بكلمه سر خاطئة عده مرات';
          }
          break;
        case 'The password is invalid or the user does not have a password.':
          {
            errorText = 'كلمه السر خاطئة';
          }
          break;
        case 'An internal error has occurred. [ INVALID_LOGIN_CREDENTIALS ]':
          {
            errorText = 'هذا الحساب غير متوفر او لم يتم قبوله من قبل المسئول';
          }
          break;
        case '"INVALID_LOGIN_CREDENTIALS"':
          {
            errorText = 'هذا الحساب غير متوفر او لم يتم قبوله من قبل المسئول';
          }
          break;
      }
      emit(LoginErrorState(errorText??''));

    }
  }

  void resetPassword({
    required String email,
    required BuildContext context,
  }) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(ResetPasswordState());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(' تم ارسال رابط تغيير كلمه السر لبريد اليكتروني  :  $email'),
      ));
    }).catchError((error) {
      if (error.toString() ==
          '[firebase_auth/channel-error] Unable to establish connection on channel.') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('برجاء ادخال البريد الاليكتروني لارسال رابط لتغيير كلمه المرور'),
          backgroundColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$email  غير متوفر  '),
          backgroundColor: Colors.red,
        ));
      }
    });
  }
}
