
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
                    TZBackButton(onPress: () {
                      Navigator.pop(context);
                    }),
                    const HeaderWidget(heading: "Shop"),
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
                                widget.product.image,
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
                                      ],
                                    ),
                                  );
                                },
                                frameBuilder: (context, child, frame,
                                    wasSynchronouslyLoaded) {
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
                              TZShopPriceWidget(
                                price: widget.product.productPrice.toString(),
                              )
                            ],
                          ),
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
                      SizedBox(
                        width: 120,
                        child: TZShopProductButton(
                          active: true,
                          isLoading: isLoading,
                          textColor: AppColor.kWhiteColor,
                          buttonColor: AppColor.kPrimaryColor,
                          width: double.infinity,
                          height: 35,
                          text: "Add to Cart",
                          pressState: () async {},
                        ),
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
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
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
                                return TZShopProductCard(product: product);
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
