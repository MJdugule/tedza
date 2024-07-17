import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/res/widget/app_spinner.dart';
import 'package:tedza/res/widget/empty_state_widget.dart';
import 'package:tedza/res/widget/header.dart';
import 'package:tedza/res/widget/search_bar.dart';
import 'package:tedza/res/widget/shop_items.dart';
import 'package:tedza/viewmodels/authentication_viewmodel.dart';
import 'package:tedza/viewmodels/shop_viewmodel.dart';
import 'package:tedza/views/shop/favourite_screen.dart';

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
        if (value != false) {}
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopViewModel>(context, listen: true);
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: true);
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
                      horizontalSpaceLarge,
                      horizontalSpaceTiny,
                      const HeaderWidget(heading: "Shop"),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              authProvider.signOutUserFunction();
                            },
                            icon: const Icon(
                              Icons.person,
                              color: AppColor.kPrimaryColor,
                              size: 25,
                            ),
                          ), IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_){return const FavouriteScreen();}));
                            },
                            icon: const Icon(
                              IconlyBold.heart,
                              color: AppColor.kPrimaryColor,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpaceTiny,
                  TZSearchBox(
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
                            const TZShopCarouselWidget(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          ),
                                          itemBuilder: (context, index) {
                                            var product =
                                                shopProvider.productList[index];
                                            return TZShopProductCard(
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
