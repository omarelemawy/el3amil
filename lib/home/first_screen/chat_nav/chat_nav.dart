import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/drawer/drawer.dart';
import 'package:mosafer1/home/first_screen/chat_nav/ChatItem.dart';
import 'package:mosafer1/home/first_screen/chat_nav/MessengerPage/ChatMessengerScreen.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/bloc_chat.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/Widgets/CustomAppBar.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class ChatNav extends StatefulWidget {
  BuildContext context1;
   ChatNav(this.context1);
  @override
  _ChatNavState createState() => _ChatNavState();
}

class _ChatNavState extends State<ChatNav> {
  ChatBloc chatBloc;
  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.getChatRooms(CacheHelper.getData(key: "id"));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CacheHelper.getData(key: "token") == null
          ? Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Go To Sing In First",
                  style: TextStyle(
                      color: MyTheme.mainAppBlueColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  color:MyTheme.mainAppBlueColor,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        widget.context1,
                        MaterialPageRoute(
                            builder: (context1) => LoginScreen()),
                            (route) => false);
                  },
                  child: Text(
                    "Go",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ):Scaffold(
        body: Center(
          child: FutureBuilder<List<ChatRoom>>(
            future: chatBloc.getChatRooms(CacheHelper.getData(key: "id")),
            builder: (context,snap){
              print("Snap : ${snap}");
              if(snap.hasData) {
                print("Snap data: ${snap.data}");
                return ListView.separated(
                  itemCount: snap.data.length,
                  itemBuilder: (context1,index) => ChatListItem(chatRoom: snap.data[index],onItemClick: () {
                    pushNewScreen(
                      context,
                      screen:  ChatMessengerScreen(chatRoomId:  snap.data[index].id,),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                  },),
                  separatorBuilder: (context,index) => Divider(endIndent: 10,indent: 10,color: Colors.grey,),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
