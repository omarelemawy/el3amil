import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/Fatorah/bloc/state.dart';
import 'package:mosafer1/home/first_screen/Search/bloc/state.dart';
import 'package:mosafer1/login/bloc/state.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/Api.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';


class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(InitialSearchState());
  static SearchCubit get(context) => BlocProvider.of(context);

  HttpOps _httpOps = HttpOps();
  void doSearch({int tripType,String from,String to}) async {
    var data = {
      "type_of_trips": tripType,
      "from_place": from,
      "to_place": to
    };
    emit(LoadingSearchState());
    GetAllRequestServicesModel response = await _httpOps.postData(endPoint: searchUrl , mapData: data , auth: true);
    if(response.status){
      emit(LoadedSearchState(RequestServices.toList(response.dataObj)));
    }
  }

}