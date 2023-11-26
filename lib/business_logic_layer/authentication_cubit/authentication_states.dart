abstract class AuthStates {}

class IntStateRegister extends AuthStates {}

class PasswordChangeRegister extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class ChassisNoExistsBeforeState extends AuthStates {}

class RegisterErrorState extends AuthStates {}

class UserCreateSuccessState extends AuthStates {}

class UserCreateErrorState extends AuthStates {
  late final String error ;

  UserCreateErrorState(this.error);
}

class ResetPasswordState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String error ;

  LoginErrorState(this.error);
}

