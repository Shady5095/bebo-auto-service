import 'package:bebo_auto_service/business_logic_layer/main_app_cubit/main_app_cubit.dart';
import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/widgets/my_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../business_logic_layer/main_app_cubit/main_app_states.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  var complaintController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context: context,
        title: 'أرسال شكوي للمسؤل',
      ),
      body: BlocConsumer<MainAppCubit, MainAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/sadCar.png',
                    color: defaultColor,
                    height: 100.h,
                    width: 100.h,
                  ),
                  Center(
                    child: Text(
                      'نأسف لك عن اي مشكله حدثت منا وحرصا من جانب مسئول المركز لعدم حدوث المشكله مره اخري برجاء ارسال المشكله... ',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: complaintController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (String newPrice) {},
                      maxLines: 5,
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 15.sp),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 10),
                        labelStyle: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 16.sp),
                        prefixIconColor: Theme.of(context).secondaryHeaderColor,
                        suffixIconColor: Theme.of(context).secondaryHeaderColor,
                        labelText: 'الشكوي',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء ادخال الشكوي';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  if(state is !SendComplaintLoadingState)
                  defaultButton(
                    onTap: () {
                      unFocusKeyboard(context);
                      if (formKey.currentState!.validate()) {
                        MainAppCubit.get(context)
                            .sendComplaint(
                          complaint: complaintController.text
                        )
                            .then((value) {
                              Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => const MyAlertDialog(
                              actions: [],
                              isFailed: false,
                              title: 'تم أرسال شكوتك بنجاح',
                            ),
                          );
                        });
                      }
                    },
                    text: 'أرسال',
                  ),
                  if(state is SendComplaintLoadingState)
                    Center(child: myCircularProgressIndicator(size: 30))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
