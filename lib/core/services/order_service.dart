import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/shared/data/models/all_order_model.dart';
import 'package:shopee/shared/data/models/api_response_model.dart';
import 'package:shopee/shared/data/models/order_model.dart';
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

  //get all orders
  Future<List<AllOrderModel>> getAllOrder() async {
    List<AllOrderModel> allOrders = [];
    try {
      await si.apiService
          .getRequest(endpoint: 'https://shoppeefy.herokuapp.com/api/orders/')
          .then(
        (value) {
          if (value.statusCode == 200) {
            for (var item in value.body) {
              AllOrderModel order = AllOrderModel(
                id: item['_id'],
                userId: item['userID'],
                itemId: item['itemID'],
                itemImage: item['itemImage'],
                itemName: item['itemName'],
                itemQuantity: item['itemQuantity'],
                itemPrice: item['itemPrice'],
                dateOrdered: item['dateOrdered'],
                receiverName: item['receiverName'],
                receiverAddress: item['receiverAddress'],
                receiverNo: item['receiverNo'],
                completed: item['completed'],
              );
              allOrders.add(order);
              lateOrderList.add(order);
            }
          } else {
            allOrders = [];
          }
        },
      );
    } on SocketException {
      allOrders = [];
      // si.dialogService.showToast('Please Check your Internet Connection');
    } on TimeoutException catch (e) {
      allOrders = [];
      // si.dialogService.showToast(e.message.toString());
    }
    return allOrders;
  }
}
