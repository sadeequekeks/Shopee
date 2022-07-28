import 'package:flutter/material.dart';
import 'package:shopee/core/helper/helper_functions.dart';
import 'package:shopee/shared/data/models/all_order_model.dart';
import 'package:shopee/shared/global/global_var.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<AllOrderModel> userOrder = lateOrderList
      .where((element) => element.userId == userObj.user.id)
      .toList();
  final Helper _helper = Helper();
  @override
  void dispose() {
    userOrder.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: userOrder.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            child: Image(
                              height: 150.0,
                              image: NetworkImage(
                                  'https://shoppeefy.herokuapp.com${userOrder[index].itemImage}'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userOrder[index].itemName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Text(
                                _helper.formattNumber(
                                  int.parse(userOrder[index].itemPrice),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.0,
                                  color: Colors.amberAccent,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Text(
                                '${userOrder[index].itemQuantity} ordered',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6.0),
                              const Text(
                                'Undelivered',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
