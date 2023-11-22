import 'dart:io';
import 'package:bebo_auto_service/business_logic_layer/main_app_cubit/main_app_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as date;
import 'dart:math' as math;
import '../../../business_logic_layer/chat_cubit/chat_cubit.dart';
import '../../../business_logic_layer/chat_cubit/chat_states.dart';
import '../../../components/components.dart';
import '../../../components/constans.dart';
import '../../../data_layer/models/message_model.dart';
import '../../widgets/message_widget.dart';

class ChatsDetailsScreen extends StatefulWidget {
  final String? fromSpareParts ;
  const ChatsDetailsScreen({super.key, this.fromSpareParts});

  @override
  State<ChatsDetailsScreen> createState() => _ChatsDetailsScreenState();
}

class _ChatsDetailsScreenState extends State<ChatsDetailsScreen> {
  late TextEditingController chatController = TextEditingController(text: widget.fromSpareParts??'');
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ChatCubit>(context),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var chatCubit = ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 60.h,
              leadingWidth: double.infinity,
              titleSpacing: 12.w,
              leading: Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 15).w,
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).secondaryHeaderColor,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.15,
                    height: displayHeight(context) * 0.10,
                    child: Image(
                      width: displayWidth(context) * 0.15,
                      height: displayHeight(context) * 0.10,
                      image: const AssetImage('assets/images/logo.png'),
                    ),
                  ),
                   SizedBox(
                    width: 8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'الدعم الفني',
                        style: TextStyle(
                          fontSize: 17.sp,
                          height: 1,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'مركز بيبو اوتو في خدمتكم',
                        style: TextStyle(
                            height: 1,
                            fontSize: 14.sp,
                            color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(myUid)
                        .collection('messages')
                        .orderBy('dateTime', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Icon(
                            Icons.warning_amber,
                            color: Colors.red,
                            size: 90.sp,
                          ),
                        );
                      }
                      if (!snapshot.hasData) {
                        return Center(child: myCircularProgressIndicator());
                      }
                      if ((snapshot.data?.docs.isEmpty)!) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.chat_bubble_2,
                                size: 120.sp,
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'لا يوجد رسائل',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemBuilder: (context, index) {
                          //int reverseIndex = (snapshot.data?.docs.length)! -1- index ;
                          DateTime myDateTime =
                              (snapshot.data?.docs[index].data()['dateTime'] ??
                                      Timestamp.now())
                                  .toDate();
                          MessageModel messageModel = MessageModel.fromJson(
                              (snapshot.data?.docs[index].data())!);
                          final haveNip =
                              (index == snapshot.data!.docs.length - 1) ||
                                  (index == 0 &&
                                      messageModel.senderId !=
                                          snapshot.data!.docs[index + 1]
                                              .data()['senderId']) ||
                                  (messageModel.senderId !=
                                          snapshot.data!.docs[index + 1]
                                              .data()['senderId'] &&
                                      messageModel.senderId ==
                                          snapshot.data!.docs[index - 1]
                                              .data()['senderId']) ||
                                  (messageModel.senderId !=
                                          snapshot.data!.docs[index + 1]
                                              .data()['senderId'] &&
                                      messageModel.senderId !=
                                          snapshot.data!.docs[index - 1]
                                              .data()['senderId']);

                          final isShowDateCard = (index ==
                                  snapshot.data!.docs.length - 1) ||
                              ((index == 0) &&
                                  myDateTime.day >
                                      (snapshot.data?.docs[index + 1]
                                              .data()['dateTime']??Timestamp.now() as Timestamp)
                                          .toDate()
                                          .day) ||
                              (myDateTime.day >
                                      (snapshot.data?.docs[index + 1]
                                              .data()['dateTime']??Timestamp.now() as Timestamp)
                                          .toDate()
                                          .day &&
                                  myDateTime.day <=
                                      (snapshot.data?.docs[index - 1]
                                                  .data()['dateTime'] ??
                                              Timestamp.now())
                                          .toDate()
                                          .day);
                          String dateCardText() {
                            if (myDateTime.year ==
                                    Timestamp.now().toDate().year &&
                                myDateTime.month ==
                                    Timestamp.now().toDate().month &&
                                myDateTime.day ==
                                    Timestamp.now().toDate().day) {
                              return 'اليوم';
                            }
                            if (myDateTime.year ==
                                    Timestamp.now().toDate().year &&
                                myDateTime.month ==
                                    Timestamp.now().toDate().month &&
                                myDateTime.day ==
                                    Timestamp.now().toDate().day - 1) {
                              return 'أمس';
                            }
                            return date.DateFormat('yMMMMd', 'ar')
                                .format(myDateTime);
                          }

                          if (!messageModel.isSeen! &&
                              messageModel.receiverId == myUid && messageModel.messageId != null) {
                            chatCubit.messageSeen(
                                messageId: messageModel.messageId!);
                          }
                          return Column(
                            children: [
                              if (isShowDateCard)
                                Padding(
                                  padding:  EdgeInsets.only(
                                      bottom: 7.0.h, top: 2.0.h),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 7).w,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(10).r,
                                    ),
                                    child: Text(
                                      dateCardText(),
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                    ),
                                  ),
                                ),
                              if (snapshot.data?.docs[index]
                                      .data()['senderId'] ==
                                  myUid)
                                MessageWidget(
                                  context: context,
                                  messageModel: messageModel,
                                  isUserMessage: false,
                                  haveNip: haveNip,
                                  index: index,
                                ),
                              if (snapshot.data?.docs[index]
                                      .data()['senderId'] !=
                                  myUid)
                                MessageWidget(
                                  context: context,
                                  messageModel: messageModel,
                                  isUserMessage: true,
                                  haveNip: haveNip,
                                  index: index,
                                ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                        itemCount: (snapshot.data?.docs.length)!,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      if (chatCubit.newMessageImagePhoto != null)
                        SizedBox(
                            height: 130.h,
                            child: selectedPhoto(
                              messagePhoto: chatCubit.newMessageImagePhoto,
                              state: state,
                              cubit: ChatCubit.get(context),
                            )),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: chatController,
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.rtl,
                              autocorrect: false,
                              autofocus: widget.fromSpareParts != null ? true : false,
                              maxLines: 4,
                              minLines: 1,
                              style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 14.sp,
                                  //height: 1.15.h,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(9),
                                isDense: true,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey[800]!,
                                    ),
                                    borderRadius: BorderRadius.circular(16).r),
                                fillColor: Colors.grey[800],
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16).r,
                                    borderSide: BorderSide(
                                      color: Colors.grey[800]!,
                                    )),
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 13.sp,
                                  height: 0.8,
                                ),
                                hintText: 'أرسال رساله',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16).r,
                                ),
                              ),
                            ),
                          ),
                          Transform(
                            alignment: AlignmentDirectional.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: GestureDetector(
                              onTap: () {
                                imagePickDialog(
                                  context: context,
                                  galleryOnTap: () {
                                    Navigator.pop(context);
                                    ChatCubit.get(context)
                                        .pickNewMessageImagePhoto(
                                            openCamera: false);
                                  },
                                  cameraOnTap: () {
                                    Navigator.pop(context);
                                    ChatCubit.get(context)
                                        .pickNewMessageImagePhoto(
                                            openCamera: true);
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  FluentIcons.image_24_regular,
                                  color: Colors.green,
                                  size: 28.sp,
                                ),
                              ),
                            ),
                          ),
                          Transform(
                            alignment: AlignmentDirectional.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: GestureDetector(
                              onTap: () {
                                if (chatController.text.isNotEmpty ||
                                    (chatCubit.newMessageImagePhoto != null)) {
                                  chatCubit.sendMessage(
                                    text: chatController.text,
                                    userData:
                                        MainAppCubit.get(context).userData!,
                                  );
                                  chatController.clear();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  FluentIcons.send_20_regular,
                                  color: defaultColor,
                                  size: 28.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget selectedPhoto(
          {File? messagePhoto,
          required ChatCubit cubit,
          required ChatStates state}) =>
      Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
              width: 160,
              height: 160,
              child: Image(
                image: FileImage(File((messagePhoto?.path)!)),
                fit: BoxFit.cover,
              )),
          if (state is! SendMessageLoadingState)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  cubit.removeMessagePhoto();
                },
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                ),
              ),
            ),
          if (state is SendMessageLoadingState)
            Center(child: myCircularProgressIndicator(size: 25.sp)),
        ],
      );
}
