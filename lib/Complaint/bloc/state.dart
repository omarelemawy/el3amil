import 'package:mosafer1/model/all-request-services.dart';

abstract class ComplaintListState {}
class ComplaintListLoadingState extends ComplaintListState{}
class ComplaintListLoadedSuccessState extends ComplaintListState{
  List<Complaint> complaints;
  ComplaintListLoadedSuccessState(this.complaints);
}
class ComplaintListLoadedFailState extends ComplaintListState{}

//

abstract class ComplaintRoomState {}
class ComplaintRoomLoadingState extends ComplaintRoomState{}
class ComplaintRoomLoadedSuccessState extends ComplaintRoomState{
  ComplaintRoom complaintRoom;
  ComplaintRoomLoadedSuccessState(this.complaintRoom);
}

//

abstract class ComplainChatStates {}
class ComplainChatLoadingState extends ComplainChatStates{}
class ComplainChatLoadedSuccessState extends ComplainChatStates{
 List<Message> messages;
 ComplainChatLoadedSuccessState(this.messages);
}
class ComplainChatNewMessageState extends ComplainChatStates{
  List<Message> messages;
  ComplainChatNewMessageState(this.messages);
}
class NoComplainChatState extends ComplainChatStates{}
