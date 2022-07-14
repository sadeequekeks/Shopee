import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/shared/data/models/api_response_model.dart';
import 'package:shopee/shared/data/models/login_model.dart';
import 'package:shopee/shared/global/global_var.dart';

class AuthService {
  Future<dynamic> login({required email, required password}) async {
    ApiResponseModel loginResponse;
    dynamic authResponse;
    try {
      loginResponse = await si.apiService.postRequest(
        'https://shoppeefy.herokuapp.com/api/users/login/',
        body: <String, dynamic>{'email': email, 'password': password},
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (loginResponse.statusCode == 200) {
        var decodedData = jsonDecode(loginResponse.body);
        var payLoad = decodedData;
        userObj = LoginModel.fromMap(payLoad);
        authResponse = userObj;
      } else {
        var data = jsonDecode(loginResponse.body);
        // var errorMessage = data['message'];
        authResponse = data['message'];
      }
    } on SocketException catch (e) {
      authResponse = e.message;
    }
    return authResponse;
  }

  //User Registeration

  Future signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String telephone,
    required String address,
    required String gender,
    required String password,
  }) async {
    ApiResponseModel sigupResponse;
    dynamic signUpMesaage;
    try {
      sigupResponse = await si.apiService.postRequest(
        'https://shoppeefy.herokuapp.com/api/users/register/',
        body: <String, dynamic>{
          "firstname": firstname,
          "lastname": lastname,
          "email": email,
          "telephone": telephone,
          "address": address,
          "gender": gender,
          "password": password,
        },
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (sigupResponse.statusCode == 200) {
        var decodedData = jsonDecode(sigupResponse.body);
        var payLoad = decodedData['message'];
        signUpMesaage = payLoad;
        return signUpMesaage;
      } else {
        var data = jsonDecode(sigupResponse.body);

        signUpMesaage = data['message'];
      }
    } on SocketException {
      signUpMesaage = 'Please Check your Internet Connection';
    } on TimeoutException catch (e) {
      signUpMesaage = e.message.toString();
    }
    return signUpMesaage;
  }
}
