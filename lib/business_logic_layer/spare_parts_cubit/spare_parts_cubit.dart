import 'dart:convert';
import 'dart:io';

import 'package:bebo_auto_service/business_logic_layer/spare_parts_cubit/spare_parts_states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SparePartsCubit extends Cubit<SparePartsStates> {
  SparePartsCubit() : super(IntStateCar());

  static SparePartsCubit get(context) => BlocProvider.of(context);

  FirebaseFirestore db = FirebaseFirestore.instance;
  var storage = FirebaseStorage.instance;
  var picker = ImagePicker();


}
