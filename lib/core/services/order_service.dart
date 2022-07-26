import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/shared/data/models/api_response_model.dart';
import 'package:shopee/shared/global/global_var.dart';

class OrderService {
  Future placeOrder() async {
    ApiResponseModel orderResponse;
    dynamic orderMessage;

    try {
      orderResponse = await si.apiService.postList(
        'https://shoppeefy.herokuapp.com/api/orders/',
        body: orderedList.map((e) => e.toMap()).toList(),
        headers: {},
      );
      if (orderResponse.statusCode == 200) {
        var decodedData = jsonDecode(orderResponse.body);
        var payLoad = decodedData;
        orderMessage = payLoad;
        return orderMessage;
      } else {
        var data = jsonDecode(orderResponse.body);
        // print(orderedList.map((e) => e.toMap()).toList());
        orderMessage = data['message'];
      }
    } on SocketException {
      orderMessage = 'Please Check your Internet Connection';
    } on TimeoutException catch (e) {
      orderMessage = e.message.toString();
    }
    return orderMessage;
  }
}
