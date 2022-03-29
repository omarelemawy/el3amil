import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/drawer/drawer.dart';
import 'package:mosafer1/home/first_screen/notifi_nav/bloc/bloc_notifi.dart';
import 'package:mosafer1/home/first_screen/notifi_nav/bloc/state_notifi.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/shared/Widgets/CustomAppBar.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';


class NotifiNav extends StatefulWidget {
  BuildContext context1;
   NotifiNav(this.context1);

  @override
  _NotifiNavState createState() => _NotifiNavState();
}

class _NotifiNavState extends State<NotifiNav> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                "اذهب لتسجيل الدخول اولا",
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
                      widget.context1,
                      MaterialPageRoute(
                          builder: (context1) => LoginScreen()),
                          (route) => false);
                },
                child: Text(
                  "اذهب ",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    ):Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context)=>NotifiBloc()..getAllNotifications(1),
          child: BlocConsumer<NotifiBloc,NotifiStates>(
            builder: (context,state){
              var notifiBloc=NotifiBloc.get(context);
              print(state);
              if(state is LoadingNotifications) {
                return Center(child: CircularProgressIndicator(),);
              }else if(state is LoadedNotifications) {
                return notifiBloc.notifications.isEmpty?
                    Center(child: Text("لايوجد أشعارات",style: TextStyle(fontSize: 17),)):
                ListView.separated(
                  itemCount: notifiBloc.notifications.length,
                  itemBuilder: (context,index) => ListTile(
                    title: Text(notifiBloc.notifications[index].title),
                    subtitle: Text(notifiBloc.notifications[index].subject,style: TextStyle(color: Colors.black),),
                    trailing: Text(notifiBloc.notifications[index].time),
                  ),
                  separatorBuilder: (context,index)=> Divider(indent: 10,endIndent: 10,),
                );
              }
              return CircularProgressIndicator();
            },
            listener: (context,state){},
          ),
        ),
      ),
    );
  }
}
