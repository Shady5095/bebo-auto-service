import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/models/car_sell_models/car_condition_model.dart';
import 'package:bebo_auto_service/data_layer/models/car_sell_models/seller_and_car_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/components.dart';
import '../car_sell_widgets/circular_percent_indicator.dart';

class CustomerReportsExpandableWidget extends StatefulWidget {
  final int index;
  final String reportDocId;
  final String customerDocId;

  const CustomerReportsExpandableWidget({
    Key? key,
    required this.index,
    required this.reportDocId, required this.customerDocId,
  }) : super(key: key);

  @override
  State<CustomerReportsExpandableWidget> createState() =>
      _CustomerReportsExpandableWidgetState();
}

class _CustomerReportsExpandableWidgetState
    extends State<CustomerReportsExpandableWidget> {
  List<bool> isTapped = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];
  List<bool> isExpanded = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
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
  List<String> categoriesEn = [
    'engineAndTransmission',
    'brake',
    'airCondition',
    'suspension',
    'electric',
    'computer',
    'interior',
    'body',
    'otherNotes',
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
      /*height:
        isTapped[index] ? isExpanded[index] ? 65.h : 70.h : isExpanded[index] ? 860.h : 855.h,*/
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      child: isTapped[widget.index]
          ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                isTapped[widget.index] = !isTapped[widget.index];
              });
            },
            onHighlightChanged: (value) {
              setState(() {
                isExpanded[widget.index] = value;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    categoriesAr[widget.index],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  Icon(
                    isTapped[widget.index]
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      )
          : Column(
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                isTapped[widget.index] = !isTapped[widget.index];
              });
            },
            onHighlightChanged: (value) {
              setState(() {
                isExpanded[widget.index] = value;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    categoriesAr[widget.index],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  Icon(
                    isTapped[widget.index]
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('verifiedUsers')
                  .doc(widget.customerDocId)
                  .collection('reports')
                  .doc(widget.reportDocId)
                  .collection(categoriesEn[widget.index])
                  .orderBy('order')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return  Center(
                    child: Icon(
                      Icons.warning_amber,
                      color: Colors.red,
                      size: 80.sp,
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(child: myCircularProgressIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.data_saver_off,
                          size: 70.sp,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        Text(
                          'لا توجد معلومات',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: [
                    ListView.separated(
                      itemCount: snapshot.data!.docs.length - 1,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Center(
                          child: Container(
                            width: displayWidth(context) * 0.5,
                            height: 1,
                            color: defaultColor,
                          ),
                        );
                      },
                      itemBuilder: (context, index) {
                        CarConditionModel carConditionModel =
                        CarConditionModel.fromJson(
                            snapshot.data!.docs[index].data());
                        return CircularPercentIndicatorWidget(
                          snapshot: snapshot,
                          conditionValue:
                          (carConditionModel.condition)!
                              .toDouble(),
                          name: carConditionModel.name!,
                          notes: carConditionModel.notes,
                        );
                      },
                    ),
                    Container(
                      width: displayWidth(context) * 0.5,
                      height: 1,
                      color: defaultColor,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '${snapshot.data!.docs.last.data()['notes'] ?? 'لا توجد ملاحظات'}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }
}
