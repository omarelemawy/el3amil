import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/bloc/cubit_drawer.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/shared/Dialogs/SimpleIconDialog.dart';
import 'package:mosafer1/shared/Utils.dart';
import 'package:mosafer1/shared/styles/thems.dart';


class EditYourData extends StatelessWidget {
  var _genderValue = true;

   EditYourData({Key key}) : super(key: key);
  TextEditingController emailController=TextEditingController();
  TextEditingController nationalController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController passController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => DrawerCubit(),
        child: BlocConsumer<DrawerCubit, DrawerState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("تعديل بياناتك"),
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20,),
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              SizedBox(
                                height: 160,
                                width: size.width*0.8,
                                child: Card(
                                  color: Colors.grey[200],
                                  elevation: 10,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.person_add,color: Colors.grey,size: 90,),
                                      Text("ضع بطاقة هويتك هنا ..")
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                child:  ElevatedButton(onPressed: (){}, child: Icon(Icons.add),style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(MyTheme.mainAppBlueColor),
                                    shape: MaterialStateProperty.all(CircleBorder())
                                ),),
                                padding: const EdgeInsets.only(right: 60,top: 60),
                              )
                            ],
                          ),
                          SizedBox(height: 30,),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 50),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return  "*Required";
                                }
                                return null;
                              },
                              controller: nationalController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.perm_identity,color:  MyTheme.mainAppBlueColor,),
                                labelText: "رقم الهوية",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 50),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return  "*Required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email,color:  MyTheme.mainAppBlueColor,),
                                  labelText: "البريد الالكتروني",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 50),
                            child: TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return  "*Required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person,color:  MyTheme.mainAppBlueColor,),
                                  labelText: "الاسم",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 50),
                            child: TextFormField(
                              controller: passController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return  "*Required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock,color:  MyTheme.mainAppBlueColor,),
                                  labelText: "الرقم السري",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                            ),
                          ),
                          StatefulBuilder(builder: (context,state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Radio(value: true, groupValue: _genderValue, onChanged: (val){
                                      state(()=> _genderValue = val);
                                    }),
                                    Text("سيد")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(value: false, groupValue: _genderValue, onChanged: (val){
                                      state(()=> _genderValue = val);
                                    }),
                                    Text("سيدة")
                                  ],
                                )
                              ],
                            );
                          }),
                          SizedBox(height: 50,),
                          state is EditProfileLoadingStates?
                          Center(child: CircularProgressIndicator()):
                          Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: HexColor("#77975E"),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child:  ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(MyTheme.mainAppBlueColor),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                              ),
                              onPressed: (){
                                if(_formKey.currentState
                                    .validate()){
                                  DrawerCubit.get(context).editProfile(context,nameController.text,
                                      nationalController.text, 1, emailController.text,
                                      passController.text);

                                }
                                Utils().showMyDialog(SimpleIconDialog(title: "Hello",body: "تم  أرسال التعديل  أنتظر المراجعة والتأكيد",icon : Icon(Icons.credit_card)), context);
                              },
                              child: Text(
                                  "ارسال"
                                  ,style: TextStyle(
                                  fontFamily: "beIN",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
