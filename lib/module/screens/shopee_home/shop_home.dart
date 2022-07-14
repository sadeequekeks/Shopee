import 'package:flutter/material.dart';
import 'package:shopee/core/helper/helper_functions.dart';
import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/module/screens/shopee_home/single_item.dart';
import 'package:shopee/shared/data/models/product_model.dart';
import 'package:shopee/shared/widgets/buttons/outlined_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShopeeHome extends StatefulWidget {
  const ShopeeHome({Key? key}) : super(key: key);

  @override
  State<ShopeeHome> createState() => _ShopeeHomeState();
}

class _ShopeeHomeState extends State<ShopeeHome> {
  final Helper _helper = Helper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Shopee',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shop All',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            FutureBuilder<List<ProductModel>>(
                future: si.productService.getAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitThreeBounce(
                        color: Colors.orange,
                        size: 50.0,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('NO DATA!'));
                  } else if (snapshot.hasData) {
                    // final data = snapshot.data!;
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.5,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 5,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          ProductModel product = snapshot.data![index];
                          return SizedBox(
                            height: 400,
                            child: ShopCard(
                              name: product.productName,
                              photo:
                                  'https://shoppeefy.herokuapp.com${product.productImage}',
                              price: _helper.formattNumber(
                                int.parse(product.productPrice),
                              ),
                              onTap: () {
                                si.routerService.nextScreen(
                                  context,
                                  SingleItem(singleItem: product),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  final String photo;
  final String name;
  final String price;
  final void Function()? onTap;
  const ShopCard({
    Key? key,
    required this.photo,
    required this.name,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          child: Image(
            image: NetworkImage(photo),
          ),
        ),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 17.0,
          ),
        ),
        const Divider(),
        Text(
          price,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        const Divider(),
        const SizedBox(
          height: 10.0,
        ),
        GestureDetector(
          onTap: onTap,
          child: const PrimaryOutlinedButton(
            buttonTitle: 'View Details',
          ),
        )
      ],
    );
  }
}
