import 'package:mosafer1/model/all-request-services.dart';

abstract class FatorahState{}

class InitialFatorahState extends FatorahState{}
class LoadingFatorahState extends FatorahState{}
class LoadedFatorahState extends FatorahState{
  FatorahModel fatorahModel;
  LoadedFatorahState(this.fatorahModel);
  }
class GetLoadingFatorahResponseStates extends FatorahState{}
class GetSuccessFatorahResponseStates extends FatorahState{}
class GetErrorFatorahResponseStates extends FatorahState{
  String error;
  GetErrorFatorahResponseStates(this.error);
}
