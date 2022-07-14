class ProductModel {
  ProductModel({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productBrand,
    required this.productCategory,
    required this.productQuantity,
    required this.productImage,
    required this.productDescription,
    required this.v,
    required this.productShipping,
  });

  final String id;
  final String productName;
  final String productPrice;
  final String productBrand;
  final String productCategory;
  final String productQuantity;
  final String productImage;
  final String productDescription;
  final int v;
  final String productShipping;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        productBrand: json["productBrand"],
        productCategory: json["productCategory"],
        productQuantity: json["productQuantity"],
        productImage: json["productImage"],
        productDescription: json["productDescription"],
        v: json["__v"],
        productShipping: json["productShipping"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "productName": productName,
        "productPrice": productPrice,
        "productBrand": productBrand,
        "productCategory": productCategory,
        "productQuantity": productQuantity,
        "productImage": productImage,
        "productDescription": productDescription,
        "__v": v,
        "productShipping": productShipping,
      };
}
