import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/Fatorah/bloc/cubit.dart';
import 'package:mosafer1/home/BottomNavigation/bloc/bloc_chat.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/bloc_chat.dart';
import 'package:mosafer1/home/first_screen/notifi_nav/bloc/bloc_notifi.dart';
import 'package:mosafer1/login/first_screen.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';

import 'home/first_screen/Search/bloc/searchCubit.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(create: (context) => ChatBloc(),),
        BlocProvider<BottomNavigationBloc>(create: (context) => BottomNavigationBloc(),),
        BlocProvider<FatorahCubit>(create: (context) => FatorahCubit(),),
        BlocProvider<NotifiBloc>(create: (context) => NotifiBloc(),),
        BlocProvider<SearchCubit>(create: (context) => SearchCubit(),),
      ],
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: MyTheme.themeLight(),
        debugShowCheckedModeBanner: false,
        home: FirstScreen()
    );
  }
}
