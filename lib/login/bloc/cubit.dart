import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/login/bloc/state.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';

import '../more_register_info.dart';
import '../verification_message.dart';


class LoginBloc extends Cubit<LoginStates>{
  LoginBloc() : super(InitialLoginStates());
  static LoginBloc get(context) => BlocProvider.of(context);
  bool valueSwitch = false;
  SingingCharacter character = SingingCharacter.Male;
  Future<bool> loginUser(context,email,pass) async {
    emit(LoginLoadingState());
    var APIURL = Uri.parse('https://msafr.we-work.pro/api/user/login');
    Map mapData = {
      'phone': email,
      'password': pass,
    };
    http.Response response = await http.post(APIURL, body: mapData);
    var data = jsonDecode(response.body);
    if (data["status"] == true ) {
      emit(LoginSuccessState());
      var token = data['msg']['token'];
      var id = data['msg']['id'];
      var name = data['msg']['name'];
      var photo = data['msg']['photo'];
      print("User : Token $token , id $id ");
      CacheHelper.saveData(key: 'token', value: token);
      CacheHelper.saveData(key: 'id', value: id);
      CacheHelper.saveData(key: 'name', value: name);
      CacheHelper.saveData(key: 'photo', value: photo);
      print("true");

      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) =>
       HomeScreen()), (context) => false);
      return true;
    } else
    {
      print(response.body);
      emit(LoginErrorState("تأكد من ادخال رقم هاتف ورقم مرور صحيح"));
      return false;
    }
  }
  void getImage()
  {
    emit(RegisterGetImageState());
  }
  void getUserImage()
  {
    emit(RegisterGetUserImageState());
  }
  void getCarImage1()
  {
    emit(RegisterGetCar1ImageState());
  }
  void getCarImage2()
  {
    emit(RegisterGetCar2ImageState());
  }
  void getCarImage3()
  {
    emit(RegisterGetCar3ImageState());
  }
  void getImageNat()
  {
    emit(RegisterGetCar4ImageState());
  }
  void getImagePer()
  {
    emit(RegisterGetCar5ImageState());
  }
  changeSwitchValue(value)
  {
    valueSwitch=value;
    emit(ChangeSwitchValueState());
  }
  Future<http.StreamedResponse> uploadFile(filePath, context, name,
      email, phone, password,gender,country_code) async {
    emit(RegisterLoadingState());
    Map<String, String> postBody = {
      'email': email,
      'phone': phone,
      'name': name,
      'gender': gender,
      'password': password,
      'country_code':country_code
    };
    var APIURL = Uri.parse('https://msafr.we-work.pro/api/masafr/create-account');
    var request =  http.MultipartRequest("POST", APIURL);
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'photo', filePath.path);
    request.files.add(multipartFile);
    request.fields.addAll(postBody);
    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      var data = jsonDecode(value);
      if (data["status"] == true) {
        print(value);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
            (context)=>VerificationMessage(email))
            , (route) => false);
        emit(RegisterSuccessState());
      }
      else {
        print(response.statusCode);
        print(data["msg"]);
        emit(RegisterErrorState(data["msg"]));
      }
    });

    return response;
  }
  void changeGender(SingingCharacter value)
  {
    character = value;
    emit(ChangeGenderRegisterState());
  }
  Future<http.StreamedResponse> sendCode(email,context,code) async {
    emit(SendCodeLoadingState());
    Map<String, String> postBody = {
      'email': email,
      'code': code
    };
    var APIURL = Uri.parse('https://chefkhalil.com/api/register/2');
    var request =  http.MultipartRequest("POST", APIURL);
    request.fields.addAll(postBody);
    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      var data = jsonDecode(value);
      if (data["msg"] == "User Data has been updated ! ") {
        emit(SendCodeSuccessState());
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>MoreRegisterInfo()),
                (route) => false);
      }
      else {
        data = jsonDecode(value);
        emit(SendCodeErrorState(data["msg"]));
      }
    });

    return response;
  }
}
enum SingingCharacter { Male, FeMale }