import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shopee/core/helper/helper_functions.dart';
import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/shared/data/models/product_model.dart';
import 'package:shopee/shared/global/global_var.dart';

class SingleItem extends StatefulWidget {
  final ProductModel singleItem;
  const SingleItem({Key? key, required this.singleItem}) : super(key: key);

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  int itemQ = 1;
  final Helper _helper = Helper();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              child: Image(
                image: NetworkImage(
                    'https://shoppeefy.herokuapp.com${widget.singleItem.productImage}'),
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    MaterialButton(
                      padding: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      textColor: Colors.black,
                      minWidth: 0,
                      height: 40,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ]),
                ),
                Spacer(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 30.0),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    widget.singleItem.productName,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28.0),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    onPressed: () {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Shipping Fee: ${_helper.formattNumber(
                                          int.parse(widget
                                              .singleItem.productShipping),
                                        )}",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                      // Add and deduct item quantity
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.amber,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        height: 40.0,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              iconSize: 18.0,
                                              color: Colors.amber,
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              icon: const Icon(Icons.remove),
                                              onPressed: () {
                                                setState(() {
                                                  itemQ--;
                                                });
                                              },
                                            ),
                                            Text(
                                              itemQ.toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            IconButton(
                                              iconSize: 18.0,
                                              color: Colors.amber,
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                setState(() {
                                                  itemQ++;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ExpansionTile(
                                  title: const Text(
                                    "Show Details",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                          widget.singleItem.productDescription),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(32.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            color: Colors.grey.shade900,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                _helper.formattNumber(
                                  int.parse(widget.singleItem.productPrice),
                                ),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              const SizedBox(width: 20.0),
                              const Spacer(),
                              // Add to cart button
                              MaterialButton(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  int newCost = costCalculationAdd(
                                      int.parse(widget.singleItem.productPrice),
                                      itemQ);
                                  await si.cartService
                                      .addToCart(
                                          userId: userObj.user.id,
                                          itemId: widget.singleItem.id,
                                          cartItemName:
                                              widget.singleItem.productName,
                                          cartItemPrice: newCost.toString(),
                                          itemShippingPrice:
                                              widget.singleItem.productShipping,
                                          cartItemQuantity: itemQ.toString(),
                                          cartItemImage:
                                              widget.singleItem.productImage)
                                      .then((value) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        'Added to cart',
                                      ),
                                    ));
                                  });
                                  setState(() {
                                    isLoading = false;
                                    Navigator.pop(context);
                                  });
                                },
                                color: Colors.orange,
                                textColor: Colors.white,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 20.0),
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                        size: 16.0,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

int costCalculationAdd(int cost, int quantity) {
  return cost * quantity;
}
