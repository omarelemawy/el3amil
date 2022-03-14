import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/Fatorah/bloc/state.dart';
import 'package:mosafer1/login/bloc/state.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/Api.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';


class FatorahCubit extends Cubit<FatorahState>{
  FatorahCubit() : super(InitialFatorahState());
  static FatorahCubit get(context) => BlocProvider.of(context);

  HttpOps _httpOps = HttpOps();

  void getFatorah(int id) async {
      GetAllRequestServicesModel response = await _httpOps.postData(endPoint: getFatorahUrl,auth: true,
          mapData:{ "id" :  id});
      if(response.status){
        emit(LoadedFatorahState(FatorahModel.fromJson(response.dataObj[0])));
      }
  }

  Future<FatorahReqModel> getFatorahResponse (fatoorah_list_id,accept) async {
    emit(GetLoadingFatorahResponseStates());
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    Map<String, String> mapData1 = {
      "fatoorah_list_id": fatoorah_list_id.toString(),
      "message_id": "1",
      "payment_method":"1",
      "accept": accept,
    };
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/user/resopnse-to-fatoorah");
    final response = await http.post(Api,headers: mapData,body: mapData1);
    if (response.statusCode == 200) {
      print(response.body);
      final json = jsonDecode(response.body);
      emit(GetSuccessFatorahResponseStates());
      return FatorahReqModel.fromJson(GetAllRequestServicesModel.fromJson(json).dataObj);
    } else {
      final json = jsonDecode(response.body);
      emit(GetErrorFatorahResponseStates(json['msg']));
    }

  }
}