import 'package:bebo_auto_service/business_logic_layer/app_cubit/app_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication_cubit/authentication_cubit.dart';
import '../spare_parts_cubit/spare_parts_cubit.dart';

Widget myBlocProviders({required Widget child}) => MultiBlocProvider(
  providers: [
    BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(),
    ),
    BlocProvider<CarCubit>(
      create: (BuildContext context) => CarCubit()..sparePartsCategoriesGridJsonGenerate(),
    ),
    BlocProvider<SparePartsCubit>(
      create: (BuildContext context) => SparePartsCubit(),
    ),
  ],
  child: child,
);