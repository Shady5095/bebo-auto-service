import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/data_layer/models/spare_parts_model.dart';
import 'package:bebo_auto_service/presentation_layer/screens/chats_screens/chat_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../../../business_logic_layer/spare_parts_cubit/spare_parts_cubit.dart';
import '../../../../business_logic_layer/spare_parts_cubit/spare_parts_states.dart';
import '../../../../components/constans.dart';

class SparePartsDetailsScreen extends StatefulWidget {
  final SparePartsModel sparePartsModel;
  final String categoryImage;
  final Map<String, dynamic> snapshot;

  const SparePartsDetailsScreen(
      {Key? key,
      required this.sparePartsModel,
      required this.categoryImage,
      required this.snapshot})
      : super(key: key);

  @override
  State<SparePartsDetailsScreen> createState() =>
      _SparePartsDetailsScreenState();
}

class _SparePartsDetailsScreenState extends State<SparePartsDetailsScreen> {
  List<bool> isTapped = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SparePartsCubit, SparePartsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppbar(
            context: context,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: widget.sparePartsModel.image == null
                              ? Image.asset(
                                  widget.categoryImage,
                                  width: displayWidth(context) * 0.30,
                                  height: displayHeight(context) * 0.20,
                                )
                              : Hero(
                                  tag: '${widget.sparePartsModel.id}',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image(
                                      errorBuilder: (BuildContext? context,
                                          Object? exception,
                                          StackTrace? stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons.warning_amber,
                                            color: Colors.red,
                                            size: 100,
                                          ),
                                        );
                                      },
                                      loadingBuilder: (BuildContext? context,
                                          Widget? child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child!;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: defaultColor,
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      image: CachedNetworkImageProvider(
                                        '${widget.sparePartsModel.image}',
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          ('${widget.sparePartsModel.name}'),
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (widget.sparePartsModel.description != null)
                          Text(
                            ('${widget.sparePartsModel.description}'),
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.white54,
                            ),
                          ),
                        SizedBox(
                          height: 10.h,
                        ),
                        isOnePriceWidgetOrMultiPrice(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Text(
                              ' اخر تحديث :   ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format((widget
                                  .sparePartsModel.lastPriceUpdate
                                  ?.toDate())!),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green,
                                fontStyle: FontStyle.italic,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget priceText(String priceType) {
    if (widget.snapshot['${MainAppCubit.get(context).userData!.carModel}'
                    .removeSpaceAndToLowercase()]
                ['${MainAppCubit.get(context).userData!.year}'] ==
            null ||
        widget.snapshot['${MainAppCubit.get(context).userData!.carModel}'
                    .removeSpaceAndToLowercase()]
                ['${MainAppCubit.get(context).userData!.year}'][priceType] ==
            null) {
      return Text(
        'غير متوفر',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontSize: 25.sp,
        ),
      );
    } else {
      if ((widget.sparePartsModel.isShowPriceToCustomer!)) {
        return Text(
          '${widget.snapshot['${MainAppCubit.get(context).userData!.carModel}'.removeSpaceAndToLowercase()]['${MainAppCubit.get(context).userData!.year}'][priceType]}'
              .addCommaToString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.sp,
          ),
        );
      } else {
        return Column(
          children: [
            Text(
              'متوفر',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontSize: 24.sp,
              ),
            ),
            InkWell(
              onTap: (){
                navigateTo(
                  context: context,
                  widget: ChatsDetailsScreen(
                    fromSpareParts: 'سعر ${widget.sparePartsModel.name} لعربية ${MainAppCubit.get(context).userData!.carModel} ${MainAppCubit.get(context).userData!.year} ؟ ',
                  ),
                );
              },
              child: Text(
                'ارسال رساله لمعرفة السعر',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: defaultColor,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        );
      }
    }
  }

  Widget isOnePriceWidgetOrMultiPrice(){
    if (widget.sparePartsModel.onePrice != null){
      if(widget.sparePartsModel.isShowPriceToCustomer!){
        return Center(
          child: Text(
            '${widget.sparePartsModel.onePrice}'
                .addCommaToString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: defaultColor,
              fontSize: 29.sp,
            ),
          ),
        );
      }
      else {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'متوفر',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 29.sp,
                ),
              ),
              InkWell(
                onTap: (){
                  navigateTo(
                    context: context,
                    widget: ChatsDetailsScreen(
                      fromSpareParts: 'سعر ${widget.sparePartsModel.name} لعربية ${MainAppCubit.get(context).userData!.carModel} ${MainAppCubit.get(context).userData!.year} ؟ ',
                    ),
                  );
                },
                child: Text(
                  'ارسال رساله لمعرفة السعر',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: defaultColor,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    else
      {
        return Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: displayWidth(context) * 0.40,
                  constraints: BoxConstraints(
                      minHeight:
                      displayHeight(context) * 0.14),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(2, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'جديد كوبي تايواني',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16.sp,
                        ),
                      ),
                      Center(child: priceText('copy')),
                    ],
                  ),
                ),
                SizedBox(
                  width: 13.w,
                ),
                Container(
                  width: displayWidth(context) * 0.40,
                  constraints: BoxConstraints(
                      minHeight:
                      displayHeight(context) * 0.14),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(2, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'جديد أصلي',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16.sp,
                        ),
                      ),
                      Center(child: priceText('new')),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Container(
                width: displayWidth(context) * 0.40,
                constraints: BoxConstraints(
                    minHeight: displayHeight(context) * 0.14),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(2, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'استيراد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16.sp,
                      ),
                    ),
                    Center(child: priceText('estirad')),
                  ],
                ),
              ),
            ),
          ],
        );
      }
  }
}
