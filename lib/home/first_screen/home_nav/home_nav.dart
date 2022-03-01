import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/Travel/TravelDetails.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mosafer1/home/first_screen/home_nav/cubit/home_cubit.dart';
import 'package:mosafer1/home/first_screen/home_nav/cubit/home_state.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class HomeNav extends StatefulWidget {
  BuildContext context1;
   HomeNav(this.context1);

  @override
  _HomeNavState createState() => _HomeNavState(context1);
}

class _HomeNavState extends State<HomeNav> {
  BuildContext context1;
  _HomeNavState(this.context1);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getAllServices(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        builder: (context,state){
          List<RequestServices> allRequestsSe = HomeCubit.get(context).allRequestsSe;
          return Scaffold(

            body: state is GetLoadingAllRequestServicesStates?
            Center(child: CircularProgressIndicator()):Padding(
              padding: const EdgeInsets.only(bottom: 20.0,top: 10,right: 10,left: 10),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.separated(itemBuilder: (context,index)=>
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color:MyTheme.mainAppBlueColor),),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        ClipOval(
                                          child: FadeInImage.assetNetwork(
                                            height: 80,
                                            width: 80,
                                            placeholderCacheHeight: 80,
                                            placeholderCacheWidth: 80,
                                            fit: BoxFit.cover,
                                            placeholderFit: BoxFit.cover,
                                            placeholder: "assets/man.png",
                                            image: allRequestsSe[index].user.photo,
                                            imageErrorBuilder: (context,o,c)=>ClipOval(
                                              child: Image.asset(
                                                "assets/man.png",
                                                height: 80,
                                                width: 80,
                                              ),
                                            ),
                                          ),
                                        ),
                                        /*Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            child: Icon(Icons.check,color:Colors.white,size:12,),
                                            backgroundColor: Colors.green,
                                            radius: 7,
                                          ),
                                        ),*/
                                      ],
                                    ),
                                    RatingBar.builder(
                                      initialRating: allRequestsSe[index].user != null ? int.parse(allRequestsSe[index].user.rate).toDouble() : 1.0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 15,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: MyTheme.mainAppBlueColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 7),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Row(
                                        children: [
                                          Text("المسافر :",
                                            style: TextStyle(fontFamily: "beIN",
                                                fontWeight: FontWeight.bold,
                                                color:HexColor("#707070")
                                            ),),
                                          Expanded(
                                            child: Text(allRequestsSe[index].user==null?"":
                                            allRequestsSe[index].user.name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(fontFamily: "beIN",
                                                    fontWeight: FontWeight.bold,
                                                    color:HexColor("#707070")
                                                )),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,color:MyTheme.mainAppBlueColor,),
                                          Text(allRequestsSe[index].fromPlace==null?"":
                                          allRequestsSe[index].fromPlace,
                                            style: TextStyle(fontFamily: "beIN",
                                                fontWeight: FontWeight.bold,
                                                color:HexColor("#707070")
                                            ),),
                                          Icon(Icons.chevron_right_rounded),
                                          Expanded(
                                            child: Text(allRequestsSe[index].toPlace==null?
                                            "":allRequestsSe[index].toPlace,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(fontFamily: "beIN",
                                                    fontWeight: FontWeight.bold,
                                                    color:HexColor("#707070")
                                                )),
                                          )
                                        ],
                                      ),
                                      if(allRequestsSe[index].description.isNotEmpty)
                                        Text(allRequestsSe[index].description,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(fontFamily: "beIN",
                                                fontWeight: FontWeight.bold,
                                                color: MyTheme.mainAppBlueColor.withOpacity(0.7)
                                            )),
                                    FittedBox(child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.watch_later,
                                              size: 20,
                                              color: MyTheme.mainAppBlueColor,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("ينتهي الطلب خلال"),
                                          ],
                                        ),
                                        SizedBox(width: 9,),
                                        allRequestsSe[index].maxDay==null?SizedBox():
                                        CountdownTimer(
                                          endTime: DateTime.parse(allRequestsSe[index].maxDay).millisecondsSinceEpoch,
                                          widgetBuilder: (_, CurrentRemainingTime time) {
                                            if (time == null) {
                                              return Text("طلب منتهي");
                                            }
                                            return  Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "يوم",
                                                      style: TextStyle(fontSize: 16),
                                                    ),
                                                    CircleAvatar(
                                                      child: FittedBox(
                                                        child: Text(
                                                          "${time.days}",
                                                          style: TextStyle(
                                                              fontSize: 16, color: Colors.white),
                                                        ),
                                                      ),
                                                      backgroundColor: MyTheme.mainAppBlueColor
                                                          .withOpacity(0.6),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "ساعة",
                                                      style: TextStyle(fontSize: 16),
                                                    ),
                                                    CircleAvatar(
                                                      child: FittedBox(
                                                        child: Text(
                                                          "${time.hours}",
                                                          style: TextStyle(
                                                              fontSize: 16, color: Colors.white),
                                                        ),
                                                      ),
                                                      backgroundColor: MyTheme.mainAppBlueColor
                                                          .withOpacity(0.6),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "دقيقة",
                                                      style: TextStyle(fontSize: 16),
                                                    ),
                                                    CircleAvatar(
                                                      child: FittedBox(
                                                        child: Text(
                                                          "${time.min}",
                                                          style: TextStyle(
                                                              fontSize: 16, color: Colors.white),
                                                        ),
                                                      ),
                                                      backgroundColor: MyTheme.mainAppBlueColor
                                                          .withOpacity(0.6),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "ثانية",
                                                      style: TextStyle(fontSize: 16),
                                                    ),
                                                    CircleAvatar(
                                                      child: FittedBox(
                                                        child: Text(
                                                          "${time.sec}",
                                                          style: TextStyle(
                                                              fontSize: 16, color: Colors.white),
                                                        ),
                                                      ),
                                                      backgroundColor: MyTheme.mainAppBlueColor
                                                          .withOpacity(0.6),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                  color : MyTheme.mainAppBlueColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    TextButton(onPressed: (){
                                      shareFlutter(allRequestsSe[index].description,
                                          allRequestsSe[index].service,allRequestsSe[index].description);
                                    }, child:
                                    Icon(Icons.share,color: Colors.white,),),
                                    Spacer(),
                                    ElevatedButton(onPressed: (){
                                      pushNewScreen(
                                        context,
                                        screen: TravelDetailsPage(requestServices: allRequestsSe[index],),
                                        withNavBar: false, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                      );
                                      },
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.white),
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
                                        )
                                        , child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("دخول",style:
                                            TextStyle(fontFamily: "beIN",fontSize: 14,color: MyTheme.mainAppBlueColor),),
                                            Icon(Icons.chevron_right,color: MyTheme.mainAppBlueColor,),
                                          ],
                                        ))
                                    ,
                                    SizedBox(width: 10,),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  itemCount: allRequestsSe.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20,);
                  },
                ),
              ),
            ),
          );
        },
        listener: (context,state){},
      ),
    );
  }
  Future<void> shareFlutter(url,title,body) async {
    await Share.share(
        url,
        subject: body,
    );
  }
}
