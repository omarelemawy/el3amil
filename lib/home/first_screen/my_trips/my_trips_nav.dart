import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/drawer.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/add_trip.dart';

import 'package:mosafer1/home/first_screen/my_trips/bloc/state_my_trips.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/model/get-my-trips.dart';
import 'package:mosafer1/shared/Constats.dart';
import 'package:mosafer1/shared/Widgets/CustomAppBar.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'bloc/bloc_my_trips.dart';

class MyTripsNav extends StatelessWidget {
  BuildContext context1;
  final bool isFromMain;
  MyTripsNav(this.context1, {this.isFromMain = true});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyTripsBloc()..getMyTrip(),
      child: BlocConsumer<MyTripsBloc, MyTripsStates>(
        builder: (context, state) {
          List<RequestServices> allMyTrips = MyTripsBloc.get(context).allMyTrips;

          return CacheHelper.getData(key: "token") == null
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
                                  context1,
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
                )
              : Scaffold(
                   floatingActionButton: FloatingActionButton.extended(
                       onPressed: (){
                         pushNewScreen(
                           context,
                           screen: AddTrip(context1),
                           withNavBar: false, // OPTIONAL VALUE. True by default.
                           pageTransitionAnimation: PageTransitionAnimation.cupertino,
                         );
                       },
                       label: Row(
                     children: [
                       Text("أضافة طلب"),
                       SizedBox(width: 5,),
                       Container(
                         decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             color: Colors.white
                         ),
                         child: Icon(Icons.add,color: MyTheme.mainAppBlueColor,),
                       ),
                     ],
                   )),
                    body: state is GetLoadingAllMyRequestServicesStates
                      ? Center(child: CircularProgressIndicator())
                      : Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20.0, top: 10, right: 10, left: 10),
                            child: ListView.separated(
                              itemBuilder: (context, index) => RequestItem(
                                isFromMain: isFromMain,
                                request: allMyTrips[index],
                                onTripClick: () {
                                  Navigator.pop(context,allMyTrips[index]);
                                },
                              ),
                              itemCount: allMyTrips.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                            ),
                          ),
                        ),
                );
        },
        listener: (context, state) {
        },
      ),
    );
  }
}

class RequestItem extends StatelessWidget {
  bool isFromMain;
  RequestServices request;
  VoidCallback onTripClick;
  RequestItem({this.isFromMain = true, this.request, this.onTripClick});

  Duration expireDate;
  @override
  Widget build(BuildContext context) {
    expireDate =  DateTime.parse(request.maxDay).difference(DateTime.now());
    print("Expire ${request.photo}");
    return IntrinsicHeight(
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: MyTheme.mainAppBlueColor.withOpacity(0.5)),
            ),
            child: Column(
              children: [
                Padding(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: ClipRRect(
                              child: FadeInImage.assetNetwork(
                                placeholder: placeholder2,
                                fit: BoxFit.cover,
                                image:request.photo,
                                imageErrorBuilder: (context,c,f)=>ClipRRect(
                                  child: Image.network
                                    ('https://www.iihs.org/api/ratings/model-year-images/3112/636/'),
                                ),
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: 120,
                            height: 40,
                            child: FittedBox(
                              child: Text(
                                request.service.categorieName,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            decoration: BoxDecoration(
                                color: MyTheme.mainAppBlueColor,
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: MyTheme.mainAppBlueColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(request.fromPlace),
                              Text("  >>  "),
                              Text(request.toPlace),
                            ],
                          ),
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
                          CountdownTimer(
                            endTime: DateTime.parse(request.maxDay).millisecondsSinceEpoch,
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
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(9),
                ),
                IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "تعديل",
                            style: TextStyle(color: MyTheme.mainAppBlueColor),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                        ),
                        Text(" رقم الطلب :  ${request.id}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.restore_from_trash,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    decoration: BoxDecoration(color: MyTheme.mainAppBlueColor),
                  ),
                )
              ],
            ),
          ),
          if (!isFromMain)
            ElevatedButton(
              onPressed: () {
                onTripClick();
              },
              child: Text(
                "تاكيد",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.mainAppBlueColor),
                  fixedSize: MaterialStateProperty.all(Size.fromWidth(120)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
            ),
        ],
      ),
    );
  }
}
