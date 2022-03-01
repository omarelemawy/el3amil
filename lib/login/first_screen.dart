import 'package:flutter/material.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:hexcolor/hexcolor.dart';
import 'login.dart';
import 'onBoarding_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      Widget widget;

      if(CacheHelper.getData(key: "onBoarding") != null)
      {
    if(CacheHelper.getData(key: "token")!=null)
    {
      widget = HomeScreen();
      }else{
       widget =HomeScreen();
      }
       }else {
       widget = OnBoardingScreen();
       }
    return Scaffold(
      backgroundColor:  Colors.white,
      body:  SplashScreenView(
        navigateRoute: widget,
        duration: 4000,
        imageSize: 130,
        pageRouteTransition: PageRouteTransition.SlideTransition,
        imageSrc: "assets/firstScreen.jpg",
        text: "مسافر",
        textStyle: TextStyle(fontFamily: "beIN",color: HexColor("#1B2B5D"),
            fontWeight: FontWeight.bold,fontSize: 20,),
        backgroundColor: Colors.white,
        textType:  TextType.ColorizeAnimationText,
      )
    );
  }
}

