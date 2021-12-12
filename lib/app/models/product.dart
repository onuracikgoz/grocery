class Product {
  Product({
    required this.productImage,
    required this.productName,
    required this.productOwnerId,
    required this.salesState,
    required this.price,
    required this.docId,
    required this.state,
  });
  late final String productImage;
  late final String productName;
  late final String productOwnerId;
  late final bool salesState;
  late final double price;
  late final int state;
  late final String docId;

  Product.fromJson(Map<String, dynamic> json) {
    productImage = json['productImage'];
    productName = json['productName'];
    productOwnerId = json['productOwnerId'];
    salesState = json['salesState'];
    state = json['state'];
    price = json['price'];
    docId = json['docId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productImage'] = productImage;
    _data['productName'] = productName;
    _data['productOwnerId'] = productOwnerId;
    _data['salesState'] = salesState;
    _data['price'] = price;
    _data['state'] = state;
    _data['docId'] = docId;
    return _data;
  }
}
