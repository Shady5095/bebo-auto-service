import 'package:bebo_auto_service/components/components.dart';
import 'package:bebo_auto_service/components/constans.dart';
import 'package:bebo_auto_service/presentation_layer/layout/app_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../business_logic_layer/app_cubit/app_cubit.dart';
import '../../../business_logic_layer/app_cubit/app_states.dart';

class RpmLoadingScreen extends StatelessWidget {
  const RpmLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CarCubit>(context)..getUserData(),
      child: BlocConsumer<CarCubit, CarStates>(
        listener: (context, state) async {
          if (state is GetUserDataSuccessState && myUid != null) {
            await precacheImage(
              const CachedNetworkImageProvider(
                  'https://firebasestorage.googleapis.com/v0/b/bebo-auto-service.appspot.com/o/mazda3.png?alt=media&token=4f914e91-5ad3-43e8-9b8b-ab5057018f9a'),
              context,
            ).then(
              (value) {
                navigateAndFinish(
                  context: context,
                  widget: const AppLayout(),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: displayWidth(context),
              height: displayHeight(context),
              decoration: BoxDecoration(color: defaultBackgroundColor),
              child: Lottie.asset('assets/images/rpmLoading.json'),
            ),
          );
        },
      ),
    );
  }
}
