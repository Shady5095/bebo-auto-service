import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import '../styles/icon_broken.dart';


void navigateToAnimated({context , widget , animation=PageTransitionType.fade}) => Navigator.push(context, PageTransition(
  type: animation,
  child: widget,
),
);

void navigateTo({context , widget ,}) => Navigator.push(context, MaterialPageRoute(builder: (context) => widget)
);

void navigateAndFinish({required context ,required widget,required PageTransitionType animation}) => Navigator.pushAndRemoveUntil(context,
     PageTransition(
  type: animation,
  child: widget,
  duration: Duration(milliseconds: 500)
),
    (route) => false
);


Widget deafultButton({
  double width=double.infinity,
  Color? background ,
  double height = 60,
  required Function() onTap,
  String? text ,
  Widget? child ,
  bool isUppercase = true,
  BoxDecoration? decoration ,
  Color textColor = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 17,
}) => Container(
  width: width,
  height: height,
  color: background,
  decoration: decoration,
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
        fontSize: fontSize,

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

PreferredSizeWidget deafaultAppBar({
  required BuildContext context,
  String? title ,
  List<Widget>? actions ,
  Function()? onPopMethod,
}) => AppBar(
  title: Text(
    title!,
    style: TextStyle(
      fontSize: 25,
    ),
  ),
  actions: actions,
  leading:IconButton(
    onPressed: onPopMethod??(){
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
      color: Theme.of(context).secondaryHeaderColor,
    ),
  ),
  titleSpacing: 5,

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

bool isArabic(context){
  Locale myLocale = Localizations.localeOf(context);
  return myLocale.languageCode == 'ar' ;
}

