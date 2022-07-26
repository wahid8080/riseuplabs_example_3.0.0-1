
import 'dart:convert';
import 'dart:developer';
import 'package:emp/ApiConfig/ApiEndPoints.dart';
import 'package:emp/ApiConfig/api_response.dart';
import 'package:http/http.dart' as http;


class ApiController{

  Future<ApiResponse<dynamic>> getResponse({required String token,required String endPoint})async{

    final String url = ApiEndPoints().baseUrl+endPoint;
    final header ={
      'Accept': 'application/json',
      'Authorization': '$token'
    };

    try{
      return await http.get(Uri.parse(url),headers: header).then((value){
        log("${url} ${value.statusCode}");
        try{
          return responseDataPrepare(value: value);
        }catch(e){
          print(e);
          return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection');
        }
      });
    }catch(e){
      return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection');
    }
  }

  Future<ApiResponse<dynamic>> postRequest({String? token,required String endPoint,body})async{

    final String url = ApiEndPoints().baseUrl+endPoint;
    final header ={
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    
    var myBody = json.encode(body);

    try{
      return await http.post(Uri.parse(url),headers: header,body: myBody).then((value){
        log("${url} ${value.statusCode}");
        try{
          return responseDataPrepare(value: value);
        }catch(e){
          return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection');
        }
      });
    }
    catch(e){
      return ApiResponse(responseError: true,errorMessage: 'Something is wrong, Check internet connection');
    }
  }


  dynamic responseDataPrepare({required http.Response value}){
    switch(value.statusCode){
      case 200 :
        return ApiResponse(response: value.body,responseError: false, responseCode: value.statusCode);

      case 201 :
        return ApiResponse(response: value.body,responseError: false, responseCode: value.statusCode);

      case 405 :
        return ApiResponse(response: value.body,responseError: false, responseCode: value.statusCode);

      case 404 :
        return ApiResponse(responseError: true,errorMessage: 'Data Not Found', responseCode: value.statusCode);

      case 500 :
        return ApiResponse(responseError: true,errorMessage: 'Server Error', responseCode: value.statusCode);

      case 403 :
        return ApiResponse(responseError: true,errorMessage: '403 Forbidden', responseCode: value.statusCode);

      case 503 :
        return ApiResponse(responseError: true,errorMessage: 'Service Unavailable', responseCode: value.statusCode);

      case 504 :
        return ApiResponse(responseError: true,errorMessage: 'Gateway Timeout', responseCode: value.statusCode);

      case 401 :
        return ApiResponse(responseError: true,errorMessage: 'Unauthorized', responseCode: value.statusCode);

      default:
        return ApiResponse(responseError: true,errorMessage: 'Unknown Error');
    }
  }

}


