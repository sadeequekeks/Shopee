class CartModel {
  CartModel({
    required this.id,
    required this.userId,
    required this.itemId,
    required this.cartItemName,
    required this.cartItemPrice,
    required this.itemShippingPrice,
    required this.cartItemQuantity,
    required this.cartItemImage,
    required this.v,
  });

  final String id;
  final String userId;
  final String itemId;
  final String cartItemName;
  final String cartItemPrice;
  final String itemShippingPrice;
  final String cartItemQuantity;
  final String cartItemImage;
  final int v;

  factory CartModel.fromMap(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        userId: json["userID"],
        itemId: json["itemID"],
        cartItemName: json["cartItemName"],
        cartItemPrice: json["cartItemPrice"],
        itemShippingPrice: json["itemShippingPrice"],
        cartItemQuantity: json["cartItemQuantity"],
        cartItemImage: json["cartItemImage"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "userID": userId,
        "itemID": itemId,
        "cartItemName": cartItemName,
        "cartItemPrice": cartItemPrice,
        "itemShippingPrice": itemShippingPrice,
        "cartItemQuantity": cartItemQuantity,
        "cartItemImage": cartItemImage,
        "__v": v,
      };
}
