import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/app_locale.dart';
import '../../../components/constans.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultBackgroundColor,
        elevation: 0,
        title: Text(
          '${getLang(context, 'Offers')}',
          style: TextStyle(
              fontSize: 22.sp
          ),
        ),
      ),
    );
  }
}
