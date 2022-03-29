import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/model/mosafer_information_model.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:http/http.dart'as http;

class DrawerCubit extends Cubit<DrawerState>{
  DrawerCubit() : super(InitialDrawerState());
  static DrawerCubit get(context) => BlocProvider.of(context);
  List<FreeServiceModel> allFreeService=[];
  MosafrInformationModel mosafrInformationModel;

  Future<MosafrInformationModel> getUsernformation () async {
    emit(GetLoadingMosaferInformationStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/user/get-user-info");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    final response = await http.post(Api,headers: mapData);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      emit(GetSuccessMosaferInformationStates(MosafrInformationModel.fromJson(json)));
      print(response.body);
      return MosafrInformationModel.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      print(response.body);
      emit(GetErrorMosaferInformationStates(json['msg']));
    }
  }

  void getgetUserInform()
  {
    getUsernformation().then((value) {
      mosafrInformationModel  = value;
    });
  }
  void getImage()
  {
    emit(CustomerServiceGetImageState());
  }
  Future<MosafrInformationModel> getMosafernformation ({int id}) async {
    print(id);
    emit(GetLoadingMosaferInformationStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/user/masafr-info");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
      "Content-Type": "application/json; charset=UTF-8",
    };
    final response = await http.post(Api,headers: mapData,body: jsonEncode({
      "id"  : id
    }));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      mosafrInformationModel  =  MosafrInformationModel.fromJson(json);
      emit(GetSuccessMosaferInformationStates(MosafrInformationModel.fromJson(json)));
      print(response.body);
      return MosafrInformationModel.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      print(response.body);
      emit(GetErrorMosaferInformationStates(json['msg']));
    }
  }

  void getgetMosaferInform({int id})
  {
    getMosafernformation(id: id).then((value) {
      print("Val : ${value.data.name}");
      mosafrInformationModel  = value;
    });
  }

  Future editProfile (context,name,national_id_number,gender,email,password) async {
    emit(EditProfileLoadingStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/update-masafr-info");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    Map<String, String> mapData1 = {
      "name": name,
      "national_id_number": national_id_number,
      "gender": "0",
      "email": email,
      "password": password,
    };

    final response = await http.post(Api,headers: mapData,body:mapData1);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      emit(EditProfileSuccessStates());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()
      ), (route) => false);
      print(json);
    } else {
      final json = jsonDecode(response.body);
      emit(EditProfileErrorStates(json['msg']));
    }

  }

  Future<GetAllRequestServicesModel> getAllFreeS () async {
    emit(GetLoadingFreeServiceModelStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/user/all-free-services");
    Map<String, String> mapData = {
      'authToken':CacheHelper.getData(key: "token")
    };
    final response = await http.post(Api,headers: mapData);
    if (response.statusCode == 200) {
      print(response.body);
      final json = jsonDecode(response.body);
      emit(GetSuccessFreeServiceModelStates());
      return GetAllRequestServicesModel.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      emit(GetErrorFreeServiceModelStates(json['msg']));
    }

  }
  void getAllFreeService()
  {
    getAllFreeS().then((value) {
      allFreeService  = FreeServiceModel.toList(value.dataObj["data"]);
    });
  }
}