import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/models/product_model.dart';
import 'package:tedza/res/widget/app_spinner.dart';
import 'package:tedza/viewmodels/shop_viewmodel.dart';
import 'package:tedza/views/shop/view_product.dart';

class TZShopCarouselWidget extends StatefulWidget {
  const TZShopCarouselWidget({
    super.key,
  });

  @override
  State<TZShopCarouselWidget> createState() => _TZShopCarouselWidgetState();
}

class _TZShopCarouselWidgetState extends State<TZShopCarouselWidget> {
  CarouselController buttonCarouselController = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: carouselList.toList().map<Widget>((e) {
            //  return e.image == null ? Image.asset(kSplashTwo):
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                e.toString(),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  child,
                  frame,
                ) {
                  return const SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   kSplashTwo,
                        //   color: AppColor.kGreyNeutral.shade300,
                        // ),
                      ],
                    ),
                  );
                },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  //     print(frame);
                  //     if (frame == 0) {
                  //   CircularProgressIndicator(
                  //     strokeWidth: 5,
                  //   );
                  // }
                  return frame == null
                      ? const SizedBox(
                          height: 150,
                          //  width: 150,
                          child: Center(
                            child: SizedBox(
                                height: 23, width: 23, child: AppSpinner()),
                          ),
                        )
                      : child;
                },
              ),
            );
          }).toList(),
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              //  print(index);
              setState(() {
                _current = index;
              });
            },
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            aspectRatio: 16 / 9,
            initialPage: 1,
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            // autoPlayInterval: const Duration(microseconds: 10),
          ),
        ),
        verticalSpaceTiny,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselList.asMap().entries.map((entry) {
            return Container(
                width: _current == entry.key ? 9.0 : 9,
                height: 9.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(4),
                    color: _current == entry.key
                        ? AppColor.kPrimaryColor
                        : AppColor.kGreyNeutral.shade300));
          }).toList(),
        ),
      ],
    );
  }
}

class TZShopProductCard extends StatefulWidget {
  const TZShopProductCard({super.key, required this.product});
  final PPProductModel product;

  @override
  State<TZShopProductCard> createState() => _TZShopProductCardState();
}

class _TZShopProductCardState extends State<TZShopProductCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopViewModel>(context, listen: true);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ViewProductScreen(product: widget.product);
          },
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColor.kGreyNeutral.shade200)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.product.image,
                  // "jsonDecode(widget.product.image[0])[0]",
                  // widget.product.image.toList().first.toList().first,
                  errorBuilder: (
                    context,
                    child,
                    frame,
                  ) {
                    return SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
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
                                  height: 23, width: 23, child: AppSpinner()),
                            ),
                          )
                        : child;
                  },
                  loadingBuilder: (context, child, loadingProgress) {
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
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : .5,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )),
          ),
          verticalSpaceTiny,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    verticalSpaceTiny,
                    TZShopPriceWidget(
                        price: widget.product.productPrice.toString()),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => shopProvider.addToFavourite(widget.product),
                child: shopProvider.checkFavourite(widget.product)
                    ? const Icon(IconlyBold.heart,
                        color: AppColor.kPrimaryColor)
                    : const Icon(IconlyLight.heart),
              )
            ],
          ),
          const Spacer(),
          TZShopProductButton(
            active: true,
            isLoading: isLoading,
            textColor: AppColor.kWhiteColor,
            buttonColor: AppColor.kPrimaryColor,
            width: double.infinity,
            height: 35,
            text: "Add to Cart",
            pressState: () async {
              // shopProvider.addToCart(widget.product.id);
            },
          ),
          const Spacer()
        ],
      ),
    );
  }
}

class TZShopPriceWidget extends StatelessWidget {
  const TZShopPriceWidget({super.key, required this.price});
  final String price;

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          text: "\$",
          style: GoogleFonts.nunito(
              fontSize: 14,
              color: AppColor.kPrimaryColor,
              fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: price,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColor.kPrimaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ]),
    );
  }
}

class TZShopProductButton extends StatelessWidget {
  final String? text;
  final bool active, isLoading;
  final VoidCallback? pressState;
  final Color textColor, buttonColor;
  final double width;
  final double? height;
  final double? textSize;
  const TZShopProductButton(
      {super.key,
      this.text,
      required this.active,
      required this.isLoading,
      this.pressState,
      required this.textColor,
      required this.buttonColor,
      required this.width,
      this.height = 50,
      this.textSize = 13});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: isLoading
          ? const AppSpinner()
          : ClipRRect(
              borderRadius: BorderRadius.circular(kPaddingSS),
              child: TextButton(
                  onPressed: pressState,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    // padding: const EdgeInsets.symmetric(
                    //     vertical: kPaddingMM, horizontal: kPaddingMM),
                    backgroundColor: active
                        ? buttonColor
                        : AppColor.kGreyNeutral.shade300.withOpacity(.5),
                    shape: RoundedRectangleBorder(
                        // side: BorderSide(
                        //     color:active ? buttonColor : AppColor.kGreyNeutral.shade300.withOpacity(.5),
                        //     width: kPaddingTwo,
                        //     style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(kPaddingSS)),
                  ),
                  child: Center(
                    child: Text(
                      text!,
                      style: TextStyle(
                        color: active ? textColor : AppColor.kGreyNeutral,
                        fontSize: textSize!,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )),
            ),
      // decoration: BoxDecoration(boxShadow: [
      //   BoxShadow(
      //       offset: Offset(0, 4),
      //       color: kMainColorDark.withOpacity(0.25),
      //       blurRadius: 20)
      // ]),
    );
  }
}

class PPShopCartProductCard extends StatefulWidget {
  const PPShopCartProductCard({
    super.key,
    required this.product,
    required this.cart,
  });
  final PPProductModel product;
  final bool cart;

  @override
  State<PPShopCartProductCard> createState() => _PPShopCartProductCardState();
}

class _PPShopCartProductCardState extends State<PPShopCartProductCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final shopProvider = Provider.of<ShopViewModel>(context, listen: true);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.kPrimaryColor.shade100.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 145,
      // width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.kPrimaryColor)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.product.image,
                  height: size.height * 0.15,
                  width: size.width * 0.3,
                  fit: BoxFit.cover,
                )),
          ),
          horizontalSpaceSmall,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.product.productName,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 13,
                            ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.cart == true) {
                          // shopProvider.removeFromCart(widget.product);
                        } else {
                          shopProvider.removeFromFavorite(widget.product);
                        }
                      },
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: kBlack,
                      ),
                    ),
                  ],
                ),
                verticalSpaceTiny,
                Text(
                  widget.product.productDescription,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "₦${widget.product.productPrice.toString()}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 13, color: AppColor.kPrimaryColor),
                      ),
                    ),
                    if (widget.cart == false)
                      TZShopProductButton(
                          width: 80,
                          height: 30,
                          pressState: () {},
                          // shopProvider.checkCart(widget.product) == true
                          //     ? () {}
                          //     : () {
                          //         shopProvider.addToCart(widget.product);
                          //       },
                          active: true,
                          isLoading: false,
                          textColor: AppColor.kWhiteColor,
                          buttonColor: AppColor.kPrimaryColor,
                          textSize: 10,
                          text: "Add to Cart"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
