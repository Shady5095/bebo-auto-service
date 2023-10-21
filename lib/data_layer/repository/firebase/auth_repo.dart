import 'package:bebo_auto_service/data_layer/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseAuthRepo {


  var db = FirebaseFirestore.instance ;
  var storage = FirebaseStorage.instance;



  Future<void> sendUnverifiedUserData({
  required String firstName,
  required String lastName,
  required String email ,
  required String password ,
  required String phone,
  required String carModel ,
  required String year,
  required String color,
  required String plate,
  required String transmission,
  required String bodyType,
  required String km,
  required String chassisNo,
  required String engineNo,
}) async {
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
    await FirebaseFirestore.instance.collection('unverifiedUsers').doc(chassisNo).set(
      userModel.toMap()
    );
  }
}