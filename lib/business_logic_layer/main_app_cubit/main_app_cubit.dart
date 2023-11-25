import 'dart:convert';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/models/user_model.dart';
import 'package:bebo_auto_service/presentation_layer/features/home/home_screen/home_screen.dart';
import 'package:bebo_auto_service/presentation_layer/features/my_car/screens/my_car_screen/my_car_screen.dart';
import 'package:bebo_auto_service/presentation_layer/features/more_features/settings_screen/settings_screen.dart';
import 'package:bebo_auto_service/presentation_layer/widgets/my_alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data_layer/local/cache_helper.dart';
import '../../data_layer/network/dio_helper.dart';
import '../../presentation_layer/features/car_sell/screens/listed_cars_screen.dart';
import '../../presentation_layer/features/spare_parts/screens/spare_parts_categories_screen/spare_parts_categories_screen.dart';
import 'main_app_states.dart';

class MainAppCubit extends Cubit<MainAppStates> {
  MainAppCubit() : super(IntStateCar());

  static MainAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const MyCarScreen(),
    const SparePartsCategoriesScreen(),
    const ListedCarsForSaleScreen(),
    const SettingsScreen(),
  ];
  var db = FirebaseFirestore.instance;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  late List categoriesGrid;

  Future<void> sparePartsCategoriesGridJsonGenerate() async {
    final String response =
        await rootBundle.loadString('assets/part_categories_grid.json');
    final data = await json.decode(response);
    categoriesGrid = data['items'];
  }

  UserModel? userData;

  Future<UserModel?> getUserData() async {
    if (myUid != null) {
      await db.collection('verifiedUsers').doc(myUid).get().then((value) {
        userData = UserModel.fromJson(value.data()!);
        emit(GetUserDataSuccessState(userData!));
      }).catchError((error) {
        emit(GetUserDataErrorState());
      });
    }
    return userData ;
  }

  Future<void> updateUserData({
    required String firstName,
    required String lastName,
    required String phone,
    required BuildContext context,
  }) async {
    emit(UpdateUserDataLoadingState());
    await db.collection('verifiedUsers').doc(myUid).update({
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    }).then((value) {
      getUserData();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('تم تحديث البيانات بنجاح'),
        backgroundColor: Colors.green,
      ));
    }).catchError((error) {
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
    required bool isFirstTime,
    String? email,
  }) async {
    emit(UpdateUserPasswordLoadingState());
    AuthCredential credential = EmailAuthProvider.credential(
      email: email ?? userData!.email!,
      password: currentPassword,
    );
    // ReAuthenticate with old password
    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(credential)
        .then((value) {
          db.collection('verifiedUsers').doc(value.user!.uid).update({
            'password' : newPassword,
          });
      // updatePassword
      FirebaseAuth.instance.currentUser
          ?.updatePassword(newPassword)
          .then((value) {
        emit(UpdateUserDataSuccessState());
        Navigator.pop(context);
        CacheHelper.putString(key: 'password', value: newPassword);
        if(!isFirstTime){
          showDialog(context: context, builder: (context)=>const MyAlertDialog(
            isFailed: false,
            actions: [],
            title: 'تم تغيير كلمه السر بنجاح',
          ));
        }
      }).catchError((error) {
        if(!isFirstTime){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ));
        }
        emit(UpdateUserDataErrorState());
      });
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('كلمه السر الحالية خاطئة'),
        backgroundColor: Colors.red,
      ));
    });
  }

  Future<void> sendComplaint({
    required String complaint,
  }) async {
    emit(SendComplaintLoadingState());
    await db.collection('complaints').add({
      'complaint': complaint,
      'addedTime': FieldValue.serverTimestamp(),
      'userName': '${userData!.firstName}' ' ${userData!.lastName}',
      'uId': myUid
    }).then((value) {
      db.collection('complaints').doc(value.id).update({
        'docId' : value.id,
      });
      DioHelper.pushNotification(data: {
        'to': '/topics/admin',
        'notification': {
          "title": " شكوي من ${userData!.firstName} ${userData!.lastName}",
          "body": complaint,
          "sound": "default",
        },
        'data' : {
          "complaint": 'complaint',
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        },
      });
      emit(SendComplaintSuccessState());
    }).catchError((error) {
      emit(SendComplaintErrorState());
    });
  }
  Future<void> isChassisNoAccepted(String chassisNo) async {
    bool isChassisNoExist = false;
    await db
        .collection('verifiedUsers')
        .where('chassisNo', isEqualTo: chassisNo)
        .get()
        .then((value) {
       isChassisNoExist = value.docs.isNotEmpty ;
    });
    emit(ChassisNoCheckState(isChassisNoExist));
  }
}
