
import 'dart:io';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/bloc_add_trip.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/state_add_trip.dart';
import 'package:mosafer1/model/get-all-main-trip-categorires.dart';
import 'package:mosafer1/shared/styles/thems.dart';

import 'filed_of_add_info.dart';

class MoreInfoAddTrip extends StatelessWidget {
  Data data;
  File _fileFirstDesign;
  File _fileSecondDesign;
  File _fileThirdDesign;
  GroupController controllerFirstDesign = GroupController();
  GroupController controllerSecondDesign = GroupController();
  GroupController controllerFourthDesign = GroupController();
  MoreInfoAddTrip(this.data);
  TextEditingController getFromLocationFirstDesign = TextEditingController();
  TextEditingController getWebSiteFirstDesign = TextEditingController();
  TextEditingController getToLocationFirstDesign = TextEditingController();
  TextEditingController getEndDateFirstDesign = TextEditingController();
  TextEditingController getDescriptionFirstDesign = TextEditingController();

  TextEditingController getStartLocationSecondDesign = TextEditingController();
  TextEditingController getEndLocationSecondDesign = TextEditingController();
  TextEditingController getEndDateSecondDesign = TextEditingController();
  TextEditingController getDescriptionSecondDesign = TextEditingController();

  TextEditingController getStartLocationThirdDesign = TextEditingController();
  TextEditingController getEndDateThirdDesign = TextEditingController();
  TextEditingController getDescriptionThirdDesign = TextEditingController();

  TextEditingController getStartLocationFourthDesign = TextEditingController();
  TextEditingController getEndLocationFourthDesign = TextEditingController();
  TextEditingController getNumberFourthDesign = TextEditingController();
  TextEditingController getDescriptionFourthDesign = TextEditingController();

  Future getFile(i) async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if(result != null) {
      switch(i){
        case 1:
          _fileFirstDesign = File(result.files.single.path.toString());
          break;
        case 2:
          _fileSecondDesign = File(result.files.single.path.toString());
          break;
        case 3:
          _fileThirdDesign = File(result.files.single.path.toString());
          break;
      }
    } else
    {
    }
  }
  var keyScaffold = GlobalKey<ScaffoldState>();
  String title = "";

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
                      data.id == 2 ? Column(
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
                                controller: getFromLocationFirstDesign,
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
                                controller: getWebSiteFirstDesign,
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
                                  child: Text("التوصيل الى   ؟",style: TextStyle(fontSize: 12),),
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
                                      controller: getToLocationFirstDesign,
                                      decoration: InputDecoration.collapsed(hintText: 'المدينه'),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                                          getEndDateFirstDesign.text=formatted;
                                          print(getEndDateFirstDesign.text);
                                        });
                                      },
                                      controller: getEndDateFirstDesign,
                                      decoration: InputDecoration.collapsed(hintText: ''),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SimpleGroupedChips<int>(
                            controller: controllerFirstDesign,
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
                          GestureDetector(
                            onTap: (){
                              getFile(1).then((value) {
                                AddTripBloc.get(context).getImageFirstDesign();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)
                              ),
                              height: 100,
                              width: double.infinity,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: _fileFirstDesign==null?Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.cloud_upload,color: MyTheme.mainAppBlueColor,
                                   size: 40,
                                  ),
                                  SizedBox(width: 10,),
                                  Text("أرفق صورة لطلبك",style:
                                  TextStyle(color: MyTheme.mainAppBlueColor,fontSize: 12),)
                                ],
                              ):
                               Image.file(_fileFirstDesign,fit: BoxFit.cover,),
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
                                controller: getDescriptionFirstDesign,
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
                         state is  CreateTripLoadingStates?
                          CircularProgressIndicator():
                          MaterialButton(
                            color: MyTheme.mainAppBlueColor,
                            onPressed: () {
                              AddTripBloc.get(context).createTrip(DataOfTrip(
                                typeOfTrips: data.id,
                                onlyWomen: 1,
                                fromPlace: getFromLocationFirstDesign.text,
                                description: getDescriptionFirstDesign.text,
                                toPlace: getToLocationFirstDesign.text,
                                maxDay: getEndDateFirstDesign.text,
                              ),
                                  data.id,context,_fileFirstDesign);
                            },
                            child: Text("أرسل طلبك", style: TextStyle(
                                color: Colors.white),),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ) :
                      data.id == 1 ?
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: MyTheme.mainAppBlueColor),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 11),
                                      controller: getStartLocationSecondDesign,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: " من مدينة"
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: MyTheme.mainAppBlueColor),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 11),
                                      controller: getEndLocationSecondDesign,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: " الي مدينة"
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
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
                                          getEndDateSecondDesign.text=formatted;
                                        });
                                      },
                                      controller: getEndDateSecondDesign,
                                      decoration: InputDecoration.collapsed(hintText: ''),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SimpleGroupedChips<int>(
                              controller: controllerSecondDesign,
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
                          GestureDetector(
                            onTap: (){
                              getFile(2).then((value) {
                                AddTripBloc.get(context).getImageSecondDesign();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)
                              ),
                              height: 100,
                              width: double.infinity,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: _fileSecondDesign==null?Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.cloud_upload,color: MyTheme.mainAppBlueColor,
                                    size: 40,
                                  ),
                                  SizedBox(width: 10,),
                                  Text("أرفق صورة لطلبك",style:
                                  TextStyle(color: MyTheme.mainAppBlueColor,fontSize: 12),)
                                ],
                              ):
                              Image.file(_fileSecondDesign,fit: BoxFit.cover,),
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
                                controller: getDescriptionSecondDesign,
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
                              AddTripBloc.get(context).createTrip(DataOfTrip(
                                typeOfTrips: data.id,
                                onlyWomen: 1,
                                fromPlace: getStartLocationSecondDesign.text,
                                toPlace: getEndLocationSecondDesign.text,
                                maxDay: getEndDateSecondDesign.text,
                                description: getDescriptionSecondDesign.text,
                              ),data.id,context,_fileSecondDesign);
                            },
                            child: Text("أرسل طلبك", style: TextStyle(
                                color: Colors.white),),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ) :
                      data.id == 4 ?
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child:Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.mainAppBlueColor),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                style: TextStyle(fontSize: 11),
                                controller: getStartLocationThirdDesign,
                                decoration: InputDecoration.collapsed(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: " حدد المدينة"
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
                                          getEndDateThirdDesign.text=formatted;
                                        });
                                      },
                                      controller: getEndDateThirdDesign,
                                      decoration: InputDecoration.collapsed(hintText: ''),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              getFile(3).then((value) {
                                AddTripBloc.get(context).getImageThirdDesign();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)
                              ),
                              height: 100,
                              width: double.infinity,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: _fileThirdDesign==null?Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.cloud_upload,color: MyTheme.mainAppBlueColor,
                                    size: 40,
                                  ),
                                  SizedBox(width: 10,),
                                  Text("أرفق صورة لطلبك",style:
                                  TextStyle(color: MyTheme.mainAppBlueColor,fontSize: 12),)
                                ],
                              ):
                              Image.file(_fileThirdDesign,fit: BoxFit.cover,),
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
                                controller: getDescriptionThirdDesign,
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
                              AddTripBloc.get(context).createTrip(DataOfTrip(
                                  typeOfTrips: data.id,
                                onlyWomen: 1,
                                fromPlace: getStartLocationThirdDesign.text,
                                maxDay: getEndDateThirdDesign.text,
                                  description:getDescriptionThirdDesign.text
                              ),data.id,context,_fileThirdDesign);
                            },
                            child: Text("أرسل طلبك", style: TextStyle(
                                color: Colors.white),),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ) :
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: MyTheme.mainAppBlueColor),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 11),
                                      controller: getStartLocationFourthDesign,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: " من مدينة"
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: MyTheme.mainAppBlueColor),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 11),
                                      controller: getEndLocationFourthDesign,
                                      decoration: InputDecoration.collapsed(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: " الي مدينة"
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("عدد الركاب ",style: TextStyle(fontSize: 12),),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: MyTheme.mainAppBlueColor),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 11),
                                      keyboardType: TextInputType.number,
                                      controller: getNumberFourthDesign,
                                      decoration: InputDecoration.collapsed(hintText: ''),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SimpleGroupedChips<int>(
                              controller: controllerFourthDesign,
                              itemTitle: [
                                "مطلوب سيارة كبيرة نقل",
                                "مطلوب سيارة عائلية",],
                              isScrolling: true,
                              values: [1,2],
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
                                controller: getDescriptionFourthDesign,
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
                              AddTripBloc.get(context).createTrip(DataOfTrip(
                                typeOfTrips: data.id,
                                  onlyWomen: 1,
                                fromPlace: getStartLocationFourthDesign.text,
                                toPlace: getEndLocationFourthDesign.text,
                                description: getDescriptionFourthDesign.text,
                                numberOfPassengers:int.parse(getNumberFourthDesign.text.toString())
                              ),data.id,context,null);
                            },
                            child: Text("أرسل طلبك", style: TextStyle(
                                color: Colors.white),),
                          ),
                          SizedBox(height: 10,)
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
}


