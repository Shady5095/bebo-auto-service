import 'dart:io';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../data_layer/network/dio_helper.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatIntState());

  static ChatCubit get(context) => BlocProvider.of(context);

  var db = FirebaseFirestore.instance;

  var storage = FirebaseStorage.instance;
  var picker = ImagePicker();

  Future<void> sendMessage({
    String? text,
    required UserModel userData,
  }) async {
    if (newMessageImagePhoto != null) {
      await sendPhotoMessage(userData: userData, text: text);
    } else {
      await sendTextMessage(userData: userData, text: text);
    }

    ///user information set
    await updateUserInformationFirstTime(userData: userData);

    getLastMessage();
  }

  Future<void> updateUserInformationFirstTime({
    required UserModel userData,
  }) async {
    await db.collection('chats').doc(myUid).get().then((value) {
      if (!value.exists) {
        db.collection('chats').doc(myUid).set({
          'name':
              '${userData.firstName} ${userData.lastName}',
          'carModel': '${userData.carModel}',
          'carYear': '${userData.year}',
          'uId': userData.uId,
        });
      }
    });
  }

  Future<void> sendTextMessage({
    required String? text,
    required UserModel userData,
  }) async {
    await db.collection('chats').doc(myUid).collection('messages').add({
      'receiverId': 'admin',
      'senderId': myUid,
      'text': text,
      'dateTime': FieldValue.serverTimestamp(),
      'isSeen': false,
    }).then((messageId) async {
      await db
          .collection('chats')
          .doc(myUid)
          .collection('messages')
          .doc(messageId.id)
          .update({
        'messageId': messageId.id,
      });
    });
    DioHelper.pushNotification(data: {
      'to': '/topics/admin',
      'notification': {
        "title": "${userData.firstName} ${userData.lastName} (${userData.carModel} ${userData.year})",
        "body": text,
        "sound": "default",
      },
      'data' : {
        "newMessage": userData.uId,
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      },
    });
  }

  Future<void> sendPhotoMessage({
    required String? text,
    required UserModel userData,
  }) async {
    emit(SendMessageLoadingState());
    String? imageUrl;
    if (newMessageImagePhoto != null) {
      imageUrl = await uploadNewMessagePhotoAndAddPath();
    }
    await db.collection('chats').doc(myUid).collection('messages').add({
      'receiverId': 'admin',
      'senderId': myUid,
      'text': text,
      'image': imageUrl,
      'dateTime': FieldValue.serverTimestamp(),
      'isSeen': false,
    }).then((messageId) async {
      await db
          .collection('chats')
          .doc(myUid)
          .collection('messages')
          .doc(messageId.id)
          .update({
        'messageId': messageId.id,
      });
      db
          .collection('chats')
          .doc(myUid)
          .collection('messages')
          .doc(messageId.id)
          .update({
        'imagePath': imagePath,
      });
      newMessageImagePhoto = null;
      imagePath = null;
    });
    DioHelper.pushNotification(data: {
      'to': '/topics/admin',
      'notification': {
        "title": "${userData.firstName} ${userData.lastName} (${userData.carModel} ${userData.year})",
        "body": 'صوره',
        "sound": "default",
      },
      'data' : {
        "newMessage": userData.uId,
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      },
    });
    emit(SendMessageSuccessState());
  }

  File? newMessageImagePhoto;

  Future<void> pickNewMessageImagePhoto({
    bool openCamera = false,
  }) async {
    XFile? pickedFile = await picker.pickImage(
      source: openCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedFile != null) {
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressQuality: 100,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: 'تعديل الصوره',
            backgroundColor: Colors.black,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'تعديل الصوره', aspectRatioLockEnabled: false)
        ],
      );
      if (croppedFile != null) {
        newMessageImagePhoto = File(croppedFile.path);
        emit(MessageImagePickedSuccessState());
      }
    }
  }

  void removeMessagePhoto() {
    newMessageImagePhoto = null;
    emit(RemoveMessagePhoto());
  }

  String? imagePath;

  Future<String?> uploadNewMessagePhotoAndAddPath() async {
    String? newOfferPhotoUrl;
    await storage
        .ref()
        .child(
            'messagesImages/$myUid/${Uri.file((newMessageImagePhoto?.path)!).pathSegments.last}')
        .putFile(newMessageImagePhoto!)
        .then((value) async {
      imagePath = value.ref.name;
      await value.ref.getDownloadURL().then((value) {
        newOfferPhotoUrl = value;
      }).catchError((error) {});
    }).catchError((error) {});
    return newOfferPhotoUrl;
  }

  Future<void> getLastMessage() async {
    String? text;
    dynamic dateTime;
    bool? isSeen;

    ///get last message
    await db
        .collection('chats')
        .doc(myUid)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .limit(1)
        .get()
        .then((value) {
      text = value.docs.isNotEmpty
          ? ((value.docs[0].data()['text']) != ''
              ? (value.docs[0].data()['text'])
              : 'Photo')
          : null;
      dateTime = value.docs.isNotEmpty
          ? value.docs[0].data()['dateTime'] ?? Timestamp.now()
          : null;
      isSeen = value.docs.isNotEmpty ? value.docs[0].data()['isSeen'] : false;
    });
    try {
      db.collection('chats').doc(myUid).update({
        'lastMessage':'$text',
        'lastMessageDatetime': dateTime,
        'isSeen': isSeen
      });
    } on FirebaseException catch (e) {
      if (e.message == 'Some requested document was not found.') {
        db.collection('chats').doc(myUid).set({
          'lastMessage': '$text',
          'lastMessageDatetime': dateTime,
          'isSeen': isSeen
        });
      }
    }
  }

  Future<void> messageSeen({
    required String messageId,
  }) async {
    try {
      await db
          .collection('chats')
          .doc(myUid)
          .collection('messages')
          .doc(messageId)
          .update({
        'isSeen': true,
      });

      await db.collection('chats').doc(myUid).update({
        'isSeen': true,
      });
    } on FirebaseException {
      await db
          .collection('chats')
          .doc(myUid)
          .collection('messages')
          .doc(messageId)
          .set({
        'isSeen': true,
      });

      await db.collection('chats').doc(myUid).set({
        'isSeen': true,
      });
    }
  }
}
