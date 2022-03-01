abstract class HomeStates{}

class InitialHomeStates extends HomeStates{}

class GetLoadingAllRequestServicesStates extends HomeStates{}
class GetSuccessAllRequestServicesStates extends HomeStates{}
class GetErrorAllRequestServicesStates extends HomeStates{
  String error;
  GetErrorAllRequestServicesStates(this.error);
}