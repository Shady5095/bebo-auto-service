import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/models/user_model.dart';
import 'package:bebo_auto_service/presentation_layer/widgets/my_alert_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../business_logic_layer/main_app_cubit/main_app_cubit.dart';
import '../../../../business_logic_layer/main_app_cubit/main_app_states.dart';
import '../../../../data_layer/local/cache_helper.dart';
import '../../home/home_screen/blur_home_screen.dart';

class MyProfileScreen extends StatefulWidget {
  final UserModel userData;

  const MyProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late var firstNameController =
      TextEditingController(text: widget.userData.firstName);
  late var lastNameController =
      TextEditingController(text: widget.userData.lastName);
  late var phoneController = TextEditingController(text: widget.userData.phone);
  var currentPasswordController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var passFormKey = GlobalKey<FormState>();

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changeSuffixIcon() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainAppCubit, MainAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            unFocusKeyboard(context);
          },
          child: Scaffold(
            appBar: defaultAppbar(
              context: context,
              title: 'تعديل الملف الشخصي',
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 14.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 13.sp,height: 1.3.h),
                                  controller: firstNameController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(14),
                                  ],
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                        )),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 7),
                                      label: Text(
                                        'الأسم الأول',
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                      prefixIcon: const Icon(
                                        CupertinoIcons.person,
                                      ),
                                      labelStyle:
                                          TextStyle(color: Colors.grey[500]),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'برجاء أدخال البيانات';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 13.sp,height: 1.3.h,),
                                  controller: lastNameController,
                                  textCapitalization: TextCapitalization.words,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(14),
                                  ],
                                  decoration: InputDecoration(focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      )),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 7),
                                      label: const Text(
                                        'الأسم الأخير',
                                      ),
                                      prefixIcon: const Icon(
                                        CupertinoIcons.person,
                                      ),
                                      labelStyle: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 13.sp),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ))),

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'برجاء أدخال البيانات';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 13.sp,
                              height: 1.3.h
                            ),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    )),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                label: Text(
                                  'رقم الهاتف',
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                labelStyle: TextStyle(color: Colors.grey[500]),
                                prefixIcon: const Icon(
                                  CupertinoIcons.phone,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Theme.of(context).secondaryHeaderColor,
                                ))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone must not be empty';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Center(
                            child: defaultButton(
                                onTap: () {
                                  unFocusKeyboard(context);
                                  if ((formKey.currentState?.validate())!) {
                                    MainAppCubit.get(context).updateUserData(
                                      context: context,
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'تحديث',
                                height: 36.h,
                                width:
                                    MediaQuery.of(context).size.width * 0.70),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Text(
                      'تغيير كلمه السر :',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Form(
                      key: passFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: currentPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isPassword,
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontSize: 13.sp),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    )),
                                contentPadding: const EdgeInsets.all(5),
                                labelStyle: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                                prefixIconColor:
                                    Theme.of(context).secondaryHeaderColor,
                                suffixIconColor:
                                    Theme.of(context).secondaryHeaderColor,
                                labelText: 'كلمه السر الحالية',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    changeSuffixIcon();
                                  },
                                  icon: Icon(
                                    suffix,
                                  ),
                                ),
                                prefixIcon: const Icon(CupertinoIcons.lock),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Theme.of(context).secondaryHeaderColor,
                                ))),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء ادخال البيانات';
                              } else if (value.length < 8) {
                                return 'كلمه السر غير صالحه';
                              }
                              null;
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isPassword,
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontSize: 13.sp),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    )),
                                contentPadding: const EdgeInsets.all(5),
                                labelStyle: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                                prefixIconColor:
                                    Theme.of(context).secondaryHeaderColor,
                                suffixIconColor:
                                    Theme.of(context).secondaryHeaderColor,
                                labelText: 'كلمه السر الجديده',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    changeSuffixIcon();
                                  },
                                  icon: Icon(
                                    suffix,
                                  ),
                                ),
                                prefixIcon: const Icon(CupertinoIcons.lock),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Theme.of(context).secondaryHeaderColor,
                                ))),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء ادخال البيانات';
                              } else if (value.length < 8) {
                                return 'كلمه السر قصيره';
                              }
                              null;
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isPassword,
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontSize: 13.sp),
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    )),
                                contentPadding: const EdgeInsets.all(5),
                                labelStyle: TextStyle(
                                  color: Theme.of(context).hintColor,
                                ),
                                prefixIconColor:
                                    Theme.of(context).secondaryHeaderColor,
                                suffixIconColor:
                                    Theme.of(context).secondaryHeaderColor,
                                labelText: 'تأكيد كلمه السر الجديده',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    changeSuffixIcon();
                                  },
                                  icon: Icon(
                                    suffix,
                                  ),
                                ),
                                prefixIcon: const Icon(CupertinoIcons.lock),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Theme.of(context).secondaryHeaderColor,
                                ))),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء ادخال البيانات';
                              } else if (value.length < 8) {
                                return 'كلمه السر قصيره';
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return 'كلمه السر غير متطابقه';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    ConditionalBuilder(
                      condition: state is! UpdateUserPasswordLoadingState,
                      builder: (context) => Center(
                        child: defaultButton(
                            onTap: () {
                              unFocusKeyboard(context);
                              if ((passFormKey.currentState?.validate())!) {
                                MainAppCubit.get(context).updateUserPassword(
                                  context: context,
                                  newPassword: passwordController.text,
                                  currentPassword:
                                      currentPasswordController.text,
                                  isFirstTime: false,
                                );
                              }
                            },
                            text: 'تغيير كلمه السر',
                            height: 36.h,
                            width: MediaQuery.of(context).size.width * 0.70),
                      ),
                      fallback: (context) =>
                          Center(child: myCircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: defaultButton(
                          onTap: () {
                            showDialog(context: context, builder: (context)=>MyAlertDialog(
                              onTapYes: (){
                                Navigator.pop(context);
                                MainAppCubit.get(context).deleteCustomerAccount(myUid!);
                                FirebaseAuth.instance.currentUser!.delete();
                                logOut(context);
                              },
                              isFailed: true,
                              title: 'هل انت متأكد من حذف حسابك ؟ \nسيتم حذف جميع الفواتير وتقارير الفحص ولا يمكن استرجاعهم',
                            ));
                          },
                          text: 'حذف الحساب',
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 36.h,
                          width:
                          MediaQuery.of(context).size.width * 0.70),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Future<void> logOut(context) async {
    await FirebaseAuth.instance.signOut();
    FirebaseMessaging.instance.unsubscribeFromTopic('all');
    FirebaseMessaging.instance.unsubscribeFromTopic(myUid??'');
    CacheHelper.removeData(
        key: 'uId'
    )?.then((value) {
      if (value) {
        myUid = null ;
        Navigator.pushReplacement(context, PageTransition(
            type: PageTransitionType.fade,
            child: const BlurHomeScreen(),
            duration: const Duration(milliseconds: 250)
        ),
        );
      }
    });
  }
}
