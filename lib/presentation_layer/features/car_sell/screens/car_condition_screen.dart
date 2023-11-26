import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data_layer/models/car_sell_models/seller_and_car_info_model.dart';
import '../widgets/car_sell_condition_expandable_widget.dart';


class CarConditionScreen extends StatefulWidget {
  final CarSellModel carSellModel ;
  const CarConditionScreen({Key? key, required this.carSellModel}) : super(key: key);

  @override
  State<CarConditionScreen> createState() => _CarConditionScreenState();
}

class _CarConditionScreenState extends State<CarConditionScreen> {

  List<String> categoriesAr = [
    'الماتور والفتيس',
    'نظام الفرامل',
    'التكييف',
    'العفشة و البطاحات',
    'الكهرباء',
    'جهاز الأعطال',
    'الصالون الداخلي',
    'الهيكل الخارجي',
    'اعمال الشاسيه وملاحظات اخري',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 15),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CarConditionExpandableWidget(
            index: index,
            carSellModel: widget.carSellModel,
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15.h,
          );
        },
        itemCount: categoriesAr.length,
      ),
    );
  }
}


