import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/state_add_trip.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/more_info_add_trip.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/model/get-all-main-trip-categorires.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'bloc/bloc_add_trip.dart';

class AddTrip extends StatelessWidget {
  BuildContext context1;
  AddTrip(this.context1);
  int checkedIndex;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      AddTripBloc()
        ..getAllMainCat(),
      child: BlocConsumer<AddTripBloc, AddTripStates>(
        builder: (context, state) {
          return  CacheHelper.getData(key: "token")==null?
          Scaffold(
            appBar: AppBar(
              leading: TextButton(
                child: SVGIcons.barIcon,
                onPressed: () {
                },
              ),
              centerTitle: true,
              title: Text("اضافة رحله",style: TextStyle(fontFamily: "beIN"),),
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Go To Sing In First",style: TextStyle(color: MyTheme.mainAppBlueColor,
                      fontSize: 15,fontWeight: FontWeight.bold),),
                  SizedBox(height: 30,),
                  MaterialButton(
                    color: MyTheme.mainAppBlueColor,
                    onPressed: (){
                     /* pushNewScreen(
                        context,
                        screen: LoginScreen(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.scale,
                      );*/
                      Navigator.pushAndRemoveUntil(context1, MaterialPageRoute(builder: (context1)=>LoginScreen())
                          , (route) => false);
                    },
                  child: Text("Go",style: TextStyle(color: Colors.white
                  ),),
                  )
                ],
              ),
            ),
          ):
          Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text("أضافة طلب",style: TextStyle(color: Colors.white),),
            ),
            body: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Text("ماهي  نوع الرحلة  التي تريد الإعلان عنها  ؟", style:
                  TextStyle(
                      fontFamily: "beIN",
                      color: HexColor("#8CADC2"),
                      fontSize: 16
                  ),),
                  state is GetLoadingGetAllMainTripCategoriresStates
                      ? CircularProgressIndicator()
                      :
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return buildCard(context, index, AddTripBloc
                            .get(context)
                            .AllMainCat[index]);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget buildCard(context, int index, Data mainCat) {
    bool checked = index == checkedIndex;
    return GestureDetector(
      onTap: () {
        List<String> subsectionsString=[];
        mainCat.subsections.forEach((element) {
          subsectionsString.add(element.sectionName);
        });
        print(subsectionsString);
        if (AddTripBloc
            .get(context)
            .isBottomSheet) {
          AddTripBloc.get(context).changeBottomSheetState(false);
        }
        else {
          checkedIndex = index;

          scaffoldKey.currentState
              .showBottomSheet(
                (context) => addTaskBottomSheet(context,subsectionsString),
            elevation: 30,
          )
              .closed
              .then((value) {
            checkedIndex = index = null;
            AddTripBloc.get(context).changeBottomSheetState(false);
          });
          AddTripBloc.get(context).changeBottomSheetState(true);
        }
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2),
            child: Card(
              color: checked ?  MyTheme.mainAppBlueColor.
              withOpacity(.05): Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(mainCat.categorieName,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                      maxLines: 2,
                    ),
                    mainCat.photo == "" ? Container() : Image.network(
                      mainCat.photo, width: 50, height: 50,),
                    Text(mainCat.title,
                      style: TextStyle(color: MyTheme.mainAppBlueColorBright,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Offstage(
              offstage: !checked,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.check,
                  color: MyTheme.mainAppBlueColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addTaskBottomSheet(context,subsectionsString) {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          subsectionsString.length == 0 ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 30),
            child: Text("لا توجد أقسام فرعية"),
          ) : Container(
            height: 200,
            color: Colors.white,
            child:SingleChildScrollView(
              child: CheckboxGroup(
                  labels:subsectionsString,
                  onSelected: (List<String> checked) => print(checked.toString())
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              pushNewScreen(
                context,
                screen: MoreInfoAddTrip(AddTripBloc.get(context).AllMainCat[checkedIndex]),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
            color: MyTheme.mainAppBlueColor,
            child: Text("ارسال", style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }

}
