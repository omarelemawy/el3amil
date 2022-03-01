import 'package:flutter/material.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class SimpleIconDialog extends StatelessWidget {
  final Widget icon;
  final String title;
  final String body;
  const SimpleIconDialog({Key key, this.icon, this.title, this.body}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: size.width,
            margin: const EdgeInsets.only(left: 40,right: 40,top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Icon(Icons.close,color: MyTheme.mainAppBlueColorBright,),style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all( Colors.white),
                  shape: MaterialStateProperty.all(CircleBorder()),
                ),),
                Padding(
                  child:   Align(
                    child: Text(body,style: TextStyle(color: Colors.white),),
                    alignment: Alignment.center,
                  ),
                  padding: const EdgeInsets.only(bottom: 30,top: 20),
                )
              ],
            ),
            padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 20),
            decoration: BoxDecoration(
                color: MyTheme.mainAppBlueColorBright,
                borderRadius: BorderRadius.circular(15)
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: icon,
          )
        ],
    ),
      ),);
  }
}
