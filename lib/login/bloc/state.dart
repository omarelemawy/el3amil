abstract class LoginStates{}

class InitialLoginStates extends LoginStates{}

class LoginSuccessState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginErrorState extends LoginStates{
  String error;
  LoginErrorState(this.error);
}
class RegisterGetImageState extends LoginStates{}

class RegisterGetUserImageState extends LoginStates{}
class RegisterGetCar1ImageState extends LoginStates{}
class RegisterGetCar2ImageState extends LoginStates{}
class RegisterGetCar3ImageState extends LoginStates{}
class RegisterGetCar4ImageState extends LoginStates{}
class RegisterGetCar5ImageState extends LoginStates{}

class SendCodeLoadingState extends LoginStates{}

class SendCodeSuccessState extends LoginStates{}

class ChangeSwitchValueState extends LoginStates{}

class RegisterSuccessState extends LoginStates{}

class RegisterLoadingState extends LoginStates{}
class ChangeGenderRegisterState extends LoginStates{}

class SendCodeErrorState extends LoginStates{
  String error;
  SendCodeErrorState(this.error);
}

class RegisterErrorState extends LoginStates{
  String error;
  RegisterErrorState(this.error);
}