import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/local/cache_helper.dart';
import 'package:bebo_auto_service/presentation_layer/widgets/my_alert_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../data_layer/models/car_sell_models/seller_and_car_info_model.dart';
import 'car_sell_tab_view_screen.dart';

class ListedCarsForSaleScreen extends StatefulWidget {
  final bool isFromBlurHomeScreen ;
  const ListedCarsForSaleScreen({Key? key, required this.isFromBlurHomeScreen}) : super(key: key);

  @override
  State<ListedCarsForSaleScreen> createState() =>
      _ListedCarsForSaleScreenState();
}

class _ListedCarsForSaleScreenState extends State<ListedCarsForSaleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (CacheHelper.getBool(key: 'carSellDialogSeen') == null) {
        await showDialog(
            context: context,
            builder: (context) => MyAlertDialog(
                  actions: const [],
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: ImageIcon(
                          size: 95.sp,
                          color: defaultColor,
                          const AssetImage('assets/icons/carSellDialog.png'),
                        ),
                      ),
                      Text(
                        'من انهارده متشيلش هم بيع عربيتك ... تقدر تيجي مركز بيبو اوتو تفحص عربيتك بالكامل بضمان المركز وعربيتك هتنزل علي التطبيق بتقرير الفحص بحيث ان المشتري يكون عارف كل تفاصيل العربية لعدم اضاعه الوقت',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ],
                  ),
                ));
        CacheHelper.putBool(key: 'carSellDialogSeen', value: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        title: Text(
          'السيارات المعروضة للبيع',
          style: TextStyle(
            fontSize: 20.sp,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => MyAlertDialog(
                          actions: const [],
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: ImageIcon(
                                  size: 95.sp,
                                  color: defaultColor,
                                  const AssetImage(
                                      'assets/icons/carSellDialog.png'),
                                ),
                              ),
                              Text(
                                'من انهارده متشيلش هم بيع عربيتك ... تقدر تيجي مركز بيبو اوتو تفحص عربيتك بالكامل بضمان المركز وعربيتك هتنزل علي التطبيق بتقرير الفحص بحيث ان المشتري يكون عارف كل تفاصيل العربية لعدم اضاعه الوقت',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ));
              },
              icon: Icon(
                CupertinoIcons.info,
                size: 20.sp,
              ))
        ],
        leading: widget.isFromBlurHomeScreen ? IconButton(
          onPressed: () {
                Navigator.pop(context);
              },
          icon: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).secondaryHeaderColor,
              size: 19.sp,
            ),
          ),
        ) : null,
        titleSpacing: 12.w,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('carsForSell')
              .orderBy('addedTime', descending: true)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                  size: 100,
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(child: myCircularProgressIndicator());
            }
            if ((snapshot.data?.docs.isEmpty)!) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FluentIcons.vehicle_car_24_regular,
                      size: 130,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'لا يوجد سيارات معروضة',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        CarSellModel carSellModel = CarSellModel.fromJson(
                            snapshot.data!.docs[index].data());
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: buildNewCarItem(carSellModel, context),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget buildNewCarItem(CarSellModel carSellModel, BuildContext context) =>
      InkWell(
        onTap: () {
          navigateTo(
              widget: CarSellTabViewScreen(
                carSellModel: carSellModel,
              ),
              context: context);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            height: 120.h,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(2, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(20).r),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    carSellModel.images == null ||
                            carSellModel.images!.isEmpty
                        ?  Icon(
                            FluentIcons.image_off_24_regular,
                            color: Colors.white54,
                            size: 31.sp,
                          )
                        : Hero(
                            tag: '${carSellModel.docId}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                height: 120.h,
                                width: displayWidth(context) * 0.40,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext? context,
                                    Object? exception,
                                    StackTrace? stackTrace) {
                                  return  Center(
                                    child: Icon(
                                      Icons.warning_amber,
                                      color: Colors.red,
                                      size: 30.sp,
                                    ),
                                  );
                                },
                                loadingBuilder: (BuildContext? context,
                                    Widget? child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child!;
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
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
                                    ),
                                  );
                                },
                                image: CachedNetworkImageProvider(
                                  carSellModel.images![0],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            carSellModel.carName ?? '-----',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.sp),
                          ),
                          Text(
                            '${carSellModel.carYear}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                          if (carSellModel.otherNotes != null)
                            Text(
                              '${carSellModel.otherNotes}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11.sp,
                                  height: 1.3),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (carSellModel.isSold!)
                  RotationTransition(
                    turns: const AlwaysStoppedAnimation(340 / 360),
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.checkmark_seal,
                          color: defaultColor,
                          size: 20.sp,
                        ),
                        Text(
                          'مباعه',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}
