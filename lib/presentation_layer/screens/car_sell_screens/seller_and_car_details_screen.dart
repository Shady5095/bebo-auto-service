import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/presentation_layer/screens/chats_screens/chat_details_screen.dart';
import 'package:bebo_auto_service/presentation_layer/widgets/image_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:intl/intl.dart' as dateTimeIntl;
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../../components/constans.dart';
import '../../../data_layer/models/car_sell_models/seller_and_car_info_model.dart';

class SellerAndCarDetailsScreen extends StatefulWidget {
  final CarSellModel carSellModel;
  const SellerAndCarDetailsScreen({
    Key? key,
    required this.carSellModel,
  }) : super(key: key);

  @override
  State<SellerAndCarDetailsScreen> createState() =>
      _SellerAndCarDetailsScreenState();
}

class _SellerAndCarDetailsScreenState extends State<SellerAndCarDetailsScreen> {
  int carouselIndex = 0;
  late double newValue = (widget.carSellModel.overAllRating)!.toDouble();
  late int green = ((newValue * 2.55)).toInt();
  late int red = ((255 - (newValue * 2.55 * 0.5))).toInt();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.carSellModel.images != null &&
                widget.carSellModel.images!.isNotEmpty)
              Hero(
                tag: '${widget.carSellModel.docId}',
                child: Material(
                  color: defaultBackgroundColor,
                  child: InkWell(
                    onTap: () {
                      navigateTo(
                        context: context,
                        widget: ImageViewer(
                          photosList: widget.carSellModel.images,
                          isNetworkImage: true,
                          photosListIndex: carouselIndex,
                        ),
                      );
                    },
                    child: CarouselSlider(
                      items: widget.carSellModel.images
                          ?.map(
                            (e) => Image(
                              fit: BoxFit.cover,
                              width: double.infinity,
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
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                                e,
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                          initialPage: carouselIndex,
                          aspectRatio: 4 / 3,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: false,
                          reverse: false,
                          viewportFraction: 1.0,
                          autoPlay: false,
                          scrollDirection: Axis.horizontal,
                          scrollPhysics: const BouncingScrollPhysics(),
                          onPageChanged: (index, reason) {
                            carouselIndex = index;
                            setState(() {});
                          }),
                    ),
                  ),
                ),
              ),
            if (widget.carSellModel.images != null &&
                widget.carSellModel.images!.isNotEmpty)
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DotsIndicator(
                      decorator: DotsDecorator(
                        activeColor: defaultColor,
                        color: Colors.white54,
                        shape: OvalBorder(
                            eccentricity: 0.9,
                            side: BorderSide(
                                width: 1,
                                color: Theme.of(context).primaryColor)),
                        size: const Size.square(9.0),
                        activeSize: const Size(16.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      dotsCount: widget.carSellModel.images!.length,
                      position: carouselIndex.toDouble(),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.carSellModel.carName}',
                    style: TextStyle(color: Colors.white, fontSize: 23.sp),
                  ),
                  if(widget.carSellModel.otherNotes != null)
                    Text(
                      '${widget.carSellModel.otherNotes}',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white54, fontSize: 14.sp),
                    ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'موديل :  ',
                        style:
                            TextStyle(color: Colors.white54, fontSize: 16.sp),
                      ),
                      Text(
                        '${widget.carSellModel.carYear}',
                        style: TextStyle(color: Colors.white, fontSize: 17.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'عداد :  ',
                        style:
                            TextStyle(color: Colors.white54, fontSize: 16.sp),
                      ),
                      Text(
                        '${'${widget.carSellModel.km}'.addCommaToString()} كم',
                        style: TextStyle(color: defaultColor, fontSize: 17.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'تاريخ أضافة السياره :  ',
                        style:
                            TextStyle(color: Colors.white54, fontSize: 16.sp),
                      ),
                      Expanded(
                        child: Text(
                          '${dateTimeIntl.DateFormat.yMMMd('ar').format((widget.carSellModel.addedTime?.toDate())!)}  :  ${dateTimeIntl.DateFormat.jm('ar').format(widget.carSellModel.addedTime!.toDate())}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                        angleRange: 240,
                        size: 50.sp,
                        infoProperties: InfoProperties(
                          mainLabelStyle:
                          TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                        customColors: CustomSliderColors(
                            dotColor: Colors.black,
                            trackColors: [
                              Colors.grey[800]!,
                              Colors.grey[600]!,
                              Colors.grey[200]!,
                            ],
                            progressBarColors: [
                              Color.fromRGBO(red, green,0, 1),
                              Color.fromRGBO(red, green, 0, 1),
                              Color.fromRGBO(
                                  (red - widget.carSellModel.overAllRating!.toInt()).toInt(), (green - widget.carSellModel.overAllRating!.toInt()).toInt(), 0, 1),
                            ]),
                      ),
                      initialValue: widget.carSellModel.overAllRating!.toDouble(),
                    ),
                  ),
                  Center(
                    child: Text(
                      'التقييم النهائى',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'لمعرفة السعر وباقي التفاصيل تواصل معنا :- ',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        InkWell(
                          onTap: () {
                            callDial('01009109792');
                          },
                          child: Text(
                            '01009109792',
                            style:
                                TextStyle(color: defaultColor, fontSize: 22.sp),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                callDial('01009109792');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.call,
                                  color: Colors.green,
                                  size: 30.sp,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                openWhatsapp(
                                    phoneNumber: '+201009109792', text: '');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green,
                                  size: 30.sp,
                                ),
                              ),
                            ),
                            if(myUid !=null)
                            InkWell(
                              onTap: () {
                                navigateToAnimated(
                                    context: context,
                                    widget: const ChatsDetailsScreen());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  CupertinoIcons.chat_bubble_2,
                                  color: defaultColor,
                                  size: 30.sp,
                                ),
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
          ],
        ),
      ),
    );
  }
}
