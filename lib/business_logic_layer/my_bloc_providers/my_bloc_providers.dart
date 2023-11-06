import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication_cubit/authentication_cubit.dart';
import '../main_app_cubit/main_app_cubit.dart';
import '../spare_parts_cubit/spare_parts_cubit.dart';

Widget myBlocProviders({required Widget child}) => MultiBlocProvider(
  providers: [
    BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(),
    ),
    BlocProvider<MainAppCubit>(
      create: (BuildContext context) => MainAppCubit()..sparePartsCategoriesGridJsonGenerate(),
    ),
    BlocProvider<SparePartsCubit>(
      create: (BuildContext context) => SparePartsCubit(),
    ),
  ],
  child: child,
);