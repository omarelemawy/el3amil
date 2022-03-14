abstract class MyTripsStates{}

class InitialMyTripsStates extends MyTripsStates{}
class GetLoadingAllMyRequestServicesStates extends MyTripsStates{}
class GetSuccessAllMyRequestServicesStates extends MyTripsStates{}
class GetErrorAllMyRequestServicesStates extends MyTripsStates{
  String error;
  GetErrorAllMyRequestServicesStates(this.error);
}
class GetLoadingDeleteTripStates extends MyTripsStates{}
class GetSuccessDeleteTripStates extends MyTripsStates{}
class GetErrorDeleteTripStates extends MyTripsStates{
  String error;
  GetErrorDeleteTripStates(this.error);
}