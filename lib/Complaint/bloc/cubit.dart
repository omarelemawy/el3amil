import 'package:bloc/bloc.dart';
import 'package:mosafer1/Complaint/bloc/state.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/Api.dart';
import 'package:mosafer1/shared/netWork/Firebase/Chat.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';

class ComplainCubit extends Cubit<ComplaintListState> {
  ComplainCubit() : super(ComplaintListLoadingState());

  HttpOps _httpOps = HttpOps();

  List<Complaint> complaintsList = [];
  void getAllComplaints() async {
   GetAllRequestServicesModel responseModel = await _httpOps.postData(auth: true , endPoint: complaintsListUrl);
   complaintsList = Complaint.toList(responseModel.dataObj);
   emit(ComplaintListLoadedSuccessState(complaintsList));
  }

}


class ComplainRoomCubit extends Cubit<ComplaintRoomState> {
  ComplainRoomCubit() : super(ComplaintRoomLoadingState());

  HttpOps _httpOps = HttpOps();
  void getComplaintRoomInfo({int userId,int msaferId}) async {

    var data = {
      "user_id": userId,
      "masafr_id":msaferId
    };
    GetAllRequestServicesModel responseModel = await _httpOps.postData(auth: true , endPoint: complaintsRoomUrl,mapData: data);
    emit(ComplaintRoomLoadedSuccessState(ComplaintRoom.fromMap(responseModel.dataObj["main_subject"])));
  }

}

class ComplainChatCubit extends Cubit<ComplainChatStates> {
  ComplainChatCubit() : super(ComplainChatLoadingState());
  HttpOps _httpOps = HttpOps();
  ChatData _chatData = ChatData();

  void getMessages(var chatRoomId){
    _chatData.complainChatRoomStream(chatRoomId).listen((messageData) {
      List<Message> msgList = Message.toList(messageData);
      print("Messages : ${messageData}");
      if(msgList.isNotEmpty){
        emit(ComplainChatLoadedSuccessState(msgList));
      }else{
        emit(NoComplainChatState());
      }
    });
    print("Loading");
  }



}