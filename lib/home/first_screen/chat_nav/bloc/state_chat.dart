import 'package:mosafer1/model/all-request-services.dart';

abstract class ChatStates{}

class InitialChatStates extends ChatStates{}

class LoadingChatStates extends ChatStates{}

class LoadedChatStates extends ChatStates{
  List<Message> messages;
  LoadedChatStates(this.messages);
}

class NewMessage extends ChatStates {
  List<Message> messages;
  NewMessage(this.messages);
}

class NoMessageChatStates extends ChatStates{}

class NewImageState extends ChatStates{}