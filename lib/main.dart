import 'package:bebo_auto_service/business_logic_layer/app_cubit/app_cubit.dart';
import 'package:bebo_auto_service/business_logic_layer/app_cubit/app_states.dart';
import 'package:bebo_auto_service/presentation_layer/screens/register_screen/register_screen.dart';
import 'package:bebo_auto_service/styles/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/app_locale.dart';
import 'components/bloc_observer.dart';
import 'data_layer/local/cache_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool? isArabic = CacheHelper.getBool(key: 'isArabic');
  runApp(MyApp(isArabic: isArabic,));
}

class MyApp extends StatelessWidget {
  final bool? isArabic ;
  const MyApp({super.key,required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context) => CarCubit()..categoriesGridJson()..appLang(fromShared: isArabic) ,
      child: BlocConsumer<CarCubit,CarStates>(
        listener: (context,state){},
        builder: (context,state){
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
            builder: (_ , child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                useInheritedMediaQuery: true,
                localizationsDelegates: const [
                  AppLocale.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('ar'), // Arabic
                ],
                locale: appLocale(context),
                builder: DevicePreview.appBuilder,
                theme: darkTheme(context,appLocale(context)),
                home:  child,
              );
            },
            child: const RegisterScreen(),
          );
        },
      ),
    );
  }
  Locale appLocale(context){
    if(CarCubit.get(context).isArabic == null || CarCubit.get(context).isArabic == true){
      return const Locale('ar');
    }
    return const Locale('en');
  }
}


