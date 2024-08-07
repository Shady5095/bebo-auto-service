import 'dart:io';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../business_logic_layer/authentication_cubit/authentication_cubit.dart';
import '../../../../../business_logic_layer/authentication_cubit/authentication_states.dart';
import '../../../../../components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final passController = TextEditingController();
final chassisNoController = TextEditingController();
final formKey = GlobalKey<FormState>();
final focusNode = FocusNode();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            if (Platform.isAndroid) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('هذا الحساب غير متوفر او لم يتم قبوله من قبل المسئول'),
                backgroundColor: Colors.red,
              ));
            }
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            appBar: defaultAppbar(context: context),
            body: GestureDetector(
              onTap: () {
                unFocusKeyboard(context);
              },
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          Center(
                            child: Image(
                              width: 130.w,
                              height: 130.h,
                              image: const AssetImage('assets/images/logo.png'),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          TextFormField(
                            controller: chassisNoController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9۰-۹]')),
                            ],
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontSize: 13.sp),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(5),
                              labelStyle: TextStyle(
                                  color: Colors.white54, fontSize: 13.sp),
                              labelText:'رقم الشاسيه (من الرخصه)' ,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'برجاء ادخال البيانات';
                              } else if (value.length < 4) {
                                return 'رقم الشاسيه يجب ان لا يقل عن 4 ارقام';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          GestureDetector(
                            onTap: () => focusNode.unfocus(),
                            child: TextFormField(
                              controller: passController,
                              focusNode: focusNode,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontSize: 13.sp),
                              obscureText: cubit.isPassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5),
                                labelStyle: TextStyle(
                                    color: Colors.white54, fontSize: 13.sp),
                                labelText: 'كلمه السر',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changeSuffixIcon();
                                  },
                                  icon: Icon(
                                    cubit.suffix,
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'برجاء ادخال البيانات';
                                } else if (value.length < 6) {
                                  return 'كلمه السر غير صالحة';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defaultButton(
                              onTap: () {
                                unFocusKeyboard(context);
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: chassisNoController.text,
                                      password: passController.text.trim(),
                                      context: context);
                                }
                              },
                              height: 45.h,
                              text: 'تسجيل الدخول',
                              textColor: Theme.of(context).secondaryHeaderColor,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: defaultColor),
                            ),
                            fallback: (context) =>
                                Center(child: myCircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ليس لديك حساب ؟',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    fontSize: 14.sp),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateToAnimated(
                                      context: context,
                                      widget: const RegisterScreen(),
                                      animation:
                                          PageTransitionType.leftToRight);
                                },
                                child: Text(
                                  'تسجيل',
                                  style: TextStyle(
                                      fontSize: 13.sp, color: defaultColor),
                                ),
                              ),
                            ],
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
