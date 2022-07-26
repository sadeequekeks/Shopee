import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopee/core/helper/helper_functions.dart';
import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/shared/data/models/product_model.dart';
import 'package:shopee/shared/global/global_var.dart';
import 'package:http/http.dart' as http;

import '../../../shared/data/models/order_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Helper _helper = Helper();

  @override
  void initState() {
    si.cartService.getAllCart(userID: userObj.user.id).then((value) {
      cartState.addMultiItemToCart(value);
    });
    plugin.initialize(publicKey: publicKey);
    super.initState();
  }

  @override
  void dispose() {
    cartState.addedCartItem.clear();
    super.dispose();
  }

  var publicKey = 'pk_test_2361435992e926ef4b4a0a0a076f36d4aff4a0a9';
  final plugin = PaystackPlugin();

  String _getReference() {
    var platform = (Platform.isAndroid) ? 'Android' : 'iOS';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // add cart item to order list
  void orderListtoDb() async {
    List<OrderModel> ordereddd = [];
    for (dynamic item in orderCart) {
      OrderModel orderss = OrderModel(
        userId: item.userId,
        itemId: item.itemId,
        itemImage: item.cartItemImage,
        itemName: item.cartItemName,
        itemQuantity: item.cartItemQuantity,
        itemPrice: item.cartItemPrice,
        dateOrdered: DateTime.now().toIso8601String(),
        receiverName: '${userObj.user.firstname} ${userObj.user.lastname}',
        receiverAddress: userObj.user.address,
        receiverNo: userObj.user.telephone,
        completed: "False",
      );
      ordereddd.add(orderss);
    }
    var _uri = Uri.parse('https://shoppeefy.herokuapp.com/api/orders/');
    var res = await http.post(
      _uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(ordereddd.map((e) => e.toMap()).toList()),
    );
    if (res.statusCode == 200) {
      si.apiService.deleteRequest(
          endpoint:
              'https://shoppeefy.herokuapp.com/api/cart/clearcart/${userObj.user.id}');
    }
  }

  chargeCard({
    required int total,
    required String name,
  }) async {
    var charge = Charge()
      ..amount = total
      ..reference = _getReference()
      ..email = name;

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );

    if (response.status == true) {
      orderListtoDb();
      _showMessage('You\'ve successfully placed your order!');
    } else {
      _showMessage('Payment Failed!!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 30.0),
                child: Text(
                  "CART",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                )),
            // cartState.addedCartItem.isEmpty
            //     ? const Center(
            //         child: Text('No Items in Cart'),
            //       )
            //     :
            Observer(
              builder: (_) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: cartState.addedCartItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      // CartModel cart = snapshot.data![index];
                      final item = cartState.addedCartItem[index];
                      // cartObj = item;
                      return Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                right: 30.0, bottom: 10.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(5.0),
                              elevation: 3.0,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 80,
                                      child: Image(
                                        image: NetworkImage(
                                          'https://shoppeefy.herokuapp.com${item.cartItemImage}',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item.cartItemName,
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            'x${item.cartItemQuantity}',
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            _helper.formattNumber(
                                              int.parse(item.cartItemPrice),
                                            ),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 15,
                            child: Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                padding: const EdgeInsets.all(0.0),
                                color: Colors.amber,
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text('Delete Item'),
                                            content: const Text(
                                                'Are you sure you want to delete this item ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await si.cartService
                                                      .deleteCart(
                                                          itemId: item.id);
                                                  cartState
                                                      .deleteFromCart(item);
                                                  Navigator.pop(context, 'OK');
                                                },
                                                child: const Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.amberAccent),
                                                ),
                                              ),
                                            ],
                                          ));
                                  // si.cartService.deleteCart(itemId: item.id);
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                );
              },
            ),
            FutureBuilder<List<ProductModel>>(
                future: si.productService.getAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitThreeBounce(
                        color: Colors.transparent,
                        size: 50.0,
                      ),
                    );
                  }
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Shipping Fee      \$50",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Cart Subtotal     ${_helper.formattNumber(cartState.cartItemSum())}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            height: 50.0,
                            color: Colors.amber,
                            child: Text(
                              "Secure Checkout".toUpperCase(),
                              style: const TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              chargeCard(
                                total: cartState.cartItemSum() * 100,
                                name: userObj.user.email,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
