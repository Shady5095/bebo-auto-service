import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/components.dart';
import '../../components/constans.dart';

class MyAlertDialog extends StatelessWidget {
  final Widget? content;

  final List<Widget>? actions;
  final bool? isFailed;
  final String? title;
  final Function()? onTapYes;

  const MyAlertDialog({
    Key? key,
    this.content,
    this.actions,
    this.isFailed,
    this.title,
    this.onTapYes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: isFailed != null
          ? CircleAvatar(
              radius: 32,
              backgroundColor: isFailed! ? Colors.red : Colors.green,
              child: Icon(
                isFailed! ? Icons.close : Icons.check,
                color: Colors.white,
                size: 27.sp,
              ),
            )
          : null,
      contentPadding: const EdgeInsets.only(
        bottom: 5,
        top: 15,
        right: 15,
        left: 15,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      backgroundColor: defaultBackgroundColor,
      //this right here
      content: content ??
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
      actions: actions ??
          [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: defaultButton(
                onTap: () {
                  Navigator.pop(context);
                },
                text: 'لا',
                width: displayWidth(context) * 0.23,
                height: 28.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey[800],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: defaultButton(
                onTap: onTapYes!,
                text: 'نعم',
                width: displayWidth(context) * 0.23,
                height: 28.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: defaultColor,
                ),
              ),
            ),
          ],
    );
  }
}
