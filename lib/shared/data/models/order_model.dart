class OrderModel {
  OrderModel({
    required this.userId,
    required this.itemId,
    required this.itemImage,
    required this.itemName,
    required this.itemQuantity,
    required this.itemPrice,
    required this.dateOrdered,
    required this.receiverName,
    required this.receiverAddress,
    required this.receiverNo,
    required this.completed,
  });

  final String userId;
  final String itemId;
  final String itemImage;
  final String itemName;
  final String itemQuantity;
  final String itemPrice;
  final String dateOrdered;
  final String receiverName;
  final String receiverAddress;
  final String receiverNo;
  final String completed;

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
        userId: json["userID"],
        itemId: json["itemID"],
        itemImage: json["itemImage"],
        itemName: json["itemName"],
        itemQuantity: json["itemQuantity"],
        itemPrice: json["itemPrice"],
        dateOrdered: json["dateOrdered"],
        receiverName: json["receiverName"],
        receiverAddress: json["receiverAddress"],
        receiverNo: json["receiverNo"],
        completed: json["completed"],
      );

  Map<String, dynamic> toMap() => {
        "userID": userId,
        "itemID": itemId,
        "itemImage": itemImage,
        "itemName": itemName,
        "itemQuantity": itemQuantity,
        "itemPrice": itemPrice,
        "dateOrdered": dateOrdered,
        "receiverName": receiverName,
        "receiverAddress": receiverAddress,
        "receiverNo": receiverNo,
        "completed": completed,
      };
}
