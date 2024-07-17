import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/models/product_model.dart';
import 'package:tedza/res/widget/app_spinner.dart';
import 'package:tedza/res/widget/buttons.dart';
import 'package:tedza/res/widget/header.dart';
import 'package:tedza/res/widget/shop_items.dart';
import 'package:tedza/viewmodels/shop_viewmodel.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({super.key, required this.product});
  final PPProductModel product;

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  final TextEditingController searchController = TextEditingController();
  int? selectedColor;
  String? selectedSize;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopViewModel>(context, listen: true);
    // final itemInCart = shopProvider.checkCart(widget.product.id);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PPBackButton(onPress: () {
                      Navigator.pop(context);
                    }),
                    const HeaderWidget(heading: "Shop"),
                    // PPCartWidget(onTap: () {
                    //   pushNewScreen(
                    //     context,
                    //     screen: const CartScreen(),
                    //     withNavBar: true, // OPTIONAL VALUE. True by default.
                    //     pageTransitionAnimation:
                    //         PageTransitionAnimation.slideUp,
                    //   );
                    // }),
                    horizontalSpaceMedium
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 260,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: AppColor.kPrimaryColor)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                jsonDecode(widget.product.image[0])[0],
                                fit: BoxFit.cover,
                                errorBuilder: (
                                  context,
                                  child,
                                  frame,
                                ) {
                                  return SizedBox(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.warning_outlined,
                                          color: AppColor.kGreyNeutral.shade400,
                                          size: 30,
                                        ),
                                        // Image.asset(
                                        //   kSplashTwo,
                                        //   color: AppColor.kGreyNeutral.shade300,
                                        // ),
                                      ],
                                    ),
                                  );
                                },
                                frameBuilder: (context, child, frame,
                                    wasSynchronouslyLoaded) {
                                  //     print(frame);
                                  //     if (frame == 0) {
                                  //   CircularProgressIndicator(
                                  //     strokeWidth: 5,
                                  //   );
                                  // }
                                  return frame == null
                                      ? const SizedBox(
                                          height: 150,
                                          child: Center(
                                            child: SizedBox(
                                                height: 23,
                                                width: 23,
                                                child: AppSpinner()),
                                          ),
                                        )
                                      : child;
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    // print(loadingProgress.expectedTotalBytes);
                                    return child;
                                  } else {
                                    return SizedBox(
                                      height: 150,
                                      child: Center(
                                        child: SizedBox(
                                          height: 23,
                                          width: 23,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 5,
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : .5,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ))),
                      verticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.productName,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              PPShopPriceWidget(
                                price: widget.product.productPrice.toString(),
                              )
                            ],
                          ),
                          // GestureDetector(
                          //   onTap: () =>
                          //       shopProvider.addToFavourite(widget.product),
                          //   child: shopProvider.checkFavourite(widget.product)
                          //       // selected
                          //       ? const Icon(IconlyBold.heart,
                          //           color: AppColor.kPrimaryColor)
                          //       : const Icon(IconlyLight.heart),
                          // )
                        ],
                      ),
                      verticalSpaceSmall,
                      Text(
                        "Description",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 14, color: kBlack),
                      ),
                      Text(
                        widget.product.productDescription,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      verticalSpaceSmall,
                      // Text(
                      //   "Size",
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .labelMedium!
                      //       .copyWith(fontSize: 14, color: kBlack),
                      // ),
                      // verticalSpaceSmall,
                      // Wrap(
                      //   spacing: 8,
                      //   runSpacing: 12,
                      //   children: [
                      //     ...widget.product.productSize.map((size) {
                      //       return PPShopSizeItem(
                      //         sizeText: size,
                      //         isActive: selectedSize == size ? true : false,
                      //         onPress: () =>
                      //             setState(() => selectedSize = size),
                      //       );
                      //     })
                      //   ],
                      // ),
                      // verticalSpaceSmall,
                      // Text(
                      //   "Color",
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .labelMedium!
                      //       .copyWith(fontSize: 14, color: kBlack),
                      // ),
                      // verticalSpaceSmall,
                      Row(
                        children: [
                          const Expanded(
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 12,
                              children: [
                                // ...widget.product.productColors.map((color) {
                                // var  getColor = "0xFF";
                                // var newColor = color.toString();
                                // var theColor = getColor+newColor;
                                //   print(int.parse(theColor));
                                //   return PPShopColorDot(
                                //     color: Color((0xFF+color).toInt()),
                                //     isActive:
                                //         selectedColor == color ? true : false,
                                //     onPress: () =>
                                //         setState(() => selectedColor = color),
                                //   );
                                // })
                              ],
                            ),
                          ),
                          
                               SizedBox(
                                  width: 120,
                                  child: PPShopProductButton(
                                    active:  true,
                                    isLoading: isLoading,
                                    textColor: AppColor.kWhiteColor,
                                    buttonColor: AppColor.kPrimaryColor,
                                    width: double.infinity,
                                    height: 35,
                                    text: "Add to Cart",
                                    pressState: () async {
                                      //  if (selectedSize == null ) {
                                      //   PPSnackBarUtilities().showSnackBar(
                                      //       message:
                                      //           "Please select a color and size to add to cart",
                                      //       snackbarType: SNACKBARTYPE.info);
                                      //   return;
                                      // }
                                      
                                      // shopProvider.addToCart(widget.product.id);
                                    },
                                  ),
                                ),
                        ],
                      ),
                      verticalSpaceMedium,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "More Featured Products",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 14),
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: shopProvider.productList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      mainAxisExtent: 244.5
                                      // childAspectRatio: 0.75,
                                      ),
                              itemBuilder: (context, index) {
                                var product = shopProvider.productList[index];
                                return PPShopProductCard(product: product);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
