import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mosafer1/Complaint/bloc/cubit.dart';
import 'package:mosafer1/Complaint/bloc/state.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/Widgets/CustomExpandedFAB.dart';
import 'package:mosafer1/shared/netWork/Firebase/Chat.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'dart:ui' as ui;

class ComplaintInfoPage extends StatefulWidget {
  final Complaint complaint;
  const ComplaintInfoPage({Key key, this.complaint}) : super(key: key);
  @override
  _ComplaintInfoPageState createState() => _ComplaintInfoPageState();
}

class _ComplaintInfoPageState extends State<ComplaintInfoPage> {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _chatController = TextEditingController();
  ChatData _chatData = ChatData();
  @override
  void initState() {
    _subjectController.text = "الموضوع ....";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("شكوى"),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocProvider(
                  create: (context)=> ComplainRoomCubit()..getComplaintRoomInfo(msaferId: widget.complaint.masafr.id,userId:widget.complaint.user.id ),
                  child: BlocConsumer<ComplainRoomCubit,ComplaintRoomState>(
                    builder: (context,state){
                      if(state is ComplaintRoomLoadedSuccessState)
                      {
                        _subjectController.text = state.complaintRoom.subject;
                        return Column(
                          children: [
                            IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "عميل موثوق",
                                          style: TextStyle(
                                              color: MyTheme.mainAppColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFXjhzMO9qkPIXzK2vqlvhOt8uwkRfXZkzH7xv6uHjRwTdYH9fPJIzV1tQcgyDsGjAJ-c&usqp=CAU'),
                                        ),
                                        Text(
                                          "ناصر فهد",
                                        ),
                                        Text(
                                          "رقم الطلب : " + "${widget.complaint.related_request_service}",
                                        )
                                      ],
                                    ),
                                    Directionality(textDirection: state.complaintRoom.senderType == "0" ? ui.TextDirection.rtl : ui.TextDirection.ltr, child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios,
                                          color: MyTheme.mainAppBlueColor,
                                        ),
                                        Icon(
                                          Icons.arrow_back_ios,
                                          color: MyTheme.mainAppBlueColor,
                                        ),
                                      ],
                                    ),),
                                    Column(
                                      children: [
                                        Text(
                                          "مسافر ميز",
                                          style: TextStyle(
                                              color: MyTheme.mainAppColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFXjhzMO9qkPIXzK2vqlvhOt8uwkRfXZkzH7xv6uHjRwTdYH9fPJIzV1tQcgyDsGjAJ-c&usqp=CAU'),
                                        ),
                                        Text(
                                          "موسى محمد خالد",
                                        ),
                                        Text(
                                          "رقم الرحلة : " + "${widget.complaint.related_trip}",
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: MyTheme.mainAppBlueColor,
                              width: size.width,
                              alignment: Alignment.center,
                              child: Text(
                                DateFormat.yMMMd().format(DateTime.parse(widget.complaint.created_at)),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                enabled: false,
                                controller: _subjectController,
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                        fontSize: 24, color: MyTheme.mainAppBlueColor),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide:
                                        BorderSide(color: MyTheme.mainAppBlueColor)),
                                    labelText: "الموضوع"),
                              ),
                            ),
                          ],
                        );
                      }

                      return Center(child: CircularProgressIndicator(),);
                    },
                    listener: (context,state){},
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text("الردود"),
                ),
                Expanded(
                    child: BlocProvider(
                      create: (context)=> ComplainChatCubit()..getMessages(widget.complaint.id),
                      child: BlocConsumer<ComplainChatCubit,ComplainChatStates>(
                        listener: (context,state){},
                        builder: (context,state){
                          if(state is ComplainChatLoadedSuccessState){
                            return ListView.builder(
                                reverse: true,
                                itemCount: state.messages.length,
                                padding:  EdgeInsets.only(bottom: size.height * 0.15),
                                itemBuilder: (context, index) => ComplaintReplyItem(
                                  message: state.messages[index],
                                  index: index,
                                ));
                          }

                          if(state is ComplainChatNewMessageState){
                            return ListView.builder(
                                reverse: true,
                                itemCount: state.messages.length,
                                padding:  EdgeInsets.only(bottom: size.height * 0.15),
                                itemBuilder: (context, index) => ComplaintReplyItem(
                                  message: state.messages[index],
                                  index: index,
                                ));
                          }

                          if(state is NoComplainChatState){
                            return Center(child: Text("لا يوجد اي ردود حتي الان"),);
                          }
                          return Center(child: CircularProgressIndicator(),);
                        },
                      ),
                    ))
              ],
            ),
            //Chat
            Align(
              child:  Container(
                padding: const EdgeInsets.all(10),
                alignment: AlignmentDirectional.centerStart,
                width: size.width,
                height: size.height * 0.1,
                color: MyTheme.mainAppBlueColorBright,
              ),
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Align(
                  child: Padding(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          child: CustomExpandedFab(
                            mainButtonBackgroundColor: Colors.white,
                            mainButtonElevation: 9,
                            mainButtonIcon: Icon(
                              Icons.attach_file,
                              color: Colors.blue[900],
                              size: 20,
                            ),
                            onSecondaryButtonClick: (val) async {
                              print(val);
                              switch (val) {
                                case 1:
                                  {
                                    break;
                                  }
                                case 2:
                                  {
                                    break;
                                  }
                                case 3:
                                  {
                                    break;
                                  }
                                case 4:
                                  {}
                              }
                            },
                            secondaryButtons: [
                              SecondaryExpandedButton(
                                id: 4,
                                icon: Icon(Icons.mic),
                              ),
                              SecondaryExpandedButton(
                                id: 3,
                                icon: Icon(Icons.location_on),
                              ),
                              SecondaryExpandedButton(
                                id: 2,
                                icon: Icon(Icons.photo),
                              ),
                              SecondaryExpandedButton(
                                id: 1,
                                icon: Icon(Icons.camera_alt),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(left: 8, right: 8),
                        ),
                        Expanded(
                          child: Container(
                            height: size.height * 0.12,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 15,
                                      spreadRadius: 2)
                                ]),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    child: TextField(
                                      controller: _chatController,
                                      decoration: InputDecoration.collapsed(
                                          hintText: "ابدا المحادثة"),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 20),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if(_chatController.text.isNotEmpty){
                                      Message message = Message(
                                          user: User.forChat(
                                            CacheHelper.getData(key: "id"),
                                            CacheHelper.getData(key: "name"),
                                            CacheHelper.getData(key: "photo"),
                                            "idPhoto",
                                            "email",
                                          ),
                                          message: _chatController.text,
                                          messageImage: "",
                                          additionalData: {
                                            "code" : "",
                                            "id" : "",
                                            "message" : ""
                                          },
                                          messageType: MessageType.Complaint,
                                          time: Timestamp.now().toString(),
                                          seen: false,
                                          isCurrentUser: true);
                                      _chatData.sendMessage(message: message,chatRoomId: widget.complaint.id,isComplaint: true);
                                      _chatController.clear();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: MyTheme.mainAppBlueColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.only(bottom: 15),
                  ),
                  alignment: AlignmentDirectional.bottomEnd,
                )),
          ],
        ),
      ),
    );
  }
}

class ComplaintReplyItem extends StatelessWidget {
  final int index;
  final VoidCallback onPress;
  final Message message;
  const ComplaintReplyItem({Key key, this.message,this.index, this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 1.5)),
      child: InkWell(
        onTap: onPress,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        message.user.photo),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.user.name,
                          style: TextStyle(
                              color: MyTheme.mainAppBlueColorBright
                                  .withOpacity(0.8)),
                        ),
                        Text(
                          message.message,
                          style: TextStyle(color: MyTheme.mainAppBlueColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
