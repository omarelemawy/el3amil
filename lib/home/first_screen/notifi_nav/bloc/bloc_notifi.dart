import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/state_chat.dart';
import 'package:mosafer1/home/first_screen/notifi_nav/bloc/state_notifi.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/Api.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';


class NotifiBloc extends Cubit<NotifiStates>{
  NotifiBloc() : super(LoadingNotifications());

  List<Notifications> notifications = [];
  HttpOps _httpOps = HttpOps();

  void getAllNotifications(int userId) async {
    GetAllRequestServicesModel servicesModel = await _httpOps.postData(auth: true,endPoint: notificationsUrl, mapData: {});
    notifications = Notifications.toList(servicesModel.dataObj);
    print(notifications);
    emit(LoadedNotifications());
  }

}