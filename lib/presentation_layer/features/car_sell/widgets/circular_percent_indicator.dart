import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircularPercentIndicatorWidget extends StatefulWidget {
  final double conditionValue;

  final String name;

  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  final String? notes;

  const CircularPercentIndicatorWidget({
    Key? key,
    required this.conditionValue,
    required this.name,
    required this.notes, required this.snapshot,
  }) : super(key: key);

  @override
  State<CircularPercentIndicatorWidget> createState() => _CircularPercentIndicatorWidgetState();
}

class _CircularPercentIndicatorWidgetState extends State<CircularPercentIndicatorWidget> {
  late int green = (widget.conditionValue * 2.55).toInt();
  late int red = ((255 - (widget.conditionValue * 2.55 * 0.5))).toInt();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SleekCircularSlider(
              appearance: CircularSliderAppearance(
                size: 52.sp,
                infoProperties: InfoProperties(
                  mainLabelStyle:
                  TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
                customColors:
                CustomSliderColors(dotColor: Colors.black, trackColors: [
                  Colors.grey[800]!,
                  Colors.grey[600]!,
                  Colors.grey[200]!,
                ], progressBarColors: [
                  Color.fromRGBO(red, green, 0, 1),
                  Color.fromRGBO(red, green, 0, 1),
                  Color.fromRGBO(
                      (red - widget.conditionValue).toInt(), (green - widget.conditionValue).toInt(), 0, 1),
                ]),
              ),
              initialValue: widget.conditionValue,

            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              flex: 3,
              child: Text(
                widget.name,
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 4,
              child: Text(
                (widget.notes)??'لا توجد ملاحاظات',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
