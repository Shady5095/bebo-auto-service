import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constans.dart';


void navigateToAnimated({context , widget , animation=PageTransitionType.leftToRight}) => Navigator.push(context, PageTransition(
  type: animation,
  child: widget,
  curve: Curves.fastOutSlowIn,
  duration: const Duration(
    milliseconds: 250
  )
),
);

void navigateTo({context , widget ,}) => Navigator.push(context, MaterialPageRoute(builder: (context) => widget)
);

void navigateAndFinish({required context ,required widget,animation=PageTransitionType.leftToRight}) => Navigator.pushAndRemoveUntil(context,
     PageTransition(
  type: animation,
  child: widget,
  duration: const Duration(milliseconds: 500)
),
    (route) => false
);


Widget defaultButton({
  double width=double.infinity,
  Color? background ,
  double? height ,
  required Function() onTap,
  String? text ,
  Widget? child ,
  bool isUppercase = true,
  BoxDecoration? decoration ,
  Color textColor = Colors.white,
  FontWeight fontWeight = FontWeight.normal,
  double? fontSize ,
}) => Container(
  width: width,
  height: height??40.h,
  color: background,
  decoration: decoration?? BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: defaultColor
  ),
  child: MaterialButton(
    onPressed: onTap,
    padding: EdgeInsets.zero,
    splashColor: Colors.transparent,
    child : child ?? Text(
      isUppercase ? text!.toUpperCase() : text!,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize??14.sp,

      ),
    ),

  ),
);

void myToast({
  required String? msg ,
  required ToastStates state ,
}) => Fluttertoast.showToast(
    msg: msg!,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: toastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCSES,ERROR,WARNING}

Color toastColor(ToastStates state) {
  Color? color;
  switch(state)
  {
    case ToastStates.SUCCSES :
      color = Colors.green;
      break;
      case ToastStates.ERROR :
      color = Colors.red;
      break;
      case ToastStates.WARNING :
      color =  Colors.amber;
  }
  return color;
}

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
          ),
        ),
      ),
      titleSpacing: 5,
      bottom: tabs == null
          ? null
          : TabBar(
        tabs: tabs,
      ),
    );

Widget myBottomSheet({
  required BuildContext context,
  required List<Widget> items ,
}) => FittedBox(
  child: SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: items,
    ),
  ),
);

Widget bottomSheetItem({
  required Function() onTap,
  required Icon icon,
  required String title,
  Color titleColor = Colors.white,
}) => InkWell(
  splashColor: Colors.grey[600],
  onTap: onTap,
  child: Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children:  [
        icon,
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
                color: titleColor,
                fontSize: 20
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget firstBottomSheetItem() =>  Padding(
  padding: const EdgeInsets.only(top: 8.0),
  child: Center(
    child: Container(
      height: 5,
      width: 45,
      decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(30)
      ),
    ),
  ),
);

Widget colorPicker({
  required List<ColorSwatch> listOfColors ,
  double circleSize = 30,
  required Function(ColorSwatch?) onColorChange ,
  required Color selectedColor,
}) => MaterialColorPicker(
  colors: listOfColors,
  circleSize: circleSize,
  onMainColorChange: onColorChange,
  allowShades: false,
  selectedColor: selectedColor ,
);



Widget myCircularProgressIndicator({double? size}) =>
    LoadingAnimationWidget.threeRotatingDots(
      color: defaultColor,
      size: size ?? 40,
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
  String addCommaToString(){
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

String myTimeLeft(BuildContext context ,DateTime datetime, {bool full = true}) {
  DateTime now = DateTime.now();
  DateTime ago = datetime;
  Duration dur = now.difference(ago);
  int days = dur.inDays;
  int years = days ~/ 365;
  int months =  (days - (years * 365)) ~/ 30;
  int weeks = (days - (years * 365 + months * 30)) ~/ 7;
  int rdays = days - (years * 365 + months * 30 + weeks * 7).toInt();
  int hours = (dur.inHours % 24).toInt();
  int minutes = (dur.inMinutes % 60).toInt();
  int seconds = (dur.inSeconds % 60).toInt();
  var diff = {
    "d":rdays,
    "w":weeks,
    "m":months,
    "y":years,
    "s":seconds,
    "i":minutes,
    "h":hours
  };

  Map str = {
    'y':'سنة',
    'm':'شهر',
    'w':'أسبوع',
    'd':'يوم',
    'h':'ساعة',
    'i':'دقيقة',
    's':'ثانية',
  };

  str.forEach((k, v){
    if (diff[k]! < 0) {
      str[k] = '${diff[k]}$v${diff[k]! < 1 ? '' : ''}';
    } else {
      str[k] = "";
    }
  });
  str.removeWhere((index, ele)=>ele == "");
  List<String> tlist = [];
  str.forEach((k, v){
    tlist.add(v);
  });
  if(full){
    return str.isNotEmpty?tlist.join(", "):"Just Now";
  }else{
    return str.isNotEmpty?tlist[0]:"Just Now";
  }
}

void callDial(String phoneNumber) async {
  Uri uri = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(uri);
}



