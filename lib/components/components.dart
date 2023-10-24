import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

import '../styles/icon_broken.dart';
import 'constans.dart';


void navigateToAnimated({context , widget , animation=PageTransitionType.leftToRight}) => Navigator.push(context, PageTransition(
  type: animation,
  child: widget,
  curve: Curves.fastOutSlowIn,
  duration: const Duration(
    milliseconds: 400
  )
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


Widget defaultButton({
  double width=double.infinity,
  Color? background ,
  double height = 60,
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
  height: height,
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
  String? title ,
  List<Widget>? actions ,
  Function()? onPopMethod,
}) => AppBar(
  title: Text(
    title!,
    style: TextStyle(
      fontSize: 18.sp,
    ),
  ),
  actions: actions,
  leading:IconButton(
    onPressed: onPopMethod??(){
      Navigator.pop(context);
    },
    icon: Icon(
      Icons.arrow_back_ios,
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



Widget myCircularProgressIndicator() => LoadingAnimationWidget.threeRotatingDots(color: defaultColor, size: 40 ,) ;

void unFocusKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

String addCommaToString(String num){
  String price = num;
  String priceInText = "";
  int counter = 0;
  for(int i = (price.length - 1);  i >= 0; i--){
    counter++;
    String str = price[i];
    if((counter % 3) != 0 && i !=0){
      priceInText = "$str$priceInText";
    }else if(i == 0 ){
      priceInText = "$str$priceInText";

    }else{
      priceInText = ",$str$priceInText";
    }
  }
  return priceInText.trim();
}



