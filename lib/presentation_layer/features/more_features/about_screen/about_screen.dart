import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../components/constans.dart';
import '../../../widgets/image_viewer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  List<String> centerImages = [
    'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/centerImages%2FWhatsApp%20Image%202023-11-22%20at%2020.11.44_2ac69ccd.jpg?alt=media&token=3876fcec-792a-4c8b-b695-7f6e71e3552d',
    'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/centerImages%2FWhatsApp%20Image%202023-11-22%20at%2020.11.36_51302e34.jpg?alt=media&token=0ddacc1c-668a-47c1-9019-fb8df29b549e',
    'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/centerImages%2FWhatsApp%20Image%202023-11-22%20at%2020.11.45_1218aa40.jpg?alt=media&token=46a1e98d-56ee-4641-bf1d-57e9ce4411c9',
    'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/centerImages%2FWhatsApp%20Image%202023-11-22%20at%2020.11.42_c0dea5f4.jpg?alt=media&token=d9a38184-c92a-4b4a-8eeb-753e3dd2802d',
    'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/centerImages%2FWhatsApp%20Image%202023-11-22%20at%2020.11.45_91ada549.jpg?alt=media&token=a900e2c4-b688-4e10-ae3c-c577fac18581',
    'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/centerImages%2FWhatsApp%20Image%202023-11-22%20at%2020.11.45_e5dc4980.jpg?alt=media&token=86730469-780e-4fb0-9632-f41979b0939d',
    'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/centerImages%2FWhatsApp%20Image%202023-11-22%20at%2020.07.33_8eaff16c.jpg?alt=media&token=bbba215d-3123-4f6f-9c65-f9cd8203899a',
    'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/centerImages%2FWhatsApp%20Image%202023-11-22%20at%2020.06.19_cefda2d1.jpg?alt=media&token=cef183b0-4db3-4c79-ad97-a12605a1f118',
  ];
  int carouselIndex = 0;
  bool isAnimatedTextFinsh = false;

  Future<void> finshTextAnimation() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    isAnimatedTextFinsh = true ;
    if(mounted){
      setState(() {

      });
    }
  }
@override
  void initState() {
    super.initState();
    finshTextAnimation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'عن المركز',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AnimationLimiter(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 500),
                childAnimationBuilder: (widget) =>
                    SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                children: [
                  InkWell(
                    onTap: () {
                      navigateTo(
                        context: context,
                        widget: ImageViewer(
                          photosList: centerImages,
                          isNetworkImage: true,
                          photosListIndex: carouselIndex,
                        ),
                      );
                    },
                    child: CarouselSlider(
                      items: centerImages
                          .map(
                            (e) =>
                            Image(
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
                          dotsCount: centerImages.length,
                          position: carouselIndex.toDouble(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: AnimatedTextKit(
                      repeatForever: false,
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          'مرحبًا بكم في مركز صيانة بيبو اوتو المتخصص في صيانة سيارات المازدا',
                          speed: const Duration(milliseconds: 35),
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  if (isAnimatedTextFinsh)
                    AnimationLimiter(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 500),
                            childAnimationBuilder: (widget) =>
                                SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: widget,
                                  ),
                                ),
                            children: [
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(
                                'هنا يلتقي التميز في السيارات بالخدمة التي لا مثيل لها! في منشأتنا الحديثة، نفخر بضمان حصول سيارة مازدا الخاصة بك على أعلى مستويات الجودة من الرعاية والاهتمام الذي تستحقه. فريقنا من الفنيين المهرة مدرب للحفاظ على تشغيل سيارة مازدا الخاصة بك بسلاسة .',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.white54),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(
                                'في مركز صيانة بيبو اوتو، نقدم مجموعة شاملة من خدمات الصيانة للحفاظ على سيارتك في أفضل حالة :-',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.white54),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildAllServicesText(
                                      'جميع الصيانات الدورية وتغيير الزيت والفلاتر'),
                                  buildAllServicesText(
                                      'جميع اعمال الكهرباء والتكييف'),
                                  buildAllServicesText(
                                      'جميع اعمال الميكانيكا والماتور'),
                                  buildAllServicesText(
                                      'جميع اعمال العفشة والفرامل'),
                                  buildAllServicesText(
                                      'جميع اعمال السمكره والدوكو'),
                                ],
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(
                                'يمكن لمركز الصيانة الخاص بنا، المجهز بأدوات وتقنيات تشخيصية متطورة، تحديد أي مشكلات قد تواجهها سيارة مازدا الخاصة بك ومعالجتها بسرعة. يخضع الفنيون المهرة لدينا لتدريب مستمر للبقاء على اطلاع بأحدث التطورات في مجال السيارات، مما يمكننا من تقديم خدمات صيانة وإصلاح دقيقة وفعالة.',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.white54),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(
                                'رضاكم هو أولويتنا. نحن نسعى جاهدين لخلق بيئة صديقة للعملاء حيث تشعر بالثقة وتكون مطلعًا على خدمات الصيانة التي تتلقاها سيارة مازدا الخاصة بك. فريقنا جاهز للإجابة على أسئلتك، وتقديم تفسيرات شفافة للخدمات الموصى بها، والتأكد من شعورك بالراحة طوال العملية بأكملها.',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.white54),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Center(
                                child: Text(
                                  'شكرا لأختياركم مركز بيبو اوتو',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text buildAllServicesText(String text) {
    return Text(
      '* $text',
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 15.sp, color: Colors.white54,fontWeight: FontWeight.w700),
    );
  }
}
