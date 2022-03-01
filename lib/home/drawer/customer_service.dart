import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/drawer/bloc/cubit_drawer.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class CustomerService extends StatelessWidget {
   CustomerService({Key key}) : super(key: key);
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
   File _file;
   Future getFile() async {
     FilePickerResult result = await FilePicker.platform.pickFiles();
     if(result != null) {
       _file = File(result.files.single.path.toString());
     } else {
     }
   }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context)=>DrawerCubit(),
        child: BlocConsumer<DrawerCubit,DrawerState>(
         builder: (context,state){
           return Scaffold(
             appBar: AppBar(
               title:Text("خدمة العملاء",
                 style: TextStyle(color: Colors.white),
               ),
               centerTitle: true,
             ),
             body: SingleChildScrollView(
               child: Container(
                 padding: EdgeInsets.symmetric(horizontal: 30),
                 width: double.infinity,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(height: 70,),
                     TextFormField(
                       controller: emailController,
                       decoration: InputDecoration(
                           contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                           labelText: "الاسم",
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20)
                           )
                       ),
                     ),
                     SizedBox(height: 20,),
                     TextFormField(
                       controller: passController,
                       decoration: InputDecoration(
                           contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                           labelText: "البريد",
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20)
                           )
                       ),
                     ),
                     SizedBox(height: 20,),
                     TextFormField(
                       controller: passController,
                       decoration: InputDecoration(
                           contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                           labelText: "عنوان الرساله",
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20)
                           )
                       ),
                     ),
                     SizedBox(height: 20,),
                     TextFormField(
                       controller: passController,
                       decoration: InputDecoration(
                           contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                           labelText: "نص الرساله",
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20)
                           )
                       ),
                     ),
                     SizedBox(height: 20,),
                     GestureDetector(
                       onTap: (){
                         getFile().then((value) {
                           DrawerCubit.get(context).getImage();
                         });
                       },
                       child:Container(
                         width: double.infinity,
                         height: 100,
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           border: Border.all(color: MyTheme.mainAppBlueColor,width: 1),
                         ),
                         child: _file ==null? Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Container(
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: MyTheme.mainAppBlueColor
                               ),
                               child: Icon(Icons.add,color: Colors.white,),
                             ),
                             SizedBox(width: 10,)
                           ],
                         ):
                         Image.file(_file,fit: BoxFit.cover,)
                         ,
                       ),
                     ),
                     SizedBox(height: 30,),
                     Container(
                       height: 40,
                       width: double.infinity,
                       decoration: BoxDecoration(
                           color: MyTheme.mainAppBlueColor,
                           borderRadius: BorderRadius.circular(20)
                       ),
                       child:  MaterialButton(
                         onPressed: (){
                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                               (context)=> HomeScreen()), (route) => false);
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
                   ],
                 ),
               ),
             ),
           );
         },
         listener: (context,state){},
        ),
      ),
    );
  }
}
