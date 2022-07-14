import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopee/core/helper/helper_functions.dart';
import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/module/screens/shopee_home/single_item.dart';
import 'package:shopee/shared/data/models/api_response_model.dart';
import 'package:shopee/shared/data/models/product_model.dart';
import 'package:shopee/shared/widgets/buttons/outlined_button.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String categories = 'Eyes';
  int selectedItem = 0;
  List<String> category = ['Eyes', 'Face', 'Lips'];
  final Helper _helper = Helper();
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      const SizedBox(
        height: 20,
      ),
      Center(
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 8.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: selectedItem == index ? Colors.amber : Colors.grey,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedItem = index;
                      categories = category[index];
                    });
                  },
                  child: Text(
                    category[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          selectedItem == index ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Category'),
      ),
      body: FutureBuilder<ApiResponseModel>(
        future: si.apiService.getRequest(
          endpoint:
              'https://shoppeefy.herokuapp.com/api/product/category/$categories',
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitThreeBounce(
                color: Colors.orange,
                size: 50.0,
              ),
            );
          }
          List products = snapshot.data!.body;
          for (var product in products) {
            ProductModel categoryItem = ProductModel(
              id: product['_id'],
              productName: product['productName'],
              productPrice: product['productPrice'],
              productBrand: product['productBrand'],
              productCategory: product['productCategory'],
              productQuantity: product['productQuantity'],
              productImage: product['productImage'],
              productDescription: product['productDescription'],
              v: product['__v'],
              productShipping: product['productShipping'],
            );
            items.add(
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    child: Image(
                      height: 200,
                      width: 150,
                      image: NetworkImage(
                          'https://shoppeefy.herokuapp.com${categoryItem.productImage}'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            categoryItem.productName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            _helper.formattNumber(
                                int.parse(categoryItem.productPrice)),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '${categoryItem.productQuantity} available',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              si.routerService.nextScreen(
                                context,
                                SingleItem(singleItem: categoryItem),
                              );
                            },
                            child: const PrimaryOutlinedButton(
                              buttonTitle: 'View Details',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          }
          return ListView(
            children: items,
          );
        },
      ),
    );
  }
}
