import 'package:flutter/material.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class CommentsEdit extends StatefulWidget {
  @override
  _CommentsEditState createState() => _CommentsEditState();
}

class _CommentsEditState extends State<CommentsEdit> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل التعليقات"),
        centerTitle: true,
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child:
              ListView.builder(itemBuilder: (context, index) => CommentItem())),
    );
  }
}

class CommentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            width: size.width * 0.9,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.mainAppBlueColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFXjhzMO9qkPIXzK2vqlvhOt8uwkRfXZkzH7xv6uHjRwTdYH9fPJIzV1tQcgyDsGjAJ-c&usqp=CAU'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الاسم : " + "خالد محمد صقر ",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                        ),
                        Text(
                          "رقم  الطلب :" + "22",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "أرسل التعديل",
                          style: TextStyle(color: Colors.red),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        )),
                    padding: const EdgeInsets.only(left: 10),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          SizedBox(
            width: size.width * 0.9,
            child: TextField(
              decoration: InputDecoration(
                hintText: "تحرير ",
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: MyTheme.mainAppBlueColor)
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: MyTheme.mainAppBlueColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: MyTheme.mainAppBlueColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: MyTheme.mainAppBlueColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
