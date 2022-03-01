import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/drawer/drawer.dart';
import 'package:mosafer1/home/first_screen/notifi_nav/bloc/bloc_notifi.dart';
import 'package:mosafer1/home/first_screen/notifi_nav/bloc/state_notifi.dart';
import 'package:mosafer1/shared/Widgets/CustomAppBar.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';


class NotifiNav extends StatefulWidget {
  BuildContext context1;
   NotifiNav(this.context1);

  @override
  _NotifiNavState createState() => _NotifiNavState();
}

class _NotifiNavState extends State<NotifiNav> {
  NotifiBloc notifiBloc;
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifiBloc = BlocProvider.of<NotifiBloc>(context);
      notifiBloc.getAllNotifications(1);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<NotifiBloc,NotifiStates>(
          builder: (context,state){
            print(state);
            if(state is LoadingNotifications) {
              return Center(child: CircularProgressIndicator(),);
            }else if(state is LoadedNotifications) {
              return ListView.separated(
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
    );
  }
}
