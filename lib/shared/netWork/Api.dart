import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';

class HttpOps {
  String _token;

  HttpOps() {
    _token = CacheHelper.getData(key: "token");
  }

  Future<GetAllRequestServicesModel> postData(
      {String endPoint, Map mapData, bool auth = true}) async {
    print("xxxxxxxxxxxxxxx"+CacheHelper.getData(key: "token").toString());
    http.Response response = await http.post(Uri.parse(mainUrl + endPoint),
        body: json.encode(mapData), headers: auth ? {
          "Content-Type": "application/json; charset=UTF-8",
          "authToken": CacheHelper.getData(key: "token"),
    } : {});
    print("Response data : ${response.body}");
    return GetAllRequestServicesModel.fromJson(json.decode(response.body));
  }

  Future<GetAllRequestServicesModel> getData(
      {String endPoint, bool auth = true})
  async {
    http.Response response = await http.get(Uri.parse(mainUrl + endPoint),
        headers: auth ? {
          "Content-Type": "application/json; charset=UTF-8",
          "authToken": _token,
        } : {});
    print("Response data : ${response.body}");
    return GetAllRequestServicesModel.fromJson(json.decode(response.body));
  }
}
