import 'package:bebo_auto_service/business_logic_layer/my_bloc_providers/my_bloc_providers.dart';
import 'package:bebo_auto_service/presentation_layer/features/intro_and_start/start_screen/start_screen.dart';
import 'package:bebo_auto_service/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'business_logic_layer/my_bloc_providers/bloc_observer.dart';
import 'data_layer/local/cache_helper.dart';
import 'data_layer/network/dio_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kDebugMode){
    Bloc.observer = MyBlocObserver();
  }
  DioHelper.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return  myBlocProviders(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_ , child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar'), // Arabic
            ],
            locale: const Locale('ar'),
            builder: (BuildContext? context, Widget? child) {
              return MediaQuery(
                data: MediaQuery.of(context!).copyWith(textScaleFactor: 1.0, ), //set desired text scale factor here
                child: child!,
              );
            },
            theme: darkTheme(context),
            home:  child,
          );
        },
        child: const StartScreen(),
      ),
    );
  }
}


