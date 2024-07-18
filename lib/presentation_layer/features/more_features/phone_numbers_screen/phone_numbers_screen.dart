import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhoneNumbersScreen extends StatefulWidget {
  const PhoneNumbersScreen({super.key});

  @override
  State<PhoneNumbersScreen> createState() => _PhoneNumbersScreenState();
}

class _PhoneNumbersScreenState extends State<PhoneNumbersScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: defaultAppbar(
            context: context,
            title: 'ارقام التليفون و العناوين',
            tabs: [
              Tab(
                height: 37.h,
                child: Text('فرع العبور', style: TextStyle(fontSize: 14.sp)),
              ),
              Tab(
                height: 37.h,
                child: Text('فرع أكتوبر', style: TextStyle(fontSize: 14.sp)),
              ),
            ]),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('contactUs')
                            .where('branch', isEqualTo: 'obour')
                            .orderBy('dateTime')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Icon(
                                Icons.warning_amber,
                                color: Colors.red,
                                size: 30,
                              ),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                                child: myCircularProgressIndicator(size: 20));
                          }
                          if ((snapshot.data?.docs.isEmpty)!) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    size: 30.sp,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'لا يوجد ارقام',
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> phoneMap =
                                  snapshot.data!.docs[index].data();
                              return buildPhoneNumber(phoneMap);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 5.h,
                              );
                            },
                            itemCount: snapshot.data!.docs.length,
                          );
                        }),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location_solid,
                          color: defaultColor,
                          size: 22.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Text(
                            'المنطقه الصناعية الأولي - خلف بنك قناه السويس وخلف توكيل تيوتا العبور',
                            maxLines: 3,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        MapUtils.openMap(
                            'https://www.google.com/maps/place/%D8%A8%D9%8A%D8%A8%D9%88+AUTO%E2%80%AD/@30.180788,31.4713093,15.25z/data=!4m6!3m5!1s0x14581bee8d826819:0x1292287cc984eab7!8m2!3d30.1811667!4d31.4651143!16s%2Fg%2F11jkv1hzjk?entry=ttu');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: const Image(
                          image: AssetImage('assets/images/obourLocation.jpg'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blueAccent,
                            size: 34.sp,
                          ),
                          onTap: () {
                            openFacebook();
                          },
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Icon(
                          FontAwesomeIcons.instagram,
                          color: const Color.fromRGBO(238, 12, 124, 1.0),
                          size: 34.sp,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Icon(
                         FontAwesomeIcons.twitter,
                          color: Colors.blue,
                          size: 34.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('contactUs')
                            .where('branch', isEqualTo: 'october')
                            .orderBy('dateTime')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Icon(
                                Icons.warning_amber,
                                color: Colors.red,
                                size: 30,
                              ),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                                child: myCircularProgressIndicator(size: 20));
                          }
                          if ((snapshot.data?.docs.isEmpty)!) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    size: 30.sp,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    'لا يوجد ارقام',
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> phoneMap =
                                  snapshot.data!.docs[index].data();
                              return buildPhoneNumber(phoneMap);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 5.h,
                              );
                            },
                            itemCount: snapshot.data!.docs.length,
                          );
                        }),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location_solid,
                          color: defaultColor,
                          size: 22.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Text(
                            'المنطقه الصناعيه التانيه - خلف توكيل رينو',
                            maxLines: 3,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        MapUtils.openMap(
                            'https://www.google.com/maps/place/BEBO+AUTO/@29.9141728,30.9117395,17z/data=!3m1!4b1!4m6!3m5!1s0x145855dcf1db4505:0xcec024978bb5a630!8m2!3d29.9141728!4d30.9091699!16s%2Fg%2F11ty0jplh2?entry=ttu');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: const Image(
                          image:
                              AssetImage('assets/images/octoberLocation.jpg'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blueAccent,
                            size: 34.sp,
                          ),
                          onTap: () {
                            openFacebook();
                          },
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhoneNumber(Map<String, dynamic> phoneMap) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${phoneMap['phone']} ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
          if (phoneMap['name'] != null && phoneMap['name'] != '')
            Expanded(
              child: Text(
                '-  ${phoneMap['name']}',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
              ),
            ),
          IconButton(
            onPressed: () {
              callDial(phoneMap['phone']);
            },
            padding: const EdgeInsets.symmetric(horizontal: 8).w,
            icon: Icon(
              Icons.call,
              color: defaultColor,
              size: 21.sp,
            ),
          ),
          if ('${phoneMap['phone']}'.length == 11)
            IconButton(
              onPressed: () {
                openWhatsapp(phoneNumber: '+2${phoneMap['phone']}', text: '');
              },
              padding: const EdgeInsets.symmetric(horizontal: 8).w,
              icon: Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.green,
                size: 21.sp,
              ),
            ),
        ],
      );
}
