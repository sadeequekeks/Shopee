import 'dart:async';
import 'dart:io';

import 'package:shopee/core/service_injector/service_injector.dart';
import 'package:shopee/shared/data/models/product_model.dart';

class ProductService {
  Future<List<ProductModel>> getAllProducts() async {
    List<ProductModel> products = [];
    try {
      await si.apiService
          .getRequest(
        endpoint: 'https://shoppeefy.herokuapp.com/api/product',
      )
          .then((value) {
        if (value.statusCode == 200) {
          for (dynamic item in value.body) {
            ProductModel product = ProductModel(
              id: item['_id'],
              productName: item['productName'],
              productPrice: item['productPrice'],
              productBrand: item['productBrand'],
              productCategory: item['productCategory'],
              productQuantity: item['productQuantity'],
              productImage: item['productImage'],
              productDescription: item['productDescription'],
              v: item['__v'],
              productShipping: item['productShipping'],
            );
            products.add(product);
          }
        } else {
          print(value.body);
          products = [];
        }
      });
    } on SocketException {
      products = [];
      // si.dialogService.showToast('Please Check your Internet Connection');
    } on TimeoutException catch (e) {
      products = [];
      // si.dialogService.showToast(e.message.toString());
    }
    return products;
  }
}
