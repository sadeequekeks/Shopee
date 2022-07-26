import 'package:shopee/core/services/state_manager/cart_state.dart';
import 'package:shopee/shared/data/models/cart_model.dart';
import 'package:shopee/shared/data/models/login_model.dart';
import 'package:shopee/shared/data/models/order_model.dart';

late LoginModel userObj;
final cartState = UpdateCart();
late CartModel cartObj;
late List<OrderModel> orderedList = [];
late List<CartModel> orderCart = [];
