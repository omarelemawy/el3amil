import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'bloc/cubit.dart';
import 'bloc/state.dart';

class VerificationMessage extends StatelessWidget {

  String email;
  VerificationMessage(this.email);
  final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
  TextEditingController numController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>LoginBloc(),
        child: BlocConsumer<LoginBloc,LoginStates>(
          listener:(context,state){
            if(state is SendCodeErrorState)
            {
              keyScaffold.currentState.showSnackBar(SnackBar(content: Text(state.error))) ;
            }
          } ,
          builder: (context,state){
            return Scaffold(
                key:keyScaffold,
                body: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          color: HexColor("#77975E")
                      ),

                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(120),topLeft:  Radius.circular(120)),
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(height: 100,),
                            Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Image.asset("assets/logo1.png")
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text( "تم ارسال الكود الي الرقم التالي",style: TextStyle(color:
                                      HexColor("#649A3A"),
                                          fontSize: 14,fontWeight: FontWeight.bold)),
                                      Text( "Set Verification Code",style: TextStyle(color: Colors.deepOrangeAccent,
                                          fontSize: 20,)),
                                      SizedBox(height: 30,),
                                      Container(
                                        child:  PinCodeTextField(
                                          autofocus: true,
                                          controller: numController,
                                          highlight: true,
                                          highlightColor: Colors.blue,
                                          defaultBorderColor: Colors.black,
                                          hasTextBorderColor: Colors.green,
                                          highlightPinBoxColor: HexColor("#649A3A"),
                                          pinBoxWidth: 50,
                                          pinBoxHeight: 64,
                                          hasUnderline: true,
                                          wrapAlignment: WrapAlignment.spaceAround,
                                          pinBoxDecoration:
                                          ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                                          pinTextStyle: TextStyle(fontSize: 22.0),
                                          pinTextAnimatedSwitcherTransition:
                                          ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                                          pinTextAnimatedSwitcherDuration:
                                          Duration(milliseconds: 200),
//                    highlightAnimation: true,
                                          highlightAnimationBeginColor: Colors.black,
                                          highlightAnimationEndColor: Colors.white12,
                                          keyboardType: TextInputType.number,
                                          maxLength: 5,
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      state is SendCodeLoadingState?
                                      CircularProgressIndicator():Container(
                                        margin: EdgeInsets.only(top: 40),
                                        decoration: BoxDecoration(
                                            color: HexColor("#649A3A"),
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: MaterialButton(onPressed: (){
                                          LoginBloc.get(context).sendCode(email, context, numController.text);
                                        },child: Text( "Send",style: TextStyle(color: Colors.white,fontSize: 16),),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            );
          },
        )
    );
  }
}
