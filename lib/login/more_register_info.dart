import 'dart:io';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'bloc/cubit.dart';
import 'bloc/state.dart';



class MoreRegisterInfo extends StatelessWidget {
   MoreRegisterInfo({Key key}) : super(key: key);
  TextEditingController emailController=TextEditingController();
  TextEditingController nationalNumberController=TextEditingController();
  TextEditingController carCardController=TextEditingController();
  TextEditingController carModeController=TextEditingController();
  TextEditingController carNameController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
   File _file;
   File _file1;
   File _file2;
   File _file3;
   File _fileGetImageNat;
   File _fileGetImagePerm;
   Future getFile(i) async {
     FilePickerResult result = await FilePicker.platform.pickFiles();
     if(result != null) {
       switch(i){
         case 1:
           _file = File(result.files.single.path.toString());
           break;
         case 2:
           _file1 = File(result.files.single.path.toString());
           break;
         case 3:
           _file2 = File(result.files.single.path.toString());
           break;
         case 4:
           _file3 = File(result.files.single.path.toString());
           break;
         case 5:
           _fileGetImageNat = File(result.files.single.path.toString());
           break;
         case 6:
           _fileGetImagePerm = File(result.files.single.path.toString());
           break;
       }
     } else
       {
       }
   }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>LoginBloc(),
        child: BlocConsumer<LoginBloc,LoginStates>(
          listener:(context,state){} ,
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 80,),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      getFile(1).then((value) {
                                        LoginBloc.get(context).getUserImage();
                                      });
                                    },
                                    child: Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundImage:_file==null? AssetImage("assets/man.png"):FileImage(_file),
                                          backgroundColor: Colors.grey[300],
                                        ),
                                        Icon(Icons.cloud_upload_rounded,color: HexColor("#638462"),size: 30,)
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    child: Text("أرفع صورة حقيقة لتصبح مسافر موثوق",
                                      style: TextStyle(
                                          fontFamily: "beIN",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor("#638462")
                                      ),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      getFile(2).then((value) {
                                        LoginBloc.get(context).getCarImage1();
                                      });
                                    },
                                    child: Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundImage:_file1==null? AssetImage("assets/circle.jpg"):
                                          FileImage(_file1),
                                          backgroundColor: Colors.grey[300],
                                          child: _file1!=null?Container():Center(child:
                                          Text("السيارة مع اللوحة",style: TextStyle(fontSize: 11),)),
                                        ),
                                        Icon(Icons.add,color: HexColor("#638462"),size: 30,)
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      getFile(3).then((value) {
                                        LoginBloc.get(context).getCarImage2();
                                      });
                                    },
                                    child: Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundImage:_file2==null? AssetImage("assets/circle.jpg"):FileImage(_file2),
                                          backgroundColor: Colors.grey[300],
                                          child: _file2!=null?Container():Center(child: Text("صورة للسياره",
                                              style: TextStyle(fontSize: 12))),
                                        ),
                                        Icon(Icons.add,color: HexColor("#638462"),size: 30,)
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      getFile(4).then((value) {
                                        LoginBloc.get(context).getCarImage3();
                                      });
                                    },
                                    child: Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundImage:_file3==null? AssetImage("assets/circle.jpg"):FileImage(_file3),
                                          backgroundColor: Colors.grey[300],
                                          child: _file3!=null?Container():Center(child: Text("صورة للسياره",
                                              style: TextStyle(fontSize: 12))),
                                        ),
                                        Icon(Icons.add,color: HexColor("#638462"),size: 30,)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Nationality :",style: TextStyle(
                                    color: Colors.green
                                  ),),
                                  CountryListPick(
                                      appBar: AppBar(
                                        backgroundColor: Colors.blue,
                                        title: Text('Choisir un pays'),
                                      ),
                                      theme: CountryTheme(
                                        isShowFlag: true,
                                        isShowTitle: true,
                                        isShowCode: true,
                                        isDownIcon: true,
                                        showEnglishName: true,
                                      ),
                                      // Set default value
                                      initialSelection: '+966',
                                      // or
                                      // initialSelection: 'US'
                                      onChanged: (CountryCode code) {
                                        print(code.name);
                                        print(code.code);
                                        print(code.dialCode);
                                        print(code.flagUri);
                                      },
                                      // Whether to allow the widget to set a custom UI overlay
                                      useUiOverlay: true,
                                      // Whether the country list should be wrapped in a SafeArea
                                      useSafeArea: false
                                  ),
                                ],
                              ),
                              Container(
                                height: 50,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return  "*Required";
                                    }
                                    return null;
                                  },
                                  controller: nationalNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "National Number",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .26,
                                    height: 50,
                                    child: TextFormField(
                                      controller: carCardController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return  "*Required";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: "Name",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          )
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .3,
                                    height: 50,
                                    child: TextFormField(
                                      controller: carModeController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return  "*Required";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: "Name",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          )
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .3,
                                    height: 50,
                                    child: TextFormField(
                                      controller: carNameController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return  "*Required";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: "Name",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                onTap: (){
                                  getFile(5).then((value) {
                                    LoginBloc.get(context).getImageNat();
                                  });
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  margin: EdgeInsets.symmetric(horizontal:50),
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: _fileGetImageNat ==null?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: Icon(Icons.add,color:
                                          Colors.white,size: 30,),
                                         decoration: BoxDecoration(
                                           color: Colors.green,
                                           shape: BoxShape.circle
                                         ),
                                      ),
                                      Text("أرفع صورة الهوية او الإقامة او الجواز",style: TextStyle(color: Colors.grey),)
                                    ],
                                  ):Image.file(_fileGetImageNat,fit: BoxFit.cover,),
                                ),
                              ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                onTap: (){
                                  getFile(6).then((value)
                                  {
                                    LoginBloc.get(context).getImageNat();
                                  }
                                  );
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  margin: EdgeInsets.symmetric(horizontal:50),
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child:_fileGetImagePerm ==null?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Icon(Icons.add,color:
                                        Colors.white,size: 30,),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle
                                        ),
                                      ),
                                      Text("أرفع صورة الإستمارة أو الرخصة",style: TextStyle(color: Colors.grey),)
                                    ],
                                  ):
                                  Image.file(_fileGetImagePerm,fit: BoxFit.cover,)
                                ),
                              ),
                              SizedBox(height: 10,),
                              state is RegisterLoadingState?
                              CircularProgressIndicator(
                                color: HexColor("#77975E"),
                              ):
                              Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: HexColor("#77975E"),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child:  MaterialButton(
                                  onPressed: (){
                                    if (LoginBloc.get(context)
                                        .valueSwitch) {

                                        if (_formKey.currentState
                                            .validate() &&
                                            _file != null) {
                                         /* LoginBloc.get(context)
                                              .uploadFile(
                                              _file,
                                              context,
                                              nameController.text,
                                              emailController.text,
                                              phoneController.text,
                                              passController.text,
                                              LoginBloc.get(context).character
                                                  == SingingCharacter.Male? "0" : "1",
                                          );*/
                                        } else {
                                          keyScaffold.currentState
                                              .showSnackBar(const
                                          SnackBar(content: Text(
                                            "Please Choose Image",
                                            style:
                                            TextStyle(color: Colors
                                                .white),),
                                            backgroundColor: Colors
                                                .blue,));
                                        }

                                    }else{
                                      keyScaffold.currentState
                                          .showSnackBar(
                                          SnackBar(content: Text(
                                            "Agree to the terms and conditions",
                                            style:
                                            const TextStyle(color: Colors
                                                .white),),
                                            backgroundColor: Colors
                                                .blue,));
                                    }
                                  },
                                  child: Text(
                                      "Send"
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
                    )
                  ],
                )
            );
          },
        )
    );
  }

}
