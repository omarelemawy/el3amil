import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/first_screen/home_nav/cubit/home_state.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:http/http.dart'as http;

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(InitialHomeStates());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<RequestServices> allRequestsSe;
  Future<GetAllRequestServicesModel> getAllRequestSer () async {
      emit(GetLoadingAllRequestServicesStates());
      var Api = Uri.parse("https://msafr.we-work.pro/api/user/all-trips");
      final response = await http.post(Api);
      if (response.statusCode == 200) {
        print(response.body);
        final json = jsonDecode(response.body);
        emit(GetSuccessAllRequestServicesStates());
        return GetAllRequestServicesModel.fromJson(json);
      } else {
        final json = jsonDecode(response.body);
        emit(GetErrorAllRequestServicesStates(json['msg']));
      }

  }
  void getAllServices()
  {
    getAllRequestSer().then((value) {
      allRequestsSe  = RequestServices.toList(value.dataObj);
    });
  }
}