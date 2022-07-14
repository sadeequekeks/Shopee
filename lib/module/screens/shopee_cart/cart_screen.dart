import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopee/core/helper/helper_functions.dart';
import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/shared/data/models/cart_model.dart';
import 'package:shopee/shared/global/global_var.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    cartState.addedCartItem.clear();
    super.dispose();
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
            Observer(
              builder: (_) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: cartState.addedCartItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      // CartModel cart = snapshot.data![index];
                      final item = cartState.addedCartItem[index];
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
                                  color: Colors.white,
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

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Shipping Fee      \$50",
                    style:
                        TextStyle(color: Colors.grey.shade700, fontSize: 16.0),
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
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),

            // FutureBuilder<int>(
            //     future: si.cartService.getTotalCartAmount(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(
            //           child: SpinKitThreeBounce(
            //             color: Colors.transparent,
            //             size: 50.0,
            //           ),
            //         );
            //       } else if (snapshot.hasData) {
            //         return Container(
            //           width: double.infinity,
            //           padding: const EdgeInsets.all(20.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.end,
            //             children: <Widget>[
            //               Text(
            //                 "Shipping Fee      \$50",
            //                 style: TextStyle(
            //                     color: Colors.grey.shade700, fontSize: 16.0),
            //               ),
            //               const SizedBox(
            //                 height: 10.0,
            //               ),
            //               Text(
            //                 "Cart Subtotal     ${_helper.formattNumber(snapshot.data ?? 0)}",
            //                 style: const TextStyle(
            //                     fontWeight: FontWeight.bold, fontSize: 18.0),
            //               ),
            //               const SizedBox(
            //                 height: 20.0,
            //               ),
            //               SizedBox(
            //                 width: double.infinity,
            //                 child: MaterialButton(
            //                   height: 50.0,
            //                   color: Colors.amber,
            //                   child: Text(
            //                     "Secure Checkout".toUpperCase(),
            //                     style: const TextStyle(color: Colors.white),
            //                   ),
            //                   onPressed: () {},
            //                 ),
            //               )
            //             ],
            //           ),
            //         );
            //       } else {
            //         return Container();
            //       }
            //     })
          ],
        ),
      ),
    );
  }
}
