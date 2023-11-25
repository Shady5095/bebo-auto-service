import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constans.dart';

void navigateToAnimated(
        {context, widget, animation = PageTransitionType.leftToRight}) =>
    Navigator.push(
      context,
      PageTransition(
          type: animation,
          child: widget,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 250)),
    );

void navigateTo({
  context,
  widget,
}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(
        {required context,
        required widget,
        animation = PageTransitionType.leftToRight}) =>
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: animation,
            child: widget,
            duration: const Duration(milliseconds: 200)),
        );

Widget defaultButton({
  double width = double.infinity,
  Color? background,
  double? height,
  required Function() onTap,
  String? text,
  Widget? child,
  bool isUppercase = true,
  BoxDecoration? decoration,
  Color textColor = Colors.white,
  FontWeight fontWeight = FontWeight.normal,
  double? fontSize,
}) =>
    Container(
      width: width,
      height: height ?? 40.h,
      color: background,
      decoration: decoration ??
          BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: defaultColor),
      child: MaterialButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        splashColor: Colors.transparent,
        child: child ??
            Text(
              isUppercase ? text!.toUpperCase() : text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize ?? 14.sp,
              ),
            ),
      ),
    );

PreferredSizeWidget defaultAppbar({
  required BuildContext context,
  String? title = '',
  List<Widget>? actions,
  List<Widget>? tabs,
  Function()? onPopMethod,
}) =>
    AppBar(
      toolbarHeight: 45.h,
      title: Text(
        title!,
        style: TextStyle(
          fontSize: 18.sp,
        ),
      ),
      actions: actions,
      leading: IconButton(
        onPressed: onPopMethod ??
            () {
              Navigator.pop(context);
            },
        icon: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).secondaryHeaderColor,
            size: 19.sp,
          ),
        ),
      ),
      titleSpacing: 12.w,
      bottom: tabs == null
          ? null
          : TabBar(
              tabs: tabs,
            ),
    );

Widget myCircularProgressIndicator({double? size}) =>
    LoadingAnimationWidget.threeRotatingDots(
      color: defaultColor,
      size: size ?? 35.sp,
    );

void unFocusKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

extension ReformatString on String {
  String removeSpaceAndToLowercase() {
    return replaceAll(RegExp(r"\s+\b|\b\s"), "").toLowerCase();
  }

  String addCommaToString() {
    String priceInText = "";
    int counter = 0;
    for (int i = (length - 1); i >= 0; i--) {
      counter++;
      String str = this[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ",$str$priceInText";
      }
    }
    return priceInText.trim();
  }
}

extension ReformatInt on int {
  String addCommaToInt() {
    var numFormat = NumberFormat.decimalPattern('en_us');
    return numFormat.format(this);
  }
}

void imagePickDialog({
  required BuildContext context,
  Function()? galleryOnTap,
  Function()? cameraOnTap,
}) =>
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 150.h,
            width: 230.w,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(32).r),
            child: SizedBox.expand(
              child: Material(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16).r,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: galleryOnTap,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.green,
                                size: 40.sp,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                'المعرض',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: cameraOnTap,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.blue,
                                size: 40.sp,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                'الكاميرا',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );

Future<DateTime> getServerTimeNow() async {
  late DateTime dateTime;
  await FirebaseFirestore.instance.collection('timeNow').doc('time').set(
    {'timeStamp': FieldValue.serverTimestamp()},
  );
  await FirebaseFirestore.instance
      .collection('timeNow')
      .doc('time')
      .get()
      .then((value) {
    final Timestamp timestamp = value.data()!['timeStamp'] as Timestamp;
    dateTime = timestamp.toDate();
  });
  FirebaseFirestore.instance.collection('timeNow').doc('time').delete();
  return dateTime;
}

void callDial(String phoneNumber) async {
  Uri uri = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(uri);
}

void openWhatsapp({
  required String phoneNumber,
  required String text,
}) async {
  var contact = phoneNumber;
  var androidUrl = "whatsapp://send?phone=$contact&text=$text";
  var iosUrl = "https://wa.me/$contact?text=${Uri.parse(text)}";

  try {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(iosUrl));
    } else {
      await launchUrl(Uri.parse(androidUrl));
    }
  } on Exception {
    null;
  }
}

Future<void> openFacebook() async {
  String fbProtocolUrl;
  if (Platform.isIOS) {
    fbProtocolUrl = 'fb://profile/1644608649141872';
  } else {
    fbProtocolUrl = 'fb://page/1644608649141872';
  }

  String fallbackUrl = 'https://www.facebook.com/BeBo.Auto.Service2';
  Uri fbBundleUri = Uri.parse(fbProtocolUrl);
  var canLaunchNatively = await canLaunchUrl(fbBundleUri);

  if (canLaunchNatively) {
    launchUrl(fbBundleUri);
  } else {
    await launchUrl(Uri.parse(fallbackUrl),
        mode: LaunchMode.externalApplication);
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String url) async {
    String googleUrl = url;
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}

void printWithColor(String? text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}



