// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdateCart on _UpdateCart, Store {
  late final _$addedCartItemAtom =
      Atom(name: '_UpdateCart.addedCartItem', context: context);

  @override
  ObservableList<CartModel> get addedCartItem {
    _$addedCartItemAtom.reportRead();
    return super.addedCartItem;
  }

  @override
  set addedCartItem(ObservableList<CartModel> value) {
    _$addedCartItemAtom.reportWrite(value, super.addedCartItem, () {
      super.addedCartItem = value;
    });
  }

  late final _$sumAtom = Atom(name: '_UpdateCart.sum', context: context);

  @override
  int get sum {
    _$sumAtom.reportRead();
    return super.sum;
  }

  @override
  set sum(int value) {
    _$sumAtom.reportWrite(value, super.sum, () {
      super.sum = value;
    });
  }

  late final _$_UpdateCartActionController =
      ActionController(name: '_UpdateCart', context: context);

  @override
  void addtoCart(CartModel cartItems) {
    final _$actionInfo = _$_UpdateCartActionController.startAction(
        name: '_UpdateCart.addtoCart');
    try {
      return super.addtoCart(cartItems);
    } finally {
      _$_UpdateCartActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteFromCart(CartModel cartItems) {
    final _$actionInfo = _$_UpdateCartActionController.startAction(
        name: '_UpdateCart.deleteFromCart');
    try {
      return super.deleteFromCart(cartItems);
    } finally {
      _$_UpdateCartActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMultiItemToCart(List<CartModel> carts) {
    final _$actionInfo = _$_UpdateCartActionController.startAction(
        name: '_UpdateCart.addMultiItemToCart');
    try {
      return super.addMultiItemToCart(carts);
    } finally {
      _$_UpdateCartActionController.endAction(_$actionInfo);
    }
  }

  @override
  int cartItemSum() {
    final _$actionInfo = _$_UpdateCartActionController.startAction(
        name: '_UpdateCart.cartItemSum');
    try {
      return super.cartItemSum();
    } finally {
      _$_UpdateCartActionController.endAction(_$actionInfo);
    }
  }

  @override
  void emptyList() {
    final _$actionInfo = _$_UpdateCartActionController.startAction(
        name: '_UpdateCart.emptyList');
    try {
      return super.emptyList();
    } finally {
      _$_UpdateCartActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
addedCartItem: ${addedCartItem},
sum: ${sum}
    ''';
  }
}
