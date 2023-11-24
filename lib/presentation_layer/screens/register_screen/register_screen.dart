import 'package:bebo_auto_service/business_logic_layer/authentication_cubit/authentication_cubit.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/widgets/dropdown_buttom.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic_layer/authentication_cubit/authentication_states.dart';
import '../../../components/components.dart';
import '../../widgets/my_alert_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
var firstNameController = TextEditingController();
var lastNameController = TextEditingController();
var phoneController = TextEditingController();
var kiloMeterCount = TextEditingController();
var engineNo = TextEditingController();
var chassisNo = TextEditingController();
var plateNo = TextEditingController();
var formKey = GlobalKey<FormState>();
List<String> carModels = [
  'Mazda 3',
  'Mazda 2',
  'Mazda 6',
  'Mazda Cx3',
  'Mazda Cx5',
  'مازدا نوع اخر',
];
String? carModelSelected ;
String? carYearSelected ;
List<String> carYears = [
  '2026',
  '2025',
  '2024',
  '2023',
  '2022',
  '2021',
  '2020',
  '2019',
  '2018',
  '2017',
  '2016',
  '2015',
  '2014',
  '2013',
  '2012',
  '2011',
  '2010',
  '2009',
  '2008',
  '2007',
  '2006',
  '2005',
];
String? carColorSelected ;
List<String> carColors = [
  'أحمر',
  'أسود',
  'أبيض',
  'رمادي',
  'فضي',
  'فراني',
  'أزرق',
  'بني',
  'ذهبي',
];
String? bodyTypeSelected ;
List<String> transmission = [
  'أوتوماتيك',
  'مانويل',
];
String? transmissionSelected ;
List<String> bodyType = [
  'سيدان',
  'هاتشباك',
];
List<String> plateLetters = [
  'أ',
  'ب',
  'ت',
  'ث',
  'ج',
  'ح',
  'خ',
  'د',
  'ذ',
  'ر',
  'ز',
  'س',
  'ش',
  'ص',
  'ض',
  'ط',
  'ظ',
  'ع',
  'غ',
  'ف',
  'ق',
  'ك',
  'ل',
  'م',
  'ن',
  'ه',
  'و',
  'ي',
];
String? firstLetter ;
String? secondLetter ;
String? thirdLetter  ;


class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit,AuthStates>(
        listener: (context, state){
          if(state is ChassisNoExistsBeforeState){
            showDialog(context: context, builder: (context)=>const MyAlertDialog(
              isFailed: true,
              title: 'رقم الشاسيه مسجل من قبل',
              actions: [],
            ));
          }
          if(state is RegisterSuccessState){
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => MyAlertDialog(
                isFailed: false,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'تم التسجيل بنجاح ... برجاء الانتظار قليلا لحين تفعيل الحساب من قبل المركز وبعد التفعيل سنرسل لك اشعار لتكمل التسجيل',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp
                      ),
                    ),
                  ],
                ),
                actions: const [],
              ),
            );
          }
        },
        builder: (context, state){
          var cubit = AuthCubit.get(context);
          return Scaffold(
            appBar: defaultAppbar(context: context),
            body : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Center(
                          child: Image(
                            width: 160,
                            height: 160,
                            image: AssetImage(
                              'assets/images/logo.png'
                            ),
                          ),
                        ),
                        const Text(
                            'البيانات الشخصية',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: firstNameController,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(14),
                                ],
                                style: TextStyle(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    fontSize: 13.sp
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 13.sp,
                                  ),
                                  prefixIconColor: Theme.of(context).secondaryHeaderColor,
                                  labelText: 'الاسم الاول',
                                  prefixIcon: const Icon(
                                      Icons.person
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value){
                                  if (value==null || value.isEmpty){
                                    return 'برجاء ادخال البيانات';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: lastNameController,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(14),
                                ],
                                style: TextStyle(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    fontSize: 13.sp
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).hintColor,
                                  ),
                                  prefixIconColor: Theme.of(context).secondaryHeaderColor,
                                  labelText: 'الاسم الاخير',
                                  prefixIcon: const Icon(
                                      Icons.person
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value){
                                  if (value==null || value.isEmpty){
                                    return 'برجاء ادخال البيانات';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11),
                          ],
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 13.sp
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(5),
                            labelStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                            ),
                            prefixIconColor: Theme.of(context).secondaryHeaderColor,
                            suffixIconColor: Theme.of(context).secondaryHeaderColor,
                            labelText: 'رقم الهاتف',
                            prefixIcon: const Icon(
                                Icons.phone
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),

                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            if (value==null || value.isEmpty){
                              return 'برجاء ادخال البيانات';
                            }
                            else if(value.length < 11) {
                              return 'رقم الهاتف غير صالح';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        const Text(
                          'بيانات السيارة',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownButton(
                                dropdownItems: carModels,
                                hint: 'الموديل',
                                value: carModelSelected,
                                onChanged: (String? carModel){
                                  carModelSelected = carModel ;
                                  setState(() {

                                  });
                                },
                                buttonWidth: double.infinity,
                                buttonHeight: 47,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomDropdownButton(
                                dropdownItems: carYears,
                                hint: 'السنة',
                                value: carYearSelected,
                                onChanged: (String? carYear){
                                  carYearSelected = carYear ;
                                  setState(() {

                                  });
                                },
                                buttonWidth: double.infinity,
                                buttonHeight: 47,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownButton(
                                dropdownItems: carColors,
                                hint: 'اللون',
                                value: carColorSelected,
                                onChanged: (String? selected){
                                  carColorSelected = selected ;
                                  setState(() {

                                  });
                                },
                                buttonWidth: double.infinity,
                                buttonHeight: 47,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomDropdownButton(
                                dropdownItems: bodyType,
                                hint: 'نوع الهيكل',
                                value: bodyTypeSelected,
                                onChanged: (String? selected){
                                  bodyTypeSelected = selected ;
                                  setState(() {

                                  });
                                },
                                buttonWidth: double.infinity,
                                buttonHeight: 47,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownButton(
                                dropdownItems: transmission,
                                hint: 'ناقل الحركة',
                                value: transmissionSelected,
                                onChanged: (String? selected){
                                  transmissionSelected= selected ;
                                  setState(() {

                                  });
                                },
                                buttonWidth: double.infinity,
                                buttonHeight: 47,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: kiloMeterCount,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                style: TextStyle(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    fontSize: 13.sp
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 13),
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12.sp,
                                  ),
                                  prefixIconColor: Theme.of(context).secondaryHeaderColor,
                                  labelText: 'عداد الكيلومتر',

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value){
                                  if (value==null || value.isEmpty){
                                    return 'برجاء ادخال البيانات';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: chassisNo,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    fontSize: 13.sp
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 13),
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12.sp
                                  ),
                                  prefixIconColor: Theme.of(context).secondaryHeaderColor,
                                  suffixIconColor: Theme.of(context).secondaryHeaderColor,
                                  labelText: 'رقم الشاسيه (من الرخصة)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value){
                                  if (value==null || value.isEmpty){
                                    return 'برجاء ادخال البيانات';
                                  }
                                  else if(value.length != 8) {
                                    return 'رقم شاسيه غير صالح';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: engineNo,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    fontSize: 13.sp
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 13),
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 12.sp,
                                  ),
                                  prefixIconColor: Theme.of(context).secondaryHeaderColor,
                                  labelText: 'رقم الماتور (من الرخصة)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value){
                                  if (value==null || value.isEmpty){
                                    return 'برجاء ادخال البيانات';
                                  }
                                  else if(value.length != 6) {
                                    return 'رقم ماتور غير صالح';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'رقم اللوحه',
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 50).w,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 35,
                                decoration: const BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(15) , topLeft: Radius.circular(15)),

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'مصر',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Text(
                                        'Egypt',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: CustomDropdownButton(
                                                  dropdownItems: plateLetters,
                                                  hint: '',
                                                  iconSize: 0,
                                                  value: firstLetter,
                                                  onChanged: (String? selected){
                                                    firstLetter = selected ;
                                                    setState(() {

                                                    });
                                                  },
                                                  buttonWidth: double.infinity,
                                                  buttonHeight: 47,
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomDropdownButton(
                                                  dropdownItems: plateLetters,
                                                  hint: '',
                                                  iconSize: 0,
                                                  value: secondLetter,
                                                  onChanged: (String? selected){
                                                    secondLetter = selected ;
                                                    setState(() {

                                                    });
                                                  },
                                                  buttonWidth: double.infinity,
                                                  buttonHeight: 47,
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomDropdownButton(
                                                  dropdownItems: plateLetters,
                                                  hint: '',
                                                  iconSize: 0,
                                                  value: thirdLetter,
                                                  onChanged: (String? selected){
                                                    thirdLetter = selected! ;
                                                    setState(() {

                                                    });
                                                  },
                                                  buttonWidth: double.infinity,
                                                  buttonHeight: 47,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: TextFormField(
                                              controller: plateNo,
                                              keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(4),
                                                ],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.sp
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 7),
                                                hintStyle: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                                hintText: 'الرقم',
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15),

                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: defaultBackgroundColor,
                                                    ),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),

                                              ),
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              validator: (value){
                                                if (value==null || value.isEmpty){
                                                  return 'برجاء ادخال البيانات';
                                                }
                                                else if (value == '-' || value == '.'){
                                                  return 'الرقم غير صالح';
                                                }
                                                return null;
                                              },
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
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.pin,
                              color: defaultColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'سيتم مراجعة بياناتك من قبل المسئول',
                                    style: TextStyle(
                                      color: Colors.white54
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.pin,
                              color: defaultColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'برجاء العلم انه لن يتم قبول حسابك اذا انت ليس عميل بمركز بيبو',
                                    style: TextStyle(
                                      color: Colors.white54
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.pin,
                              color: defaultColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'برجاء التأكد من رقم الشاسيه جيدا لانه لن يتم قبول السياره اذا كان الرقم غير صحيح ',
                                    style: TextStyle(
                                      color: Colors.white54
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        ConditionalBuilder(
                          condition: state is !RegisterLoadingState,
                          builder: (context) => defaultButton(
                            onTap: (){
                              if(formKey.currentState!.validate()){
                                if(carModelSelected == null
                                    || carYearSelected == null
                                    || carColorSelected == null
                                    || bodyTypeSelected == null
                                    || transmissionSelected == null
                                ){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('برجاء ادخال جميع البيانات '),
                                    backgroundColor: Colors.red,

                                  ));
                                }
                                else if(firstLetter == null){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('برجاء ادخال اول حرف من نمر السياره'),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                                else {
                                  cubit.userRegister(
                                      email: '${chassisNo.text}@gmail.com',
                                      password: chassisNo.text,
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      carModel: carModelSelected!,
                                      year: carYearSelected!.toInt(),
                                      transmission: transmissionSelected!,
                                      color: carColorSelected!,
                                      bodyType: bodyTypeSelected!,
                                      km: kiloMeterCount.text.toInt(),
                                      chassisNo: chassisNo.text,
                                      engineNo: engineNo.text,
                                      plate: '$firstLetter $secondLetter ${thirdLetter??''}  ${plateNo.text}',
                                      phone: phoneController.text,
                                      context: context
                                  ).then((value) {

                                  });
                                }
                              }
                            },
                            text: 'تسجيل',
                            height: 40.h,
                            textColor: Theme.of(context).secondaryHeaderColor,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: defaultColor
                            ),
                          ),
                          fallback: (context) => Center(child: myCircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                      ],
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
