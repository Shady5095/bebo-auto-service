import 'package:bebo_auto_service/business_logic_layer/my_bloc_providers/my_bloc_providers.dart';
import 'package:bebo_auto_service/presentation_layer/screens/start_screen/start_screen.dart';
import 'package:bebo_auto_service/styles/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'business_logic_layer/main_app_cubit/main_app_cubit.dart';
import 'business_logic_layer/main_app_cubit/main_app_states.dart';
import 'components/bloc_observer.dart';
import 'data_layer/local/cache_helper.dart';
import 'data_layer/network/dio_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return  myBlocProviders(
      child: BlocConsumer<MainAppCubit,MainAppStates>(
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
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ar'), // Arabic
                ],
                locale: const Locale('ar'),
                builder: DevicePreview.appBuilder,
                theme: darkTheme(context),
                home:  child,
              );
            },
            child: const StartScreen(),
          );
        },
      ),
    );
  }
}


