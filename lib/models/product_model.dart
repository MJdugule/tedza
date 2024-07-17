
class PPProductModel {
  final dynamic image;
  final int id;
  final String productName;
  final String productDescription;
  dynamic quantity;
  final dynamic productPrice;
  final dynamic productColors;
  final dynamic productSize;

  PPProductModel({
    this.quantity,
    required this.productDescription,
    required this.image,
    required this.id,
    required this.productName,
    this.productPrice,
     this.productColors,
    required this.productSize,
  });

   factory PPProductModel.fromJson(Map<String, dynamic> json) {
    return PPProductModel(
      productSize: json['size'],
      id: json['id'],
      image: json['image'],
      productDescription: json['description'], 
      productName: json['title'], 
      // productColors: json['color'],
      productPrice: json['price'],
    );
  }
}


