import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/presentation_layer/screens/car_sell_screens/seller_and_car_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/constans.dart';
import '../../../data_layer/models/car_sell_models/seller_and_car_info_model.dart';
import '../../widgets/my_alert_dialog.dart';
import 'car_condition_screen.dart';

class CarSellTabViewScreen extends StatelessWidget {
  final CarSellModel carSellModel;

  const CarSellTabViewScreen({
    Key? key,
    required this.carSellModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: defaultAppbar(
          context: context,
          tabs: [
            Tab(
              height: 37.h,
              child: Text('تفاصيل السيارة', style: TextStyle(fontSize: 14.sp)),
            ),
            Tab(
              height: 37.h,
              child: Text('حالة السيارة', style: TextStyle(fontSize: 14.sp)),
            ),
          ],
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            SellerAndCarDetailsScreen(carSellModel: carSellModel),
            CarConditionScreen(
              carSellModel: carSellModel,
            ),
          ],
        ),
      ),
    );
  }
}
