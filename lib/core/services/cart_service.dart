import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/shared/data/models/api_response_model.dart';
import 'package:shopee/shared/data/models/cart_model.dart';
import 'package:shopee/shared/global/global_var.dart';

class CartService {
  Future addToCart({
    required userId,
    required itemId,
    required cartItemName,
    required cartItemPrice,
    required itemShippingPrice,
    required cartItemQuantity,
    required cartItemImage,
  }) async {
    ApiResponseModel cartResponse;
    dynamic cartMessage;
    try {
      cartResponse = await si.apiService.postRequest(
        'https://shoppeefy.herokuapp.com/api/cart/',
        body: <String, dynamic>{
          "userID": userId,
          "itemID": itemId,
          "cartItemName": cartItemName,
          "cartItemPrice": cartItemPrice,
          "itemShippingPrice": itemShippingPrice,
          "cartItemQuantity": cartItemQuantity,
          "cartItemImage": cartItemImage,
        },
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (cartResponse.statusCode == 200) {
        var decodedData = jsonDecode(cartResponse.body);
        var payLoad = decodedData['message'];
        cartMessage = payLoad;
        final cart = CartModel(
            id: Random().nextDouble().toString(),
            userId: userId,
            itemId: itemId,
            cartItemName: cartItemName,
            cartItemPrice: cartItemPrice,
            itemShippingPrice: itemShippingPrice,
            cartItemQuantity: cartItemQuantity,
            cartItemImage: cartItemImage,
            v: 0);
        return cartMessage;
      } else {
        var data = jsonDecode(cartResponse.body);

        cartMessage = data['message'];
      }
    } on SocketException {
      cartMessage = 'Please Check your Internet Connection';
    } on TimeoutException catch (e) {
      cartMessage = e.message.toString();
    }
    return cartMessage;
  }

  Future<List<CartModel>> getAllCart({required userID}) async {
    List<CartModel> carts = [];
    try {
      await si.apiService
          .getRequest(
              endpoint: 'https://shoppeefy.herokuapp.com/api/cart/user/$userID')
          .then((value) {
        if (value.statusCode == 200) {
          for (dynamic item in value.body) {
            CartModel cart = CartModel(
              id: item['_id'],
              userId: item['userID'],
              itemId: item['itemID'],
              cartItemName: item['cartItemName'],
              cartItemPrice: item['cartItemPrice'],
              itemShippingPrice: item['itemShippingPrice'],
              cartItemQuantity: item['cartItemQuantity'],
              cartItemImage: item['cartItemImage'],
              v: item['__v'],
            );
            carts.add(cart);
            cartState.addtoCart(cart);
          }
        } else {
          print(value.body);
          carts = [];
        }
      });
    } on SocketException {
      carts = [];
      // si.dialogService.showToast('Please Check your Internet Connection');
    } on TimeoutException catch (e) {
      carts = [];
      // si.dialogService.showToast(e.message.toString());
    }
    return carts;
  }

  // totally cart amount
  Future<int> getTotalCartAmount() async {
    int sum = 0;
    await getAllCart(userID: userObj.user.id).then((value) {
      for (CartModel cart in value) {
        sum += int.parse(cart.cartItemPrice);
      }
    });
    return sum;
  }

  //delete cart item

  Future<String?> deleteCart({required itemId}) async {
    String? cartMessage;
    try {
      final res = await si.apiService.deleteRequest(
          endpoint: 'https://shoppeefy.herokuapp.com/api/cart/$itemId');
      if (res.statusCode == 200) {
        cartMessage = res.body;
      } else {
        cartMessage = 'Error deleting Cart Item';
      }
    } on SocketException {
      cartMessage = 'Check your connection';
      // si.dialogService.showToast('Please Check your Internet Connection');
    } on TimeoutException catch (e) {
      cartMessage = e.message.toString();
      // si.dialogService.showToast(e.message.toString());
    }
    return cartMessage;
  }
}
