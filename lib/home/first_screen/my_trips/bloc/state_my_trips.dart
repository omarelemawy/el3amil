abstract class MyTripsStates{}

class InitialMyTripsStates extends MyTripsStates{}
class GetLoadingAllMyRequestServicesStates extends MyTripsStates{}
class GetSuccessAllMyRequestServicesStates extends MyTripsStates{}
class GetErrorAllMyRequestServicesStates extends MyTripsStates{
  String error;
  GetErrorAllMyRequestServicesStates(this.error);
}