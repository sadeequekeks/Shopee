import 'package:mobx/mobx.dart';
import 'package:shopee/shared/data/models/cart_model.dart';

part 'cart_state.g.dart';

class UpdateCart = _UpdateCart with _$UpdateCart;

abstract class _UpdateCart with Store {
  @observable
  ObservableList<CartModel> addedCartItem = ObservableList<CartModel>();

  @action
  void addtoCart(CartModel cartItems) {
    addedCartItem.add(cartItems);
  }

  @action
  void deleteFromCart(CartModel cartItems) {
    addedCartItem.remove(cartItems);
  }

  @action
  void addMultiItemToCart(List<CartModel> carts) {
    addedCartItem = carts as ObservableList<CartModel>;
  }
}
