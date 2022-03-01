import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/state_add_trip.dart';
import 'package:mosafer1/model/get-all-main-trip-categorires.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';

class AddTripBloc extends Cubit<AddTripStates>{
  AddTripBloc() : super(InitialAddTripStates());
  static AddTripBloc get(context) => BlocProvider.of(context);
  bool isBottomSheet = false;
  bool isChecked = false;
  List<Data> AllMainCat;
  List<Widget> itemsOfInformField=[];
  List<Widget> itemsOfInformFieldLocation=[];
  bool valueSwitch = false;

  Future<GetAllMainTripCategorires> getAllMainTripCategorires () async {
    emit(GetLoadingGetAllMainTripCategoriresStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/user/get-all-main-request-categorires");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    final response = await http.post(Api,headers: mapData);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      emit(GetSuccessGetAllMainTripCategoriresStates());
      print(response.body);
      return GetAllMainTripCategorires.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      print(response.body);
      emit(GetErrorGetAllMainTripCategoriresStates(json['msg']));
    }

  }

  Future createTrip (DataOfTrip dataOfTrip) async {
    emit(CreateTripLoadingStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/create-trip");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    Map<String, String> mapData1 = {
      "type_of_trips": "2",
      "only_women": "0",
      "type_of_services": "5",
      "from_place": "tanta",
      "from_longitude": "12.3651",
      "from_latitude": "30.25315",
      "description": "test disciption",
      "to_place": "alex",
      "to_longitude": "50.635154",
      "to_latitude": "45.353",
      "start_date": "2021-09-18",
      "end_date": "2021-09-30",
      "trip_ways":"["+"'{"+"place"+":"+"kom hammada","time": "2021-09-18"+"}','{"+"place"+": "+"kom hammada","time": "2021-09-18"+"}',]",
      "trip_days":'[1,3,5]'
    };

    String encodedData = json.encode(dataOfTrip.toJson());
    print(encodedData);
    final response = await http.post(Api,headers: mapData,body:mapData1);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      emit(CreateTripSuccessStates());
      print(json);
    } else {
      final json = jsonDecode(response.body);
      emit(CreateTripErrorStates(json['msg']));
    }

  }
  changeSwitchValue(value)
  {
    valueSwitch=value;
    emit(ChangeSwitchValueState());
  }
  void getAllMainCat()
  {
    getAllMainTripCategorires().then((value) {
      AllMainCat  = value.data;
    });
  }
  void changeBottomSheetState(value)
  {
    isBottomSheet=value;
    emit(ChangeBottomSheetState());
  }
  void changeCheckBoxState()
  {
    emit(ChangeCheckBoxState());
  }
  void changeState()
  {
    emit(ChangeState());
  }
  void addItem(Widget widget)
  {
    itemsOfInformField.add(widget);
    emit(AddIteOfInformState());
  }
  void addItemLoc(Widget widget)
  {
    itemsOfInformFieldLocation.add(widget);
    emit(AddIteOfInformLocState());
  }
}



class DataOfTrip {
  String onlyWomen;
  String typeOfTrips;
  String typeOfServices;
  String fromPlace;
  String fromLongitude;
  String fromLatitude;
  String description;
  String toPlace;
  String toLongitude;
  String toLatitude;
  String startDate;
  String endDate;
/*  List<TripWays> tripWays;
  List<int> tripDays;*/

  DataOfTrip(
      {this.onlyWomen,
        this.typeOfTrips,
        this.typeOfServices,
        this.fromPlace,
        this.fromLongitude,
        this.fromLatitude,
        this.description,
        this.toPlace,
        this.toLongitude,
        this.toLatitude,
        this.startDate,
        this.endDate,
        /*this.tripWays,
        this.tripDays*/});

  DataOfTrip.fromJson(Map<String, dynamic> json) {
    onlyWomen = json['only_women'];
    typeOfTrips = json['type_of_trips'];
    typeOfServices = json['type_of_services'];
    fromPlace = json['from_place'];
    fromLongitude = json['from_longitude'];
    fromLatitude = json['from_latitude'];
    description = json['description'];
    toPlace = json['to_place'];
    toLongitude = json['to_longitude'];
    toLatitude = json['to_latitude'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    /*if (json['trip_ways'] != null) {
      tripWays = new List<TripWays>();
      json['trip_ways'].forEach((v) {
        tripWays.add(new TripWays.fromJson(v));
      });
    }
    tripDays = json['trip_days'].cast<int>();*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['only_women'] = this.onlyWomen;
    data['type_of_trips'] = this.typeOfTrips;
    data['type_of_services'] = this.typeOfServices;
    data['from_place'] = this.fromPlace;
    data['from_longitude'] = this.fromLongitude;
    data['from_latitude'] = this.fromLatitude;
    data['description'] = this.description;
    data['to_place'] = this.toPlace;
    data['to_longitude'] = this.toLongitude;
    data['to_latitude'] = this.toLatitude;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
   /* if (this.tripWays != null) {
      data['trip_ways'] = this.tripWays.map((v) => v.toJson()).toList();
    }
    data['trip_days'] = this.tripDays;*/
    return data;
  }
}
/*
class TripWays {
  String place;
  String time;

  TripWays({this.place, this.time});

  TripWays.fromJson(Map<String, dynamic> json) {
    place = json['place'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place'] = this.place;
    data['time'] = this.time;
    return data;
  }
}*/
