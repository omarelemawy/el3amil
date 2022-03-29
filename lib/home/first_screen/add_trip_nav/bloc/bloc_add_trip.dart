import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/state_add_trip.dart';
import 'package:mosafer1/model/get-all-main-trip-categorires.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';

import '../../../homeScreen.dart';

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

  Future createTrip (DataOfTrip dataOfTrip,typeOfTrips,context,file) async {
    emit(CreateTripLoadingStates());
    Response response;
    Map<String, dynamic> data=dataOfTrip.toJson();
    if(file != null){
      print("000");
      String fileName = file.path.split('/').last;
      data.addAll({
        "photo": await MultipartFile.fromFile(file.path, filename:fileName),
      });
    }
    FormData formData = FormData.fromMap(data);
    var dio = Dio();
    print(dataOfTrip.toJson());

    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    response = await dio.post("https://msafr.we-work.pro/api/auth/user/create-request-service",
        data: formData,options: Options(headers:mapData));

    if (response.statusCode == 200) {
      emit(CreateTripSuccessStates());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
      print(response.data);
    }
    else {
      emit(CreateTripErrorStates('msg'));
      print(response.data);
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
  void getImageFirstDesign()
  {
    emit(AddTripGetImageFirstDesignState());
  }
  void getImageSecondDesign()
  {
    emit(AddTripGetImageSecondDesignState());
  }
  void getImageThirdDesign()
  {
    emit(AddTripGetImageThirdDesignState());
  }
}



class DataOfTrip {
  int  typeOfTrips;
  int  typeOfServices;
  String  fromPlace;
  String  fromLongitude;
  String  fromLatitude;
  String  toPlace;
  String  toLongitude;
  String  toLatitude;
  String  maxDay;
  int  deliveryTo;
  String  description;
  int  onlyWomen;
  int  haveInsurance;
  int  insuranceValue;
  int  websiteService;
  int  numberOfPassengers;
  int  typeOfCar;

  DataOfTrip(
      {this.typeOfTrips,
        this.typeOfServices,
        this.fromPlace,
        this.fromLongitude,
        this.fromLatitude,
        this.toPlace,
        this.toLongitude,
        this.toLatitude,
        this.maxDay,
        this.deliveryTo,
        this.description,
        this.onlyWomen,
        this.haveInsurance,
        this.insuranceValue,
        this.websiteService,
        this.numberOfPassengers,
        this.typeOfCar});

  DataOfTrip.fromJson(Map<String, dynamic> json) {
    typeOfTrips = json['type_of_trips'];
    typeOfServices = json['type_of_services'];
    fromPlace = json['from_place'];
    fromLongitude = json['from_longitude'];
    fromLatitude = json['from_latitude'];
    toPlace = json['to_place'];
    toLongitude = json['to_longitude'];
    toLatitude = json['to_latitude'];
    maxDay = json['max_day'];
    deliveryTo = json['delivery_to'];
    description = json['description'];
    onlyWomen = json['only_women'];
    haveInsurance = json['have_insurance'];
    insuranceValue = json['insurance_value'];
    websiteService = json['website_service'];
    numberOfPassengers = json['number_of_passengers'];
    typeOfCar = json['type_of_car'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_of_trips'] = this.typeOfTrips;
    data['type_of_services'] = this.typeOfServices;
    data['from_place'] = this.fromPlace;
    data['from_longitude'] = this.fromLongitude;
    data['from_latitude'] = this.fromLatitude;
    data['to_place'] = this.toPlace;
    data['to_longitude'] = this.toLongitude;
    data['to_latitude'] = this.toLatitude;
    data['max_day'] = this.maxDay;
    data['delivery_to'] = this.deliveryTo;
    data['description'] = this.description;
    data['only_women'] = this.onlyWomen;
    data['have_insurance'] = this.haveInsurance;
    data['insurance_value'] = this.insuranceValue;
    data['website_service'] = this.websiteService;
    data['number_of_passengers'] = this.numberOfPassengers;
    data['type_of_car'] = this.typeOfCar;
    return data;
  }
}

