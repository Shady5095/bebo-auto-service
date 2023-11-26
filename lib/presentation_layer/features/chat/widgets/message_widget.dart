import 'package:bebo_auto_service/components/constans.dart';
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
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.70,
                            //minWidth: MediaQuery.of(context).size.width * 0.25
                          ),
                          padding: messageModel.image != null
                              ? EdgeInsets.only(
                                  bottom: 0,
                                  right: haveNip && !isUserMessage ? 8.w : 3.w,
                                  left: isUserMessage && haveNip ? 8.w : 4.w,
                                  top: 4)
                              : EdgeInsets.symmetric(
                                  vertical: 3.h, horizontal: 9.w),
                          decoration: BoxDecoration(
                              color: isUserMessage
                                  ? Colors.grey[800]
                                  : const Color.fromRGBO(166, 30, 30, 1.0),
                              borderRadius:
                                  haveNip ? null : BorderRadius.circular(11).r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (messageModel.image != null)
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: messageModel.text != '' ? 5 : 0),
                                  child: SizedBox(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12).r,
                                      child: Image(
                                        errorBuilder: (BuildContext? context,
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
                                        loadingBuilder: (BuildContext? context,
                                            Widget? child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child!;
                                          }
                                          return Center(
                                            child: SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: CircularProgressIndicator(
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
                                        image: CachedNetworkImageProvider(
                                            '${messageModel.image}'),
                                      ),
                                    ),
                                  ),
                                ),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth:
                                        MediaQuery.of(context).size.width *
                                            0.17),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                              bottom: messageModel.image !=
                                                          null &&
                                                      messageModel.text == ''
                                                  ? 0
                                                  : 13.0)
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
                                      bottom:
                                          messageModel.image != null ? 0 : -5,
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
                                            date.DateFormat('jm', 'ar').format(
                                                (messageModel.dateTime ??
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
