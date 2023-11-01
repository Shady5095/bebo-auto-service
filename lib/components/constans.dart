
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'app_locale.dart';


const Color defaultColor = Color.fromRGBO(210, 29, 29, 1.0);
const Color defaultBackgroundColor = Color.fromRGBO(35, 33, 33, 1.0);
String? myUid = '';


String myDateTime(){
  DateTime dt = DateTime.now();
  var formattedTime = DateFormat("hh:mm a").format(
      DateTime.now());
  String myDateTime = '${dt.year}-${dt.month}-${dt.day} at $formattedTime' ;
  return myDateTime;
}

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {

  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  return displaySize(context).width;
}

double displayAspectRatio(BuildContext context) {
  return displaySize(context).aspectRatio;
}

