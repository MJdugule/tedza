
class PPProductModel {
  final List<dynamic> image;
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
      image: json['images'],
      productDescription: json['description'], 
      productName: json['title'], 
      // productColors: json['color'],
      productPrice: json['price'],
    );
  }

  // static List<PPProductModel> get productList => [
  //       PPProductModel(
  //         image: kPerrypro1,
  //         id: "5",
  //         productName: "Cap",
  //         productPrice: 5000.00,
  //         productDescription:
  //             "Black wrist band suitable for both male and female",
  //         productColors: [0xFF0057FD, 0xFF000000, 0xFFf2f2f2],
  //         productSize: ['S', 'M', 'L', 'XL', 'XXL'],
  //       ),
  //       PPProductModel(
  //         image: kPerrypro2,
  //         id: "6",
  //         productName: "Shirt",
  //         productPrice: 10004.00,
  //         productDescription:
  //             "Black wrist band suitable for both male and female",
  //         productColors: [0xFF0057FD, 0xFF000000, 0xFFffffff],
  //         productSize: ['S', 'M', 'L', 'XL', 'XXL'],
  //       ),
  //       PPProductModel(
  //         image: kPerrypro3,
  //         id: "7",
  //         productName: "Grey Cap",
  //         productPrice: 2000.00,
  //         productDescription:
  //             "Black wrist band suitable for both male and female",
  //         productColors: [0xFF0057FD, 0xFF000000, 0xFFffffff],
  //         productSize: ['S', 'M', 'L', 'XL', 'XXL'],
  //       ),
  //       PPProductModel(
  //         image: kHand,
  //         id: "1",
  //         productName: "Wrist Bands",
  //         productPrice: 93000.00,
  //         productDescription: "Black Hand Wrist unisex",
  //         productColors: [0xFF0057FD, 0xFF000000, 0xFFffffff],
  //         productSize: ['S', 'M', 'L', 'XL', 'XXL'],
  //       ),
  //       PPProductModel(
  //         image: kBucketCap,
  //         id: "2",
  //         productName: "Bucket Cap",
  //         productPrice: 289320.00,
  //         productDescription: "beautiful bucket cap",
  //         productColors: [0xFF0057FD, 0xFF000000, 0xFFffffff],
  //         productSize: ['S', 'M', 'L', 'XL', 'XXL'],
  //       ),
  //       PPProductModel(
  //         image: kBlackCap,
  //         id: "3",
  //         productName: "Black Cap",
  //         productPrice: 490310.00,
  //         productDescription: "Black Cap not cost",
  //         productColors: [0xFF0057FD, 0xFF000000, 0xFFffffff],
  //         productSize: ['S', 'M', 'L', 'XL', 'XXL'],
  //       ),
  //       PPProductModel(
  //         image: kGreyCap,
  //         id: "4",
  //         productName: "Grey Cap",
  //         productPrice: 38940.00,
  //         productDescription: "Grey Cap not cos",
  //         productColors: [0xFF0057FD, 0xFF000000, 0xFFffffff],
  //         productSize: ['S', 'M', 'L', 'XL', 'XXL'],
  //       ),
  //     ];
}


