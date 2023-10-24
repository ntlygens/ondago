class ProductSellerModel {
  final String name;
  final String? logo;
  final bool hasItem;
  final double inStockQty;
  final String? upc;
  final String sellerID;

  const ProductSellerModel ({
    required this.name,
    this.logo,
    required this.hasItem,
    required this.inStockQty,
    this.upc,
    required this.sellerID,
  });

  factory ProductSellerModel.fromJson(Map<String, dynamic> json) {
    return ProductSellerModel(
      name: json['name'],
      logo: json['logo'],
      hasItem: json['hasItem'],
      inStockQty: json['inStockQty'],
      upc: json['upc'],
      sellerID: json['sellerID'],
    );
  }
}