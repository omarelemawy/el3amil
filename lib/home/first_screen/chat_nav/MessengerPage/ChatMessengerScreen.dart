import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:mosafer1/Fatorah/FatorahPage.dart';
import 'package:mosafer1/home/BottomNavigation/bloc/bloc_chat.dart';
import 'package:mosafer1/home/drawer/drawer.dart';
import 'package:mosafer1/home/first_screen/chat_nav/MapPage/MapView.dart';
import 'package:mosafer1/home/first_screen/chat_nav/MessengerPage/MessageItem.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/bloc_chat.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/state_chat.dart';
import 'package:mosafer1/home/first_screen/my_trips/my_trips_nav.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/model/get-my-trips.dart';
import 'package:mosafer1/shared/Widgets/CustomExpandedFAB.dart';
import 'package:mosafer1/shared/Widgets/DrawerBtn.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/netWork/Firebase/Chat.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';


class ChatMessengerScreen extends StatefulWidget {
  final chatRoomId;
  ChatMessengerScreen({Key key,this.chatRoomId}) : super(key: key);

  @override
  _ChatMessengerScreenState createState() => _ChatMessengerScreenState();
}

class _ChatMessengerScreenState extends State<ChatMessengerScreen> {
  PanelController _panelController = PanelController();
  TextEditingController _messageSendController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  ChatBloc chatBloc;
  ChatData _chatData = ChatData();
  BottomNavigationBloc bottomNavigationBloc;

  bool _isActive = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      chatBloc = BlocProvider.of<ChatBloc>(context);
      chatBloc.getMessages(widget.chatRoomId);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        /*actions: [
          TextButton(
            child: SVGIcons.barIcon,
            onPressed: () {

            },
          ),
        ],*/
        title: Text(
          "محادثة",
          style: TextStyle(fontFamily: "beIN"),
        ),
        bottom: PreferredSize(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, bottom: 2, top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("بلاغ"),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(MyTheme.mainAppBlueColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                      ),
                      Text(
                        "نرجو الاحترام المتبادل وعدم التجريح بالألفاظ",
                        style: appTheme.textTheme.overline,
                      )
                    ],
                  ),
                ),
                Container(
                    width: size.width,
                    height: 50,
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, bottom: 2, top: 2),
                    child: Marquee(
                      text: "نرجو الاحترام المتبادل وعدم التجريح بالألفاظ",
                      style: appTheme.textTheme.bodyText1,
                      velocity: 100.0,
                    ))
              ],
            ),
          ),
          preferredSize: Size.fromHeight(90),
        ),
      ),
      body: Stack(
        children: [
          BlocConsumer<ChatBloc, ChatStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadingChatStates) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedChatStates || state is NewMessage || state is NewImageState) {
                moveChat();
                return chatBloc==null?CircularProgressIndicator():
                ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.only(bottom: 100, left: 10, right: 10),
                  itemCount: chatBloc.messages.length,
                  itemBuilder: (context, index) => MessageItem(
                    appTheme: appTheme,
                    message: chatBloc.messages[index],
                    isCurrentUser: true,
                    onEnterButtonPress: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> FatorahPage())),
                  ),
                );
              } else if(state is NoMessageChatStates) {
                return Center(child : Text("ابدا المحادثة"));
              }
              return SizedBox();
            },
          ),
          /*StreamBuilder<QuerySnapshot>(
            stream: _chatData.chatRoomStream("cjujAnyhD9PCtUP4f2OH"),
            builder: (context,snap) {
              if(snap.hasData){
                print(snap.data.docs);
                return  ListView.builder(
                  controller: _scrollController,
                  padding:
                  const EdgeInsets.only(bottom: 100, left: 10, right: 10),
                  itemCount: chatBloc.messages.length,
                  itemBuilder: (context, index) => MessageItem(
                    appTheme: appTheme,
                    message: chatBloc.messages[index],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator(),);
            },
          )*/
          Align(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Positioned(
                  child: ElevatedButton(
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      _panelController.open();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            MyTheme.mainAppBlueColor),
                        shape: MaterialStateProperty.all(CircleBorder())),
                  ),
                  bottom: 85,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _isActive
                        ? SlidingUpPanel(
                            color: Colors.transparent,
                            maxHeight: 180,
                            minHeight: 0,
                            boxShadow: [],
                            controller: _panelController,
                            header: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Container(
                                  height: 150,
                                  margin: const EdgeInsets.only(top: 50),
                                  padding: const EdgeInsets.only(
                                      top: 35, left: 9, right: 9),
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: MyTheme.mainAppBlueColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "شكوي",
                                            style: appTheme.textTheme.bodyText2,
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size.fromHeight(50)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                      )),
                                      Expanded(
                                          child: Padding(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "شكوي",
                                            style: appTheme.textTheme.bodyText2,
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size.fromHeight(50)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                      )),
                                      Expanded(
                                          child: Padding(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "شكوي",
                                            style: appTheme.textTheme.bodyText2,
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size.fromHeight(50)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                      )),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    child: TextButton(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        _panelController.close();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                MyTheme.mainAppColor),
                                        shape: MaterialStateProperty.all(
                                            CircleBorder()),
                                      ),
                                    ),
                                    bottom: 130)
                              ],
                            ),
                            panel: SizedBox(),
                          )
                        : Padding(
                          padding: const EdgeInsets.only(left: 80,right: 25),
                          child: SizedBox(
                            width: size.width*0.8,
                            child: SlidingUpPanel(
                              color: Colors.transparent,
                              maxHeight: 80,
                              minHeight: 0,
                              boxShadow: [],
                              controller: _panelController,
                              header: Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Container(
                                    height: 60,
                                    width: size.width*0.75,
                                    padding: const EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                        color: MyTheme.mainAppBlueColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Padding(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  RequestServices request = await Navigator.push(context, MaterialPageRoute(builder: (context) => MyTripsNav(context,isFromMain: false,)));
                                                  if(request != null){
                                                    print("Request : ${request.id}");
                                                    String messageText = await chatBloc.createNegotiationRequest(request_id: request.id,chat_id: widget.chatRoomId);
                                                    if(messageText.isNotEmpty){
                                                      Message msg = Message(
                                                          user: User.forChat(
                                                            CacheHelper.getData(key: "id"),
                                                            CacheHelper.getData(key: "name"),
                                                            CacheHelper.getData(key: "photo"),
                                                            "idPhoto",
                                                            "email",
                                                          ),
                                                          message: messageText,
                                                          messageImage: "",
                                                          additionalData: {
                                                            "code" : "",
                                                            "id" : request.id,
                                                            "message" : ""
                                                          },
                                                          messageType: MessageType.Request,
                                                          time: Timestamp.now().toString(),
                                                          seen: false,
                                                          isCurrentUser: true);
                                                      await _chatData.sendMessage(chatRoomId: widget.chatRoomId,message: msg);

                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  "حدد طلبك",
                                                  style: appTheme.textTheme.bodyText2,
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                    fixedSize: MaterialStateProperty.all(Size.fromWidth(size.width*0.8)),
                                                    minimumSize:
                                                    MaterialStateProperty.all(
                                                        Size.fromHeight(50)),
                                                    shape: MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10)))),
                                              ),
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 5),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              panel: SizedBox(),
                            ),
                          ),
                        ),
                    /*!_isActive ? Container(
                      margin: const EdgeInsets.only(left: 80,right: 25),
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 40),
                      height: size.height*0.13,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                        color: MyTheme.mainAppColor
                      ),
                      child: ElevatedButton(child: Text("انشاء فاتورة",style: TextStyle(color: MyTheme.mainAppColor),),onPressed: (){},style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),

                      ),),
                    ) : SizedBox()*/
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: AlignmentDirectional.centerStart,
                      width: size.width,
                      height: size.height * 0.1,
                      color: MyTheme.mainAppBlueColorBright,
                    ),
                  ],
                ),
                Align(
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
                              switch(val)
                              {
                                case 1 : {
                                  chatBloc.selectAndGetImagePath(isCamera: true);
                                  break;
                                }
                                case 2 : {
                                  chatBloc.selectAndGetImagePath(isCamera: false);
                                  break;
                                }
                                case 3 : {
                                  GeoPoint location = await Navigator.push(context,MaterialPageRoute(builder:(context) => MapPage()));
                                  print("selected location $location");
                                  Message msg = Message(
                                      user: User.forChat(
                                        CacheHelper.getData(key: "id"),
                                        CacheHelper.getData(key: "name"),
                                        CacheHelper.getData(key: "photo"),
                                        "idPhoto",
                                        "email",
                                      ),
                                      message: "",
                                      messageImage: "",
                                      messageLocation: location,
                                      time: Timestamp.now().toString(),
                                      seen: false,
                                      isCurrentUser: true);
                                  await _chatData.sendMessage(chatRoomId: widget.chatRoomId,message: msg);
                                  moveChat();
                                  break;
                                }
                                case 4 : {

                                }
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
//                        ElevatedButton(
//                          child: Icon(
//                            Icons.attach_file,
//                            color: Colors.blue[900],
//                            size: 20,
//                          ),
//                          onPressed: () {},
//                          style: ButtonStyle(
//                              backgroundColor:
//                                  MaterialStateProperty.all(Colors.white),
//                              shape: MaterialStateProperty.all(CircleBorder())),
//                        ),
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
                                Padding(
                                  child: BlocConsumer<ChatBloc,ChatStates>(
                                    builder: (context,state){
                                      if(state is NewImageState) {
                                        return Image.file(File(chatBloc.imagePath),width: 50,height: 50,fit: BoxFit.cover,);
                                      }
                                      return SizedBox();
                                    },
                                    listener: (context,state){},
                                  ),
                                  padding: const EdgeInsets.only(left: 10, right: 5),
                                ),
                                Expanded(
                                  child: Padding(
                                    child: TextField(
                                      controller: _messageSendController,
                                      decoration: InputDecoration.collapsed(
                                          hintText: "ابدا المحادثة"),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 20),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if(_messageSendController.text.isNotEmpty || chatBloc.imagePath.isNotEmpty){
                                      Message msg = Message(
                                          user: User.forChat(
                                            CacheHelper.getData(key: "id"),
                                            CacheHelper.getData(key: "name"),
                                            CacheHelper.getData(key: "photo"),
                                            "idPhoto",
                                            "email",
                                          ),
                                          message: _messageSendController.text,
                                          messageImage: chatBloc.imagePath,
                                          time: Timestamp.now().toString(),
                                          seen: false,
                                          isCurrentUser: true);
                                      //chatBloc.sendMessage(msg, _scrollController);
                                      _messageSendController.clear();
                                      await _chatData.sendMessage(chatRoomId: widget.chatRoomId , message: msg);
                                      moveChat();
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
                )
              ],
            ),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }

  void moveChat() {
    Future.delayed(Duration(milliseconds: 2), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageSendController.dispose();
    super.dispose();
  }
}
