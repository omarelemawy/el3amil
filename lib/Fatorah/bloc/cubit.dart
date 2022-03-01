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
      GetAllRequestServicesModel response = await _httpOps.postData(endPoint: getFatorahUrl,auth: true, mapData:{ "id" :  id});
      if(response.status){
        emit(LoadedFatorahState(FatorahModel.fromMap(response.dataObj[0])));
      }
  }
}