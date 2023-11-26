import 'package:bebo_auto_service/business_logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:bebo_auto_service/business_logic_layer/authentication_cubit/authentication_states.dart';
import 'package:bebo_auto_service/business_logic_layer/main_app_cubit/main_app_cubit.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/data_layer/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePasswordForFirstTimeScreen extends StatefulWidget {
  final String chassisNo;

  const CreatePasswordForFirstTimeScreen({
    super.key,
    required this.chassisNo,
  });

  @override
  State<CreatePasswordForFirstTimeScreen> createState() =>
      _CreatePasswordForFirstTimeScreenState();
}

class _CreatePasswordForFirstTimeScreenState
    extends State<CreatePasswordForFirstTimeScreen> {
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 27.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'تم قبول سيارتك',
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ' برجاء انشاء كلمه سر لحسابك لأكمال عمليه التسجيل',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white54,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: passController,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 14.sp),
                    obscureText: isShowPassword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5),
                      labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      labelText: 'كلمه السر',
                      suffixIcon: IconButton(
                        onPressed: () {
                          isShowPassword = !isShowPassword;
                          setState(() {});
                        },
                        icon: Icon(
                          isShowPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
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
                      } else if (value.length < 8) {
                        return 'كلمه السر قصيره';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                if(state is LoginLoadingState)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: LinearProgressIndicator(
                      color: defaultColor,
                    ),
                  ),
                defaultButton(
                  onTap: () {
                    unFocusKeyboard(context);
                    if (formKey.currentState!.validate()) {
                      String newPass = passController.text ;
                      AuthCubit.get(context).userLogin(email: widget.chassisNo, password: widget.chassisNo, context: context).then((value) {
                        CacheHelper.removeData(key: 'chassisNo');
                        MainAppCubit.get(context).updateUserPassword(
                          newPassword: newPass,
                          currentPassword: widget.chassisNo,
                          email: '${widget.chassisNo}@gmail.com',
                          context: context,
                          isFirstTime: true,
                        );
                      });
                    }
                  },
                  text: 'اكمال التسجيل',
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
}
