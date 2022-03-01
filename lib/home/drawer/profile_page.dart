import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/CommentsEdit/CommentsEdit.dart';
import 'package:mosafer1/Complaint/ComplaintsPage.dart';
import 'package:mosafer1/MoneyTransactions/MoneyTransactionPage.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';

import 'bloc/cubit_drawer.dart';
import 'edit_your_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => DrawerCubit()..getgetUserInform(),
        child: BlocConsumer<DrawerCubit,DrawerState>(builder:
            (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("الصفحه الشخصية"),
              centerTitle: true,
            ),
            body: state is GetLoadingMosaferInformationStates?
            Center(child: CircularProgressIndicator()):
            Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    ClipOval(
                      child: FadeInImage.assetNetwork(
                        height: 80,
                        width: 80,
                        placeholderCacheHeight: 80,
                        placeholderCacheWidth: 80,
                        placeholder: "assets/man.png",
                        image: CacheHelper.getData(key: "photo"),
                        imageErrorBuilder: (context,o,c)=>ClipOval(
                          child: Image.asset(
                            "assets/man.png",
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                    ),
                    RatingBar.builder(
                      initialRating:double.parse(DrawerCubit.get(context).mosafrInformationModel.data.rate),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: HexColor("#9EA657"),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(DrawerCubit.get(context).mosafrInformationModel.data.name,style: TextStyle(color: HexColor("#5787A6"),
                        fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(height: 30,),
                    Container(
                      padding: EdgeInsets.all(5),
                      color: MyTheme.mainAppBlueColor,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Number Of Trips",style: TextStyle(color: Colors.black),),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration:BoxDecoration(
                              color:Colors.white,
                              shape: BoxShape.circle
                            ),
                              child: Text("0")),
                          Text("Negative points",style: TextStyle(color: Colors.black)),
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration:BoxDecoration(
                                  color:Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Text("0")),
                          Text("Bargains",style: TextStyle(color: Colors.black)),
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration:BoxDecoration(
                                  color:Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Text("0")),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.insert_drive_file,color: MyTheme.mainAppBlueColor,),
                          Text("تعديل بياناتك")
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right,color: MyTheme.mainAppBlueColor,),
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> EditYourData())),
                    ),
                    Divider(endIndent: 15,indent: 15,),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.monetization_on,color: MyTheme.mainAppBlueColor,),
                          Text("اشحن رصيدك")
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right,color: MyTheme.mainAppBlueColor,),
                      onTap: (){},
                    ),
                    Divider(endIndent: 15,indent: 15,),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.notifications_active,color: MyTheme.mainAppBlueColor,),
                          Text("الشكاوي")
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right,color: MyTheme.mainAppBlueColor,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintesPage()));
                      },
                    ),
                    Divider(endIndent: 15,indent: 15,),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.monetization_on_outlined,color: MyTheme.mainAppBlueColor,),
                          Text("العمليات المالية")
                        ],
                      ),
                      trailing: Padding(
                        child: Text("رصيدك : ٢٣٠ ريال"),
                        padding: const EdgeInsets.only(left: 15,right: 15),
                      ),
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> MoneyTransactionPage())),
                    ),
                    Divider(endIndent: 15,indent: 15,),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.add_comment,color: MyTheme.mainAppBlueColor,),
                          Text("تعديل التعليقات")
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right,color: MyTheme.mainAppBlueColor,),
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsEdit())),
                    ),
                    Divider(endIndent: 15,indent: 15,),
                  ],
                ),
              ),
            ),
          );
        }, listener: (BuildContext context, state) {},
        )
    );
  }
}
