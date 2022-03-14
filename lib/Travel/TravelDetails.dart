import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mosafer1/home/first_screen/chat_nav/MessengerPage/ChatMessengerScreen.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/Constats.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/netWork/Firebase/Chat.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class TravelDetailsPage extends StatefulWidget {
  final RequestServices requestServices;
  const TravelDetailsPage({Key key, this.requestServices}) : super(key: key);
  @override
  _TravelDetailsPageState createState() => _TravelDetailsPageState();
}

class _TravelDetailsPageState extends State<TravelDetailsPage> {
  List<MapLatLng> polylinePoints;
  Size size;
  ChatData _chatData = ChatData();

  List categories = [
    "شحنات خفيفة",
    "خدمات مدن",
    "شحنات  كبيرة ",
    "أطعمة  وهديا",
    "نبات وحيوانات",
    "ركاب"
  ];
  @override
  void initState() {
    getLocation().then((value) {
      polylinePoints = [
        MapLatLng(value[0].latitude, value[0].longitude),
        MapLatLng(value[1].latitude, value[1].longitude),
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("تفاصيل  الخدمة"),
        leading: TextButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          FutureBuilder<List<Location>>(
              future: getLocation(),
              builder:  (context,snap) {
                if(snap.hasData) {
                  return SfMaps(
                    layers: [
                      MapTileLayer(
                        initialFocalLatLng: MapLatLng(snap.data[0].latitude, snap.data[0].longitude),
                        initialZoomLevel: 4,
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        sublayers: [
                          MapPolylineLayer(
                            polylines: Set.of([
                              MapPolyline(
                                points: polylinePoints,
                              )
                            ]),
                          ),
                        ],
                        initialMarkersCount: 2,
                        markerBuilder: (context, index) {
                          if (index == 0) {
                            return MapMarker(
                                iconColor: Colors.white,
                                iconStrokeColor: Colors.blue,
                                iconStrokeWidth: 2,
                                latitude: snap.data[0].latitude,
                                longitude: snap.data[0].longitude);
                          }
                          return MapMarker(
                              iconColor: Colors.white,
                              iconStrokeColor: Colors.blue,
                              iconStrokeWidth: 2,
                              latitude:
                              snap.data[1].latitude,
                              longitude:
                              snap.data[1].longitude);
                        },
                      ),
                    ],
                  );
                }
                return CircularProgressIndicator();
              }
          ),
          Padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundImage:
                  widget.requestServices.user != null ? NetworkImage(widget.requestServices.user.photo) : AssetImage("assets/placeholderuser.png"),
                  radius: 35,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.requestServices.user != null ?
                    widget.requestServices.user.name : "- - - -",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: MyTheme.mainAppBlueColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
            padding: const EdgeInsets.all(15),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if(CacheHelper.getData(key: "id") != null ) Padding(
                child: ElevatedButton(

                  onPressed: () {
                    print(CacheHelper.getData(key: "id"));
                    print(widget.requestServices.user.id);
                    print(widget.requestServices.id);
                    if(widget.requestServices.user != null && CacheHelper.getData(key: "id") != null){
                      _chatData.getOrCreateChatRoom(CacheHelper.getData(key: "id"),
                          widget.requestServices.user.id,widget.requestServices.id).then((value) {
                        print("Chat room : ${value}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatMessengerScreen(chatRoomId: value,)));
                      });
                    }
                  },
                  child: Text("تفاوض"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MyTheme.mainAppBlueColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                ),
                padding: const EdgeInsets.all(15),
              ),
              SlidingUpPanel(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                minHeight: size.height * 0.3,
                maxHeight: size.height * 0.5,
                color: MyTheme.mainAppBlueColor,
                header: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      height: 35,
                      width: size.width,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          color: MyTheme.mainAppBlueColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                panel: Container(
                    margin: const EdgeInsets.only(top: 30),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 160,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: MyTheme.mainAppBlueColor
                                            .withOpacity(0.4)),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        child: SVGIcons.plane,
                                        padding: const EdgeInsets.only(
                                            bottom: 5, right: 10),
                                      ),
                                      Text(
                                        "رحلة رقم : " +
                                            "${widget.requestServices.id}",
                                        style: TextStyle(
                                            color: MyTheme.mainAppBlueColor),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 160,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: MyTheme.mainAppBlueColor
                                            .withOpacity(0.4)),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        child: SVGIcons.woman,
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                      ),
                                      Text(
                                        "خدمات للنساء فقط",
                                        style: TextStyle(
                                            color: MyTheme.mainAppBlueColor),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Text(
                            widget.requestServices.description.isEmpty
                                ? "لا يوجد تفاصيل"
                                : widget.requestServices.description,
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: MyTheme.mainAppBlueColor),
                            ),
                            child: Wrap(
                              children: List<Widget>.generate(
                                  categories.length,
                                  (index) => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                              value: true, onChanged: (val) {}),
                                          Text(categories[index])
                                        ],
                                      )),
                            ),
                          ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Container(
                               child: FadeInImage.assetNetwork(
                                 placeholder: placeholder2,
                                 image:
                                 'https://www.iihs.org/api/ratings/model-year-images/3112/636/',
                                 fit: BoxFit.cover,
                               ),
                               clipBehavior: Clip.antiAlias,
                               decoration:
                               BoxDecoration(shape: BoxShape.circle),
                               width: 130,
                               height: 130,
                               margin: const EdgeInsets.all(10),
                             ),
                             Text("Honda Civik 2021",style: TextStyle(fontSize: 18),)
                           ],
                         )
                        ],
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<List<Location>> getLocation()async {
    List<Location> locations=[];
    List<Location> locations3 = await locationFromAddress("الرياض");
    List<Location> locations4 = await locationFromAddress("مكه");
    List<Location> locations1 = await locationFromAddress(widget.requestServices.fromPlace).onError((error, stackTrace) => null);
    List<Location> locations2 = await locationFromAddress(widget.requestServices.toPlace).onError((error, stackTrace) => null);

    locations.add(locations1==null?locations3[0]:locations1[0]);
    locations.add(locations2==null?locations4[0]:locations2[0]);
    return locations;
  }
}
