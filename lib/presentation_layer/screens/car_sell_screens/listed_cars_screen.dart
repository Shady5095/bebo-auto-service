import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../data_layer/models/car_sell_models/seller_and_car_info_model.dart';
import 'car_sell_tab_view_screen.dart';

class ListedCarsForSaleScreen extends StatelessWidget {
  const ListedCarsForSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        backgroundColor: defaultBackgroundColor,
        elevation: 0,
        title: Text(
          'السيارات المعروضة للبيع',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: FutureBuilder(
          future:
          FirebaseFirestore.instance.collection('carsForSell').orderBy('addedTime',descending: true).get(),
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
            height: 100.h,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(2, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(20).r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: displayWidth(context) * 0.30,
                  child: carSellModel.images == null || carSellModel.images!.isEmpty
                      ? const Icon(
                          FluentIcons.image_off_24_regular,
                          color: Colors.white54,
                          size: 37,
                        )
                      : Hero(
                          tag: '${carSellModel.docId}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext? context,
                                  Object? exception, StackTrace? stackTrace) {
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
                                if (loadingProgress == null) return child!;
                                return Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
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
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              carSellModel.carName ?? '-----',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.sp),
                            ),
                          ),
                          if (carSellModel.isSold!)
                            RotationTransition(
                              turns: const AlwaysStoppedAnimation(340 / 360),
                              child: Column(
                                children: [
                                  Icon(
                                    CupertinoIcons.checkmark_seal,
                                    color: defaultColor,
                                    size: 25.sp,
                                  ),
                                  Text(
                                    'مباعه',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Text(
                        carSellModel.carYear ?? '-----',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
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
