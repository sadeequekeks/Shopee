import 'package:shopee/core/services/service_export.dart';

class Serviceinjector {
  RouterService routerService = RouterService();
  ApiService apiService = ApiService();
  ProductService productService = ProductService();
  AuthService authService = AuthService();
  CartService cartService = CartService();
}

Serviceinjector si = Serviceinjector();
