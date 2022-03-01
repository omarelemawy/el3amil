import 'package:mosafer1/model/all-request-services.dart';

abstract class FatorahState{}

class InitialFatorahState extends FatorahState{}
class LoadingFatorahState extends FatorahState{}
class LoadedFatorahState extends FatorahState{
  FatorahModel fatorahModel;
  int totalFatorahPrice = 0;
  LoadedFatorahState(this.fatorahModel){
    fatorahModel.fatorahItems.forEach((element) {
      totalFatorahPrice += int.parse(element.value);
    });
  }
}
