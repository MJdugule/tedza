import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/res/widget/app_spinner.dart';
import 'package:tedza/res/widget/empty_state_widget.dart';
import 'package:tedza/res/widget/header.dart';
import 'package:tedza/res/widget/search_bar.dart';
import 'package:tedza/res/widget/shop_items.dart';
import 'package:tedza/viewmodels/shop_viewmodel.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final shopViewModel = Provider.of<ShopViewModel>(context, listen: false);
      shopViewModel.getAllShopProduct().then((value) {
        if (value != false) {
          
        }
      });
      
    });
    super.initState();
  }


  @override
  void dispose() {
    searchController.dispose();
    //   //  WidgetsBinding.instance.addPostFrameCallback((_) {
    //  if (!mounted) {
    //    final shopProvider = Provider.of<ShopViewModel>(context, listen: false);
    //     shopProvider.clearSearchField();
    //  }

    // homeProvider.updateUserNewFCM();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopViewModel>(context, listen: true);
    // final homeProvider = Provider.of<HomeViewModel>(context, listen: true);
    //final itemInCart = shopProvider.checkCart(product);
    return Scaffold(
      body: Padding(
        padding: safeAreaPadding,
        child: shopProvider.loading
            ? const Center(
                child: AppSpinner(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      horizontalSpaceMedium,
                      const HeaderWidget(heading: "Shop"),
                      IconButton(
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder:(context) {
                          //   return FavouriteScreen();
                          // },));
                          // pushNewScreen(
                          //   context,
                          //   screen: const OrderScreen(),
                          //   withNavBar:
                          //       false, // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation:
                          //       PageTransitionAnimation.slideUp,
                          // );
                        },
                        icon: const Icon(
                          Icons.person,
                          color: AppColor.kGreyNeutral,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceTiny,
                  PPSearchBox(
                    onChanged: (value) => shopProvider.searchListState(value),
                    hintText: 'Search',
                    textEditingController: searchController,
                    clearField: () {
                      searchController.clear();
                      shopProvider.clearSearchField();
                      //invoiceViewModel.clearSearchField();
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (shopProvider.isSearching == false) ...[
                            PPShopCarouselWidget(
                              // bannerModel: homeProvider.bannerList,
                            ),
                            verticalSpaceMedium,
                          ],
                          Text(
                            "Featured Products",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 14),
                          ),
                          shopProvider.loading
                              ? const Center(
                                  child: AppSpinner(),
                                )
                              : shopProvider.error == true
                                  ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        verticalSpaceLarge,
                                        const Center(
                                          child: EmptyStateWidget(
                                              text:
                                                  "Something went wrong, please try again"),
                                        ),
                                      ],
                                    )
                                  : shopProvider.error == false &&
                                          shopProvider.productList.isEmpty
                                      ? Column(
                                          children: [
                                            verticalSpaceLarge,
                                            const Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: EmptyStateWidget(
                                                    text: "No Product Found"),
                                              ),
                                            ),
                                          ],
                                        )
                                      : GridView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 80),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              shopProvider.productList.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 16,
                                            crossAxisSpacing: 16,
                                            mainAxisExtent: 244.5,
                                            //childAspectRatio: 0.60.h,
                                          ),
                                          itemBuilder: (context, index) {
                                            var product =
                                                shopProvider.productList[index];
                                            return PPShopProductCard(
                                                product: product);
                                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
