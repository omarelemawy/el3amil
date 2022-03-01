
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/bloc_add_trip.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/state_add_trip.dart';
import 'package:mosafer1/model/get-all-main-trip-categorires.dart';
import 'package:mosafer1/shared/styles/thems.dart';

import 'filed_of_add_info.dart';

class MoreInfoAddTrip extends StatelessWidget {
  Data data;
  GroupController controller = GroupController();
  MoreInfoAddTrip(this.data);
  TextEditingController getFromLocationFirstDesign = TextEditingController();
  TextEditingController getToLocationFirstDesign = TextEditingController();
  TextEditingController getStartLocationSecondDesign = TextEditingController();
  TextEditingController getEndLocationSecondDesign = TextEditingController();
  TextEditingController getDescriptionFirstDesign = TextEditingController();
  TextEditingController getDescriptionSecondDesign = TextEditingController();
  List<TextEditingController> _controllersSecondDesign = new List();
  List<TextEditingController> _controllersThirdDesign = new List();
  TextEditingController getStartLocationThirdDesign = TextEditingController();
  TextEditingController getEndLocationThirdDesign = TextEditingController();
  TextEditingController getDescriptionThirdDesign = TextEditingController();
  TextEditingController getDescriptionFourthDesign = TextEditingController();
  List<TextEditingController> _controllersLocationFourthDesign = new List();
  List<TextEditingController> _controllersTimerFourthDesign = new List();
  TextEditingController getStartLocationFourthDesign = TextEditingController();
  TextEditingController getStartTimerFourthDesign = TextEditingController();
  TextEditingController getEndLocationFourthDesign = TextEditingController();
  TextEditingController getEndTimerFourthDesign = TextEditingController();

  var keyScaffold = GlobalKey<ScaffoldState>();
  List<String>subsectionsString = [
    "أستلام على الطريق",
    "توصيل للباب",
    "شحن  ",
  ];
  String title = "";
  int design;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTripBloc(),
      child: BlocConsumer<AddTripBloc, AddTripStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              key: keyScaffold,
              appBar: AppBar(
                centerTitle: true,
                title: Text(getTitle(),
                  style: TextStyle(fontFamily: "beIN"),),
              ),
              body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text("مطلوب  مقدم  الخدمة من النساء ", style: TextStyle(
                                fontSize: 12,
                                color: Colors.black),),
                            Spacer(),
                            Checkbox(
                                value: AddTripBloc
                                    .get(context)
                                    .valueSwitch,
                                activeColor: HexColor("#78AACC"),
                                side: BorderSide(
                                    color: HexColor("#78AACC"), width: 2),
                                splashRadius: 50,
                                onChanged: (value) {
                                  AddTripBloc.get(context).changeSwitchValue(
                                      value);
                                }),
                          ],
                        ),
                      ),
                      data.id == 1 ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10,),
                              Text("حدد  مواقع الشراء   ؟",style: TextStyle(fontSize: 12),),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border.all(color: MyTheme.mainAppBlueColor),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                style: TextStyle(fontSize: 11),
                                /*controller: getFromLocationFirstDesign,*/
                                decoration: InputDecoration.collapsed(
                                  fillColor: Colors.white,
                                  filled: true,
                                    hintText: "موقع الشراء"
                                   /* contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    labelText: "موقع الشراء"*/
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.mainAppBlueColor),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                style: TextStyle(fontSize: 11),
                                /*controller: getFromLocationFirstDesign,*/
                                decoration: InputDecoration.collapsed(
                                    hintText: "شراء من موقع  الكتروني"
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("أقصى يوم وينتهي طلبك",style: TextStyle(fontSize: 12),),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: MyTheme.mainAppBlueColor),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 11),
                                      onTap: (){
                                        showDatePicker(context: context,
                                          initialDate: DateTime.now().add(Duration(hours: 1)),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(DateTime.now().year + 10),
                                        ).then((value) {
                                          final intl.DateFormat formatter = intl.DateFormat('yyyy-MM-dd');
                                          final String formatted = formatter.format(value);
                                          getToLocationFirstDesign.text=formatted;
                                        });
                                      },
                                      controller: getToLocationFirstDesign,
                                      decoration: InputDecoration.collapsed(hintText: ''),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SimpleGroupedChips<int>(
                            controller: controller,
                            itemTitle: [
                              "أستلام على الطريق",
                              "توصيل للباب",
                              "شحن  ",
                              ],
                              isScrolling: true,
                              values: [1,2,3],
                              onItemSelected: (item){
                              print(item);
                              },
                              chipGroupStyle: ChipGroupStyle.minimize(
                                backgroundColorItem: MyTheme.mainAppBlueColor,
                                itemTitleStyle: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black)
                            ),
                            height: 100,
                            width: double.infinity,
                            child: Row(
                              children: [
                                SizedBox(width: 10,),
                                Icon(Icons.cloud_upload,color: MyTheme.mainAppBlueColor,
                                 size: 40,
                                ),
                                SizedBox(width: 10,),
                                Text("أرفق صورة لطلبك",style:
                                TextStyle(color: MyTheme.mainAppBlueColor,fontSize: 12),)
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.mainAppBlueColor),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                style: TextStyle(fontSize: 12),
                                /*controller: getFromLocationFirstDesign,*/
                                decoration: InputDecoration.collapsed(
                                    hintText: "حدد وصف لطلبك "
                                ),
                                maxLines:2,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black)
                            ),
                            height: 100,
                            width: double.infinity,
                            child: Text("التحويلات المالية خارج التطبيق يعرضك للضرر  ولسنى مسؤلين عن  الاتفاقيا ت الغير مؤكدة بالاكواد داخل التطبيق  والأغراض فوق 1000 ريال يجب  عليك طلب التامين عليها ",
                             style: TextStyle(fontSize: 12),),
                          ),
                          MaterialButton(
                            color: MyTheme.mainAppBlueColor,
                            onPressed: () {
                              AddTripBloc.get(context).createTrip(DataOfTrip());
                            },
                            child: Text("نشر الخدمة", style: TextStyle(
                                color: Colors.white),),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ) :
                      data.id == 2 ?
                      Column(
                        children: [
                          Text("حدد  مواقع الشراء   ؟", style: TextStyle(
                              color: Colors.black),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: getDescriptionSecondDesign,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  labelText: "وصف رحلتك"
                              ),
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "نقطة بداية", style: TextStyle(fontWeight: FontWeight
                              .bold),),
                          getLocationDesign(getStartLocationSecondDesign),
                          Icon(Icons.arrow_downward_rounded, color: Colors.black,
                            size: 50,),
                          SizedBox(height: 20,),
                          Text(
                            "أضافة نقطه", style: TextStyle(fontWeight: FontWeight
                              .bold),),
                          GestureDetector(
                            onTap: () {
                              if (AddTripBloc
                                  .get(context)
                                  .itemsOfInformFieldLocation
                                  .length < 2) {
                                AddTripBloc.get(context).addItemLoc(
                                    getLocationDesign(getDescriptionFirstDesign));
                              } else {
                                keyScaffold.currentState.showSnackBar(
                                    SnackBar(content:
                                    Text("نقطتين فقطة حد اقصي")));
                              }
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              child: Icon(Icons.add, color:
                              Colors.white, size: 30,),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: HexColor("#638462")
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Icon(Icons.arrow_downward_rounded, color: Colors.black,
                            size: 50,),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              _controllersSecondDesign.add(
                                  new TextEditingController());
                              return getLocationDesign(
                                  _controllersSecondDesign[index]);
                            },
                            itemCount: AddTripBloc
                                .get(context)
                                .itemsOfInformFieldLocation
                                .length,),
                          SizedBox(height: 20,),
                          Container(
                            height: 45,
                            width: 45,
                            child: Icon(Icons.add, color:
                            Colors.white, size: 30,),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#638462")
                            ),
                          ),
                          SizedBox(height: 20,),
                          Icon(Icons.arrow_downward_rounded, color: Colors.black,
                            size: 50,),
                          Text("نهاية الوصول",
                            style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          getLocationDesign(getEndLocationSecondDesign),
                          Text("حدد أيام  عملك الأسبوعي ",
                            style: TextStyle(color: Colors.black),),
                          SizedBox(height: 10,),
                          Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black)
                            ),
                            height: 160,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: CheckboxGroup(
                                  labels: subsectionsString,
                                  labelStyle: TextStyle(color: Colors.black),
                                  onSelected: (List<String> checked) =>
                                      print(checked.toString())
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          MaterialButton(
                            color: HexColor("#638462"),
                            onPressed: () {
                              AddTripBloc.get(context).createTrip(DataOfTrip(onlyWomen:"0",typeOfTrips: "2",
                                  /*tripDays: [1,2,3],tripWays: [TripWays(place: "aca",time: "avd")]*/));
                            },
                            child: Text("نشر الخدمة", style: TextStyle(
                                color: Colors.white,fontWeight: FontWeight.bold),),
                          )
                        ],
                      ) :
                      data.id == 3 ?
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: getDescriptionThirdDesign,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  labelText: "وصف رحلتك"
                              ),
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("نقطة بداية", style: TextStyle(
                              fontWeight: FontWeight.bold),),
                          Icon(Icons.arrow_downward_rounded, color: Colors.black,
                            size: 50,),
                          SizedBox(height: 20,),
                          Text("أضافة نقطه", style: TextStyle(
                              fontWeight: FontWeight.bold),),
                          GestureDetector(
                            onTap: () {
                              getTitle();
                              if (AddTripBloc
                                  .get(context)
                                  .itemsOfInformFieldLocation
                                  .length < 2) {
                                AddTripBloc.get(context).addItemLoc(
                                    getLocationDesign(getDescriptionFirstDesign));
                              } else {
                                keyScaffold.currentState.showSnackBar(
                                    SnackBar(content:
                                    Text("نقطتين فقطة حد اقصي")));
                              }
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              child: Icon(Icons.add, color:
                              Colors.white, size: 30,),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: HexColor("#638462")
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Icon(Icons.arrow_downward_rounded, color: Colors.black,
                            size: 50,),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                getLocationDesign(_controllersThirdDesign[index]),
                            itemCount: AddTripBloc
                                .get(context)
                                .itemsOfInformFieldLocation
                                .length,),
                          SizedBox(height: 20,),
                          Container(
                            height: 45,
                            width: 45,
                            child: Icon(Icons.add, color:
                            Colors.white, size: 30,),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#638462")
                            ),
                          ),
                          SizedBox(height: 20,),
                          Icon(Icons.arrow_downward_rounded, color: Colors.black,
                            size: 50,),
                          Text("نهاية الوصول", style: TextStyle(
                              fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          getLocationDesign(getEndLocationThirdDesign),
                          SizedBox(height: 10,),
                          MaterialButton(
                            color: HexColor("#638462"),
                            onPressed: () {
                              AddTripBloc.get(context).createTrip(DataOfTrip());
                            },
                            child: Text("نشر الخدمة",
                              style: TextStyle(color: Colors.white),),
                          )
                        ],
                      ) :
                      Column(
                        children: [
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: getDescriptionFourthDesign,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  labelText: "وصف رحلتك"
                              ),
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("نقطة بداية", style: TextStyle(
                              fontWeight: FontWeight.bold),),
                          FiledOfAddInfo(getStartLocationFourthDesign,
                              getStartTimerFourthDesign),
                          Icon(Icons.arrow_downward_rounded, color: Colors.black,
                            size: 50,),
                          SizedBox(height: 20,),
                          Text("أضافة نقطه", style: TextStyle(
                              fontWeight: FontWeight.bold),),
                          GestureDetector(
                            onTap: () {
                              getTitle();
                              if (AddTripBloc
                                  .get(context)
                                  .itemsOfInformField
                                  .length < 2) {
                                AddTripBloc.get(context).addItem(FiledOfAddInfo(
                                    getDescriptionFirstDesign,
                                    getDescriptionFirstDesign));
                              } else {
                                keyScaffold.currentState.showSnackBar(
                                    SnackBar(content:
                                    Text("نقطتين فقطة حد اقصي")));
                              }
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              child: Icon(Icons.add, color:
                              Colors.white, size: 30,),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: HexColor("#638462")
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Icon(Icons.arrow_downward_rounded, color: Colors.black,
                            size: 50,),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                FiledOfAddInfo(
                                    _controllersLocationFourthDesign[index],
                                    _controllersTimerFourthDesign[index]),
                            itemCount: AddTripBloc
                                .get(context)
                                .itemsOfInformField
                                .length,),
                          SizedBox(height: 20,),
                          Container(
                            height: 45,
                            width: 45,
                            child: Icon(Icons.add, color:
                            Colors.white, size: 30,),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#638462")
                            ),
                          ),
                          SizedBox(height: 20,),
                          Icon(Icons.arrow_downward_rounded, color: Colors.black,
                            size: 50,),
                          Text("نهاية الوصول", style: TextStyle(
                              fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          FiledOfAddInfo(getEndLocationFourthDesign,
                              getEndTimerFourthDesign),
                          SizedBox(height: 20,),
                          MaterialButton(
                            color: HexColor("#638462"),
                            onPressed: () {
                              AddTripBloc.get(context).createTrip(DataOfTrip());
                            },
                            child: Text("نشر الخدمة",
                              style: TextStyle(color: Colors.white),),
                          )
                        ],
                      ),
                    ],
                  )
              ),
            ),
          );
        },
      ),
    );
  }

  String getTitle() {
    if (data.id == 1) {
      title = "طلب توصيل";
    }
    else if (data.id == 2) {
      title = "شراء";
      print(title);
    }
    else if (data.id == 3) {
      title = "توصيل ركاب";
    }
    else {
      title = "خدمات عامة";
    }
    return title;
  }

  Widget getLocationDesign(TextEditingController editingController) {
    return Container(
      height: 40,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          controller: editingController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              labelText: "المدينه"
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}


