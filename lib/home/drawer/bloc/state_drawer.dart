import 'package:mosafer1/model/mosafer_information_model.dart';

abstract class DrawerState{}

class InitialDrawerState extends DrawerState{}
class GetLoadingMosaferInformationStates extends DrawerState{}
class GetSuccessMosaferInformationStates extends DrawerState{
  MosafrInformationModel mosafrInformationModel;
  GetSuccessMosaferInformationStates(this.mosafrInformationModel);
}
class GetErrorMosaferInformationStates extends DrawerState{
  String error;
  GetErrorMosaferInformationStates(this.error);
}
class EditProfileLoadingStates extends DrawerState{}
class EditProfileSuccessStates extends DrawerState{}
class CustomerServiceGetImageState extends DrawerState{}
class EditProfileErrorStates extends DrawerState{
  String error;
  EditProfileErrorStates(this.error);
}

