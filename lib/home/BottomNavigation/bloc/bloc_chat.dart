
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/BottomNavigation/bloc/state_chat.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/Api.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';

class BottomNavigationBloc extends Cubit<BottomNaviagionStates> {
  BottomNavigationBloc() : super(InitialChatStates());
  static BottomNavigationBloc get(context) => BlocProvider.of(context);
  HttpOps _httpOps = HttpOps();
  String appTitle="الصفحه الرئيسيه";
   void changeNavegat(title){
    appTitle=title;
    emit(changeNavegatState());
  }
  void getAdvertisings() async {
    emit(LoadingAddState());
    GetAllRequestServicesModel response = await
    _httpOps.getData(endPoint: getAdv , auth: false);
    if(response.status){
      print(response.dataObj);
      emit(LoadedAddState(AddModel.toList(response.dataObj)));
    }
  }
}
