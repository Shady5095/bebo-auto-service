import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/widgets/image_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as date;
import '../../../../data_layer/models/message_model.dart';

class MessageWidget extends StatelessWidget {
  final BuildContext context;
  final MessageModel messageModel;
  final bool isUserMessage;
  final bool haveNip;
  final int index;

  const MessageWidget({
    Key? key,
    required this.context,
    required this.messageModel,
    required this.isUserMessage,
    required this.haveNip,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: isUserMessage
                ? EdgeInsets.only(left: haveNip ? 7.0.w : 12.w, bottom: 2.h)
                : EdgeInsets.only(right: haveNip ? 7.0.w : 12.w, bottom: 2.h),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Align(
                  alignment: isUserMessage
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  child: FittedBox(
                    child: ClipPath(
                      clipper: haveNip
                          ? UpperNipMessageClipperTwo(
                              isUserMessage
                                  ? MessageType.receive
                                  : MessageType.send,
                              nipWidth: 5.w,
                              nipHeight: 9.h,
                              bubbleRadius: haveNip ? 11.r : 0,
                            )
                          : null,
                      child: Container(
                        color: Colors.transparent,
                        constraints: const BoxConstraints(
                          maxWidth: double.infinity,
                        ),
                        child: messageModel.voiceMessage != null
                            ? VoiceNoteMessage(
                                isUserMessage: isUserMessage,
                                messageModel: messageModel)
                            : Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.70,
                                  //minWidth: MediaQuery.of(context).size.width * 0.25
                                ),
                                padding: messageModel.image != null
                                    ? EdgeInsets.only(
                                        bottom: 0,
                                        right: haveNip && !isUserMessage
                                            ? 8.w
                                            : 3.w,
                                        left: isUserMessage && haveNip
                                            ? 8.w
                                            : 4.w,
                                        top: 4)
                                    : EdgeInsets.symmetric(
                                        vertical: 3.h, horizontal: 9.w),
                                decoration: BoxDecoration(
                                    color: isUserMessage
                                        ? Colors.grey[800]
                                        : const Color.fromRGBO(
                                            166, 30, 30, 1.0),
                                    borderRadius: haveNip
                                        ? null
                                        : BorderRadius.circular(11).r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (messageModel.image != null)
                                      InkWell(
                                        onTap: () {
                                          navigateTo(
                                            context: context,
                                            widget: ImageViewer(
                                              photo: CachedNetworkImageProvider(
                                                  '${messageModel.image}'),
                                              isNetworkImage: true,
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: messageModel.text != ''
                                                  ? 5
                                                  : 0),
                                          child: SizedBox(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12).r,
                                              child: Image(
                                                errorBuilder: (BuildContext?
                                                        context,
                                                    Object? exception,
                                                    StackTrace? stackTrace) {
                                                  return const Center(
                                                    child: Icon(
                                                      Icons.warning_amber,
                                                      color: Colors.red,
                                                      size: 50,
                                                    ),
                                                  );
                                                },
                                                loadingBuilder:
                                                    (BuildContext? context,
                                                        Widget? child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child!;
                                                  }
                                                  return Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              40.0),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: defaultColor,
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                image:
                                                    CachedNetworkImageProvider(
                                                        '${messageModel.image}'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      constraints: BoxConstraints(
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.17),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                    bottom: messageModel
                                                                    .image !=
                                                                null &&
                                                            messageModel.text ==
                                                                ''
                                                        ? 0
                                                        : 13.0)
                                                .h
                                                .h,
                                            child: Text(
                                              //textAlign: TextAlign.start,
                                              textDirection: TextDirection.rtl,
                                              isUserMessage
                                                  ? '${messageModel.text}'
                                                  : '${messageModel.text}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 1,
                                            child: Row(
                                              children: [
                                                if (!isUserMessage)
                                                  Icon(
                                                    messageModel.isSeen!
                                                        ? Icons.done_all
                                                        : Icons.done,
                                                    color: messageModel.isSeen!
                                                        ? Colors.blueAccent
                                                        : Colors.white54,
                                                    size: 15.sp,
                                                  ),
                                                Text(
                                                  date.DateFormat('jm', 'ar')
                                                      .format((messageModel
                                                                  .dateTime ??
                                                              Timestamp.now())
                                                          .toDate()),
                                                  style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                if (!isUserMessage)
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: const SizedBox())
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VoiceNoteMessage extends StatefulWidget {
  final bool isUserMessage;

  final MessageModel messageModel;

  const VoiceNoteMessage(
      {super.key, required this.isUserMessage, required this.messageModel});

  @override
  State<VoiceNoteMessage> createState() => _VoiceNoteMessageState();
}

class _VoiceNoteMessageState extends State<VoiceNoteMessage>
    with SingleTickerProviderStateMixin {
  List<int> heightRandomNumbers = [];
  double currentSliderPosition = 0;
  String recordDurationTextWhilePlaying = '0:00';
  final player = AudioPlayer();
  bool isPlaying = false;

  bool isPaused = false;

  bool isStopped = true;
  late AnimationController iconController;

  @override
  void initState() {
    iconController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    generateRandomNumber();
    onPlayerStateChanged();
    onPositionChanged();
    super.initState();
  }

  void onPlayerStateChanged() {
    player.onPlayerStateChanged.listen((event) {
      if (mounted) {
        setState(() {
          isPlaying = event == PlayerState.playing;
          if (isPlaying) {
            iconController.forward();
          }
          if (!isPlaying) {
            iconController.reverse();
          }
          isPaused = event == PlayerState.paused;
          isStopped = event == PlayerState.stopped;
          if (isStopped || event == PlayerState.completed) {
            currentSliderPosition = 0;
          }
        });
      }
    });
  }

  void onPositionChanged() {
    player.onPositionChanged.listen((event) {
      setState(() {
        int currentDurationInMicroSeconds = event.inMicroseconds;
        currentSliderPosition =
        (currentDurationInMicroSeconds / widget.messageModel.duration!);
        if (currentSliderPosition >= 1) {
          currentSliderPosition = currentSliderPosition.round().toDouble();
        }
        recordDurationTextWhilePlaying = formatAudioDuration(event);
      });
    });
  }

  void generateRandomNumber() {
    Random random = Random();
    for (var i = 0; i < 40; i++) {
      int randomNumber = random.nextInt(40) + 1;
      heightRandomNumbers.add(randomNumber);
    }
  }

  @override
  Future<void> dispose() async {
    iconController.dispose();
    super.dispose();
    await player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context) * 0.70,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
          color: widget.isUserMessage
              ? Colors.grey[800]
              : const Color.fromRGBO(166, 30, 30, 1.0),
          borderRadius: BorderRadius.circular(11).r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: InkWell(
              onTap: () async {
                if (isPlaying) {
                  player.pause();
                  cachedPlayer = null;
                  pausedPlayer = player;
                } else {
                  if (cachedPlayer != null) {
                    cachedPlayer!.stop();
                  }
                  await player
                      .play(UrlSource(widget.messageModel.voiceMessage!))
                      .catchError((error) {
                    myToast(msg: 'ملف تالف', state: ToastStates.normal);
                  });
                  cachedPlayer = player;
                }
              },
              child: CircleAvatar(
                radius: 22.r,
                backgroundColor: Colors.white,
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: iconController,
                  color: widget.isUserMessage ? Colors.grey[800] : const Color.fromRGBO(166, 30, 30, 1.0),
                  size: 33.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Stack(
                    children: [
                      FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: List.generate(35, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 2,
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                height: heightRandomNumbers[index].toDouble().h,
                                color: (currentSliderPosition * 35) - 1 >= index
                                    ? Colors.white
                                    : Colors.white30,
                              );
                            }),
                          ),
                        ),
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                            trackShape: CustomTrackShape(),
                            trackHeight: 40.h,
                            thumbShape: SliderComponentShape.noOverlay),
                        child: Slider(
                          value: currentSliderPosition,
                          onChanged: (value) {
                            currentSliderPosition = value;
                            player.seek(Duration(
                                microseconds:
                                (widget.messageModel.duration! * value)
                                    .toInt()));
                            setState(() {});
                          },
                          overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                          activeColor: Colors.transparent,
                          inactiveColor: Colors.transparent,
                          thumbColor: Colors.transparent,
                          secondaryActiveColor: Colors.transparent,
                          //divisions: 30,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    if (!widget.isUserMessage)
                      Icon(
                        widget.messageModel.isSeen!
                            ? Icons.done_all
                            : Icons.done,
                        color: widget.messageModel.isSeen!
                            ? Colors.blueAccent
                            : Colors.white54,
                        size: 15.sp,
                      ),
                    Text(
                      date.DateFormat('jm', 'ar').format(
                          (widget.messageModel.dateTime ?? Timestamp.now())
                              .toDate()),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      isPlaying || isPaused
                          ? recordDurationTextWhilePlaying
                          : formatAudioDuration(Duration(
                          microseconds: widget.messageModel.duration!)),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
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
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
