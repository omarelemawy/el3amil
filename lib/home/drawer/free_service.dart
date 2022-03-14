import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/bloc/cubit_drawer.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class FreeServiceScreen extends StatefulWidget {
  const FreeServiceScreen({Key key}) : super(key: key);

  @override
  _FreeServiceScreenState createState() => _FreeServiceScreenState();
}

class _FreeServiceScreenState extends State<FreeServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>DrawerCubit()..getAllFreeService(),
    child: BlocConsumer<DrawerCubit,DrawerState>(
      builder: (context,state){
        List<FreeServiceModel> allRequestsSe = DrawerCubit.get(context).allFreeService;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("رحلات مجانيه"),
          ),
          body: state is GetLoadingFreeServiceModelStates?
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
                                      allRequestsSe[index].masafr==null?
                                      ClipOval(
                                        child: Image.asset(
                                          "assets/man.png",
                                          height: 50,
                                          width: 50,
                                        ),
                                      ):
                                      ClipOval(
                                        child: FadeInImage.assetNetwork(
                                          height: 50,
                                          width: 50,
                                          placeholderCacheHeight: 050,
                                          placeholderCacheWidth: 50,
                                          fit: BoxFit.cover,
                                          placeholderFit: BoxFit.cover,
                                          placeholder: "assets/man.png",
                                          image: allRequestsSe[index].masafr.photo,
                                          imageErrorBuilder: (context,o,c)=>ClipOval(
                                            child: Image.asset(
                                              "assets/man.png",
                                              height: 50,
                                              width: 50,
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
                                    initialRating: allRequestsSe[index].masafr
                                        != null ? int.parse(allRequestsSe[index].masafr.rate).toDouble() : 1.0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 10,
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
                                          child: Text(allRequestsSe[index].masafr==null?"":
                                          allRequestsSe[index].masafr.name,
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
                                        Text("الوصف"),
                                        Icon(Icons.chevron_right_rounded),
                                        Text(allRequestsSe[index].description==null?"":
                                        allRequestsSe[index].description,
                                          style: TextStyle(fontFamily: "beIN",
                                              fontWeight: FontWeight.bold,
                                              color:HexColor("#707070")
                                          ),),

                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: MyTheme.mainAppBlueColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(allRequestsSe[index].type,style:
                                      TextStyle(color: Colors.white),),
                                    )
                                  ],
                                ),
                              ),
                              allRequestsSe[index].masafr==null?
                              ClipRRect(
                                child: Image.asset(
                                  "assets/placeholder2.jpg",
                                  height: 80,
                                  width: 100,
                                ),
                              ):
                              ClipRRect(
                                child: FadeInImage.assetNetwork(
                                  height: 80,
                                  width: 100,
                                  placeholderCacheHeight: 80,
                                  placeholderCacheWidth: 100,
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.cover,
                                  placeholder: "assets/placeholder2.jpg",
                                  image: allRequestsSe[index].photo,
                                  imageErrorBuilder: (context,o,c)=>ClipRRect(
                                    child: Image.asset(
                                      "assets/placeholder2.jpg",
                                      height: 80,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
      listener: (context,state)
      {},
    )
    );
  }
}
