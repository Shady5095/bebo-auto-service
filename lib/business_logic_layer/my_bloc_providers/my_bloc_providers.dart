import 'package:bebo_auto_service/business_logic_layer/chat_cubit/chat_cubit.dart';
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
    BlocProvider<ChatCubit>(
      create: (BuildContext context) => ChatCubit(),
    ),
  ],
  child: child,
);