import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/data_layer/models/offers_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as date_time_intl;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../components/constans.dart';

class OfferDetailsScreen extends StatefulWidget {
  final OffersModel offersModel;

  const OfferDetailsScreen({Key? key, required this.offersModel})
      : super(key: key);

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'تفاصيل العرض',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: widget.offersModel.image != null
                    ? Hero(
                        tag: '${widget.offersModel.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            errorBuilder: (BuildContext? context,
                                Object? exception, StackTrace? stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.warning_amber,
                                  color: Colors.red,
                                  size: 100,
                                ),
                              );
                            },
                            loadingBuilder: (BuildContext? context,
                                Widget? child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child!;
                              return Center(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    color: defaultColor,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            image: CachedNetworkImageProvider(
                              '${widget.offersModel.image}',
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: displayHeight(context) * 0.35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          //border: Border.all(color: Colors.white54),
                        ),
                        child: const Icon(
                          FluentIcons.image_off_24_regular,
                          color: Colors.white54,
                          size: 50,
                        ),
                      ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                '${widget.offersModel.name}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              if (widget.offersModel.description != null)
                Text(
                  '${widget.offersModel.description}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 16.sp,
                  ),
                ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    ' حالة العرض :     ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14.sp,
                    ),
                  ),
                  FutureBuilder<Widget>(
                      future: offerStatusTextWidget(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Icon(
                              Icons.warning_amber,
                              color: Colors.red,
                              size: 10,
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                              child: LoadingAnimationWidget.prograssiveDots(
                            color: defaultColor,
                            size: 20,
                          ));
                        }
                        if (snapshot.data == null) {
                          return Center(
                              child: LoadingAnimationWidget.waveDots(
                            color: defaultColor,
                            size: 30,
                          ));
                        }
                        return snapshot.data!;
                      }),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    ' تاريخ اضافة العرض :     ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    '${date_time_intl.DateFormat.yMMMd('ar').format((widget.offersModel.addedTime?.toDate())!)}  :  ${date_time_intl.DateFormat.jm('ar').format(widget.offersModel.addedTime!.toDate())}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    ' تاريخ انتهاء العرض :     ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    widget.offersModel.expireDate == null
                        ? 'غير محدد'
                        : '${date_time_intl.DateFormat.yMMMd('ar').format((widget.offersModel.expireDate?.toDate())!)}  :  ${date_time_intl.DateFormat.jm('ar').format(widget.offersModel.expireDate!.toDate())}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> showDateTimePicker() async {
    DateTime? dateTime;
    await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: defaultColor, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.white, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: defaultColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.parse('2035-05-31'),
      context: context,
    ).then((dateValue) async {
      if (dateValue != null) {
        DateTime? date = dateValue;
        await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((timeValue) {
          if (timeValue != null) {
            TimeOfDay? time = timeValue;
            dateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
          } else {
            return null;
          }
        });
      } else {
        return null;
      }
    });
    return dateTime;
  }

  Future<Widget> offerStatusTextWidget() async {
    DateTime currentDate = await getServerTimeNow();
    if (widget.offersModel.expireDate == null ||
        currentDate.isBefore(widget.offersModel.expireDate!.toDate())) {
      return Text(
        'متاح',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green,
          fontStyle: FontStyle.italic,
          fontSize: 14.sp,
        ),
      );
    } else {
      return Text(
        'أنتهي صلاحيته',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontStyle: FontStyle.italic,
          fontSize: 14.sp,
        ),
      );
    }
  }
}
