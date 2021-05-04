import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/UI/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/UI/Intro/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkUtil {
  var _scafold;
  var context;
  bool networkError ;

  NetworkUtil(this._scafold, this.networkError, this.context);

  SharedPreferences _prefs;

  NetworkUtil.internal();

  Dio dio = Dio();

  Future<Response> get(String url, {Map headers}) async {
    var response;
    try {
//https://cashpoint21.com/
      dio.options.baseUrl = "https://app.cashpoint21.com/api/v1/";
//      dio.options.baseUrl = "https://cashpoint21.com/api/v1/";
//    dio.options.baseUrl = "http://demo.easymenu.site/api/v1/";
      response = await dio.get(url, options: Options(headers: headers));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse(response);
  }

  Future<Response> post(String url,
      {Map headers, FormData body, encoding}) async {
    var response;
    dio.options.baseUrl = "https://app.cashpoint21.com/api/v1/";
//    dio.options.baseUrl = "https://cashpoint21.com/api/v1/";

//    dio.options.baseUrl = "http://demo.easymenu.site/api/v1/";
    try {
      response = await dio.post(url,
          data: body,
          options: Options(headers: headers, requestEncoder: encoding));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse(response);
  }

  var connectivityResult;
  connectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult;
  }

  Future<Response> handleResponse(Response response) async {
    if (await connectivity() == ConnectivityResult.mobile) {
      try {
        print("status code >>>>>>>>> ${response.statusCode}");
        if (response.statusCode == 200) {
          print("correrct request handleResponse : " + response.toString());
          return response;
        }else if(response.statusCode == 401){
          _prefs = await SharedPreferences.getInstance();
          _prefs.clear();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(
                  builder: (_)=> SplashScreen()
              ), (route) => false);
        } else {
          print("request error handleResponse : " + response.toString());
          if (networkError == null) {
            LoadingDialog(_scafold,context).showAlert("error");
            print("gwaaaaaaaaaaaaaaaaaaa handleResponse");
          }
          return response;
        }
      } on SocketException catch (e) {
        print('not connected');
        LoadingDialog(_scafold,context).showAlert("${e.message}");
        print("baraaaaaaaaaaaaaa we gwa handleResponse");
      }
    } else if (await connectivity() == ConnectivityResult.wifi) {
      try {
        if (response.statusCode == 200) {
          print("correrct request handleResponse : " + response.toString());

          return response;
        }else if(response.statusCode == 401){
          _prefs = await SharedPreferences.getInstance();
          _prefs.clear();

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(
                  builder: (_)=> SplashScreen()
              ), (route) => false);
        } else {
          print("request error handleResponse: " + response.toString());
          if (networkError == null) {
            LoadingDialog(_scafold,context).showAlert("error");
          }
          return response;
        }
      } on SocketException catch (e) {
        LoadingDialog(_scafold,context).showAlert("${e.message}");
      }
    } else {
      if (networkError == null) {
        LoadingDialog(_scafold,context).showAlert("no internet");
      }
    }
  }
}
