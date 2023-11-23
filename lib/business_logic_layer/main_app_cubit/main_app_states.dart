abstract class MainAppStates {}

class IntStateCar extends MainAppStates {}

class ChangeBottomNavState extends MainAppStates {}

class ChangeAppLang extends MainAppStates {}

class GetUserDataSuccessState extends MainAppStates {}

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



