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


class SearchCategoriesCubit extends Cubit<SearchCategoriesStates>{
  SearchCategoriesCubit() : super(LoadingSearchCategoriesState());
  static SearchCategoriesCubit get(context) => BlocProvider.of(context);

  List<SearchCategoriesModel> _categoriesList = [];
  HttpOps _httpOps = HttpOps();
  void getCategories() async {
   GetAllRequestServicesModel response =  await _httpOps.postData(endPoint: tripsCategoriesUrl);
   if(response.status){
     print("Data : ${response.dataObj}");
     _categoriesList = SearchCategoriesModel.toList(response.dataObj);
     emit(LoadedSearchCategoriesState(_categoriesList));
   }
  }

}