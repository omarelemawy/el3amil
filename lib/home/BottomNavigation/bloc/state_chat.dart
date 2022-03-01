import 'package:mosafer1/model/all-request-services.dart';

abstract class BottomNaviagionStates{}

class InitialChatStates extends BottomNaviagionStates{}

class LoadingAddState extends BottomNaviagionStates{}

class LoadedAddState extends BottomNaviagionStates{
  List<AddModel> addList;
  LoadedAddState(this.addList);
}

class changeNavegatState extends BottomNaviagionStates{}
