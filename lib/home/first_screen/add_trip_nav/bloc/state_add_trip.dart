abstract class AddTripStates{}

class InitialAddTripStates extends AddTripStates{}
class GetLoadingGetAllMainTripCategoriresStates extends AddTripStates{}
class GetSuccessGetAllMainTripCategoriresStates extends AddTripStates{}
class ChangeBottomSheetState extends AddTripStates{}
class ChangeCheckBoxState extends AddTripStates{}
class ChangeState extends AddTripStates{}
class AddIteOfInformLocState extends AddTripStates{}
class AddIteOfInformState extends AddTripStates{}
class ChangeSwitchValueState extends AddTripStates{}
class GetErrorGetAllMainTripCategoriresStates extends AddTripStates{
  String error;
  GetErrorGetAllMainTripCategoriresStates(this.error);
}
class CreateTripLoadingStates extends AddTripStates{}
class CreateTripSuccessStates extends AddTripStates{}
class CreateTripErrorStates extends AddTripStates{
  String error;
  CreateTripErrorStates(this.error);
}