import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/drawer/bloc/cubit_drawer.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MoreOfProfilePage extends StatelessWidget {
  int id;

   MoreOfProfilePage(this.id);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
     /* appBar: AppBar(
        title: Text("صفحة العميل "),
        centerTitle: true,
      ),*/
      body: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: BlocProvider(
              create: (BuildContext context) =>
              DrawerCubit()..getgetMosaferInform(id: id),
              child: BlocConsumer<DrawerCubit, DrawerState>(
                  listener: (BuildContext context, state) {},
                  builder: (BuildContext context, state) {

                    if(state is GetLoadingMosaferInformationStates)
                      return Center(child: CircularProgressIndicator(),);
                    if(state is GetSuccessMosaferInformationStates)
                      return CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 400,
                            floating: true,
                            title: Text(
                              "صفحة المسافر"
                            ),
                            pinned: true,
                            centerTitle: true,
                            flexibleSpace: FlexibleSpaceBar(
                            background: FadeInImage.assetNetwork(
                              height: size.height/2,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              placeholderFit: BoxFit.fill,
                              placeholderCacheHeight: 400,
                              placeholderCacheWidth: 400,
                              placeholder: "assets/man.png",
                              image: state.mosafrInformationModel
                                  .data.photo,
                              imageErrorBuilder:
                                  (context, o, c) =>
                                  ClipOval(
                                    child: Image.asset(
                                      "assets/man.png",
                                      fit: BoxFit.fill,
                                      height: 400,
                                      width: double.infinity,
                                    ),
                                  ),
                            )
                            ),
                          ),
                         SliverToBoxAdapter(
                           child:ListView.builder(
                               primary: false,
                               shrinkWrap: true,
                               itemCount: 10,
                               itemBuilder: (context, index) =>
                                   CommentItem()),
                         )
                        ]
                      );
                    return SizedBox();
                  }))),
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
                ],
              ),
            ),
          ),
          Container(
            width: size.width * 0.9,
            child: Text("لا يوجد تعليق"),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey, width: 1.5)),
          )
        ],
      ),
    );
  }
}
