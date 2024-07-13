import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:bebo_auto_service/business_logic_layer/main_app_cubit/main_app_cubit.dart';
import 'package:bebo_auto_service/data_layer/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart' as date;
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;
import '../../../../business_logic_layer/chat_cubit/chat_cubit.dart';
import '../../../../business_logic_layer/chat_cubit/chat_states.dart';
import '../../../../components/components.dart';
import '../../../../components/constans.dart';
import '../../../../data_layer/models/message_model.dart';
import '../widgets/message_widget.dart';

class ChatsDetailsScreen extends StatefulWidget {
  final String? fromSpareParts;

  const ChatsDetailsScreen({super.key, this.fromSpareParts});

  @override
  State<ChatsDetailsScreen> createState() => _ChatsDetailsScreenState();
}

class _ChatsDetailsScreenState extends State<ChatsDetailsScreen>{
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
              backgroundColor: defaultBackgroundColor,
              titleSpacing: 12.w,
              leading: Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 15)
                        .w,
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
                        .doc(myUid ?? CacheHelper.getString(key: 'chassisNo'))
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

                          final isShowDateCard = ((index == snapshot.data!.docs.length - 1) ||
                              ((index == 0) &&
                                  myDateTime.day >
                                      (snapshot.data?.docs[index + 1].data()['dateTime'] ?? Timestamp.now() as Timestamp)
                                          .toDate()
                                          .day) ||
                              (myDateTime.day > (snapshot.data?.docs[index + 1].data()['dateTime'] ?? Timestamp.now() as Timestamp).toDate().day &&
                                  myDateTime.day <=
                                      (snapshot.data?.docs[index - 1].data()['dateTime'] ?? Timestamp.now())
                                          .toDate()
                                          .day) ||
                              (index == snapshot.data!.docs.length - 1) ||
                              ((index == 0) &&
                                  myDateTime.month >
                                      (snapshot.data?.docs[index + 1].data()['dateTime'] ?? Timestamp.now())
                                          .toDate()
                                          .month) ||
                              (myDateTime.month > (snapshot.data?.docs[index + 1].data()['dateTime'] ?? Timestamp.now()).toDate().month &&
                                  myDateTime.month <=
                                      (snapshot.data?.docs[index - 1].data()['dateTime'] ?? Timestamp.now())
                                          .toDate()
                                          .month) ||
                              (index == snapshot.data!.docs.length - 1) ||
                              ((index == 0) &&
                                  myDateTime.year >
                                      (snapshot.data?.docs[index + 1].data()['dateTime'] ?? Timestamp.now())
                                          .toDate()
                                          .year) ||
                              (myDateTime.year > (snapshot.data?.docs[index + 1].data()['dateTime'] ?? Timestamp.now()).toDate().year &&
                                  myDateTime.year <= (snapshot.data?.docs[index - 1].data()['dateTime'] ?? Timestamp.now()).toDate().year));
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
                              messageModel.receiverId ==
                                  (myUid ??
                                      CacheHelper.getString(
                                          key: 'chassisNo')) &&
                              messageModel.messageId != null) {
                            chatCubit.messageSeen(
                                messageId: messageModel.messageId!);
                          }
                          return Column(
                            children: [
                              if (isShowDateCard)
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 7.0.h, top: 2.0.h),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 7)
                                        .w,
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
                                  (myUid ??
                                      CacheHelper.getString(key: 'chassisNo')))
                                MessageWidget(
                                  context: context,
                                  messageModel: messageModel,
                                  isUserMessage: false,
                                  haveNip: haveNip,
                                  index: index,
                                ),
                              if (snapshot.data?.docs[index]
                                      .data()['senderId'] !=
                                  (myUid ??
                                      CacheHelper.getString(key: 'chassisNo')))
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
                const TextAndButtonsWidget()
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


class TextAndButtonsWidget extends StatefulWidget {

  const TextAndButtonsWidget({super.key});

  @override
  State<TextAndButtonsWidget> createState() => _TextAndButtonsWidgetState();
}

class _TextAndButtonsWidgetState extends State<TextAndButtonsWidget>
    with TickerProviderStateMixin {
  var chatController = TextEditingController();
  bool isRecording = false;
  bool isPermissionGranted = false;

  late AnimationController recordIconFadeAnimationController;
  bool isReadyToCancelRecord = false;

  bool isCancelRecord = false;

  late Offset recordCancelArrowOffset = const Offset(0, 0);

  //final recorder = FlutterSoundRecorder();
  final player = AudioPlayer();

  Duration recordDuration = Duration.zero;

  @override
  void initState() {
    recordIconFadeAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    recordIconFadeAnimationController.repeat(reverse: true);
    //initRecorder();
    super.initState();
  }

  /*Future initRecorder() async {
    final status = await Permission.microphone.isGranted;
    if (status) {
      isPermissionGranted = true;
      await recorder.openRecorder();
      recorder.setSubscriptionDuration(const Duration(seconds: 1));
    } else {
      isPermissionGranted = false;
    }
  }

  Future<void> microphonePermissionRequest() async {
    final status = await Permission.microphone.request();
    if (status == PermissionStatus.granted) {
      isPermissionGranted = true;
      await recorder.openRecorder();
      recorder.setSubscriptionDuration(const Duration(seconds: 1));
    } else {
      isPermissionGranted = false;
    }
  }*/

  @override
  void dispose() {
    recordIconFadeAnimationController.dispose();
    player.dispose();
    //recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final chatCubit = ChatCubit.get(context);
        final isTextOrImage = (chatController.text.isNotEmpty &&
            chatController.text.trim() != '') ||
            (chatCubit.newMessageImagePhoto != null);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              if (chatCubit.newMessageImagePhoto != null)
                SizedBox(
                    height: 130.h,
                    width: double.infinity,
                    child: selectedPhoto(
                      messagePhoto: chatCubit.newMessageImagePhoto,
                      state: state,
                      cubit: ChatCubit.get(context),
                    )),
              bottomRow(context, chatCubit, isTextOrImage),
            ],
          ),
        );
      },
    );
  }

  Widget bottomRow(
      BuildContext context, ChatCubit chatCubit, bool isTextOrImage) {
    final isKeyboardVisible = View.of(context).viewInsets.bottom > 0.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!isRecording)
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: chatController,
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                    onChanged: (value) {
                      setState(() {});
                    },
                    maxLines: 4,
                    minLines: 1,
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
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
                        fontSize:  13.sp,
                      ),
                      hintText: 'ارسال رساله',
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
                              .pickNewMessageImagePhoto(openCamera: false);
                        },
                        cameraOnTap: () {
                          Navigator.pop(context);
                          ChatCubit.get(context)
                              .pickNewMessageImagePhoto(openCamera: true);
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        FluentIcons.image_24_regular,
                        color: Colors.green,
                        size: 30.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (isRecording)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(16).r,
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(2),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                FadeTransition(
                                  opacity: recordIconFadeAnimationController,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      isTextOrImage
                                          ? FluentIcons.send_20_regular
                                          : Icons.mic,
                                      color: Colors.red,
                                      size:  24.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                /*StreamBuilder<RecordingDisposition>(
                                    stream: recorder.onProgress,
                                    builder: (context, snapshot) {
                                      final duration = snapshot.hasData
                                          ? snapshot.data!.duration
                                          : Duration.zero;
                                      String twoDigits(int n) =>
                                          n.toString().padLeft(2, '0');

                                      final twoDigitMinutes = twoDigits(
                                          duration.inMinutes.remainder(60));
                                      final twoDigitSeconds = twoDigits(
                                          duration.inSeconds.remainder(60));
                                      recordDuration = duration;
                                      return Text(
                                        '$twoDigitMinutes:$twoDigitSeconds',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp),
                                      );
                                    }),*/
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 5,
                            left: displayWidth(context) * 0.20,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  isCancelRecord ? Colors.red : Colors.grey,
                                  BlendMode.srcIn,
                                ),
                                child: Lottie.asset(
                                    'assets/images/deleteRecord.json',
                                    width: 10.w,
                                    height: 10.h,
                                    repeat: false,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Positioned(
                            left: recordCancelArrowOffset.dx,
                            top: 0,
                            bottom: 0,
                            child: Icon(
                              CupertinoIcons.arrow_right,
                              size: 22.sp,
                              color: isReadyToCancelRecord
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isKeyboardVisible)
                    const SizedBox(
                      height: 0,
                      width: 0,
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(color: Colors.transparent),
                        cursorColor: Colors.transparent,
                        showCursor: false,
                        autocorrect: false,
                        enableSuggestions: false,
                        maxLines: 1,
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    )
                ],
              ),
            ),
          ),
        Transform(
          alignment: AlignmentDirectional.center,
          transform: Matrix4.rotationY(math.pi),
          child: GestureDetector(
            onTap: () {
              onTabSendButton(chatCubit);
            },
            /*onLongPressMoveUpdate: (movement) async {
              readyToCancelRecord(movement, context);
            },
            onLongPressStart: (_) {
              startRecording();
              setState(() {});
            },
            onLongPressEnd: (_) {
              if (isPermissionGranted) {
                stopRecording();
              }
              setState(() {});
            },*/
            child: sendButton(true),
          ),
        ),
      ],
    );
  }

  void onTabSendButton(ChatCubit chatCubit) {
    if ((chatController.text.isNotEmpty && chatController.text.trim() != '') ||
        (chatCubit.newMessageImagePhoto != null)) {
      chatCubit.sendMessage(
          text: chatController.text.trim(),
        userData: MainAppCubit.get(context).userData! ,
          );
      chatController.clear();
    } /*else {
      myToast(msg: 'اضغط مطولا لبدء التسجيل', state: ToastStates.normal);
    }*/
  }

  Widget sendButton(bool isTextOrImage) {
   /* if (isRecording) {
      return Container(
        decoration: BoxDecoration(
            color: defaultColor, borderRadius: BorderRadius.circular(90)),
        padding: const EdgeInsets.all(10),
        child: Icon(
          isTextOrImage  ? FluentIcons.send_20_regular : Icons.mic,
          color: isRecording ? Colors.white : defaultColor,
          size: 40.sp,
        ),
      );
    }*/
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Icon(
        isTextOrImage ? FluentIcons.send_20_regular : Icons.mic,
        color: defaultColor,
        size: 30.sp,
      ),
    );
  }

  Widget selectedPhoto(
      {File? messagePhoto,
        required ChatCubit cubit,
        required ChatStates state}) =>
      Stack(
        //alignment: Alignment.topRight,
        children: [
          Center(
            child: Image(
              /*height: 150.h,
                 width: 150.w,*/
              image: FileImage(File((messagePhoto?.path)!)),
              fit: BoxFit.cover,
            ),
          ),
          if (state is! SendMessageLoadingState)
            Positioned(
              right: 110.w,
              child: Padding(
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
            ),
          if (state is SendMessageLoadingState)
            Center(child: myCircularProgressIndicator(size: 25.sp)),
        ],
      );

  /*void startRecording() {
    if (isPermissionGranted) {
      HapticFeedback.vibrate();
      player.play(AssetSource('audio/voice_note_start.mp3'));
      if(cachedPlayer != null){
        cachedPlayer!.stop();
      }
      if(pausedPlayer != null){
        pausedPlayer!.stop();
      }
      recordCancelArrowOffset = const Offset(0, 0);
      isReadyToCancelRecord = false;
      isCancelRecord = false;
      isRecording = true;
      player.setVolume(0.5);
      recorder.startRecorder(
        toFile: '${DateTime.now()}.aac', codec: Codec.aacMP4,);
    } else {
      microphonePermissionRequest();
    }
  }

  Future<void> stopRecording() async {
    if (!isCancelRecord) {
      isRecording = false;
      player.setVolume(0.5);
      player.play(AssetSource('audio/voice_note_end.mp3'));
      await recorder.stopRecorder().then((path) async {
        ChatCubit.get(context).voiceMessage = File(path!);
        await ChatCubit.get(context).sendMessage(
            userData: MainAppCubit.get(context).userData!,
            voiceMesssageDuration: recordDuration,
        );
        recordDuration = Duration.zero;
      });
    }
  }*/

  void readyToCancelRecord(
      LongPressMoveUpdateDetails movement, BuildContext context) {
    if (isRecording) {
      if (movement.offsetFromOrigin.dx > 30 &&
          movement.offsetFromOrigin.dx < displayWidth(context) * 0.19) {
        isReadyToCancelRecord = true;
        recordCancelArrowOffset = movement.offsetFromOrigin;
        if (movement.offsetFromOrigin.dx >=
            (displayWidth(context) * 0.16) - 10) {
          isCancelRecord = true;
          if (movement.offsetFromOrigin.dx >=
              (displayWidth(context) * 0.16) - 5) {
            cancelRecord();
          }
        }
        setState(() {});
      }
    }
  }

  void cancelRecord() {
    AudioPlayer().play(AssetSource('audio/voice_note_cancel.mp3'));
    isRecording = false;
    HapticFeedback.vibrate();
    //recorder.stopRecorder();
  }
}