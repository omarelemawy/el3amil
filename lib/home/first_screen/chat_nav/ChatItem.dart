import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mosafer1/model/all-request-services.dart';

class ChatListItem extends StatelessWidget {
  final VoidCallback onItemClick;
  final ChatRoom chatRoom;
  const ChatListItem({Key key, this.onItemClick,this.chatRoom}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: onItemClick,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration:
              BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/man.png',
                image: chatRoom.client.photo,
                imageErrorBuilder: (context,obj,err) => Image.asset('assets/man.png'),
              ),
            ),
            Padding(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatRoom.client.name,
                    style: TextStyle(color: Colors.black,fontSize: 15),
                  ),
                  chatRoom.requestServiceChatRoom==null?SizedBox():
                  Text(
                    chatRoom.requestServiceChatRoom.service.categorieName,
                    style: TextStyle(color: Colors.grey,fontSize: 13),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ],
        ),
      ),
    );
  }
}
