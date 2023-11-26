import 'package:bebo_auto_service/data_layer/models/user_model.dart';

abstract class MainAppStates {}

class IntStateCar extends MainAppStates {}

class ChangeBottomNavState extends MainAppStates {}

class ChangeAppLang extends MainAppStates {}

class GetUserDataSuccessState extends MainAppStates {
  final UserModel userModel ;

  GetUserDataSuccessState(this.userModel);
}

class GetUserDataErrorState extends MainAppStates {}

class UpdateUserDataSuccessState extends MainAppStates {}

class UpdateUserDataLoadingState extends MainAppStates {}

class UpdateUserPasswordLoadingState extends MainAppStates {}

class UpdateUserDataErrorState extends MainAppStates {}

class SendComplaintLoadingState extends MainAppStates {}

class SendComplaintSuccessState extends MainAppStates {}

class SendComplaintErrorState extends MainAppStates {}

class ChassisNoCheckState extends MainAppStates {
  final bool isChassisNoExist ;

  ChassisNoCheckState(this.isChassisNoExist);
}



