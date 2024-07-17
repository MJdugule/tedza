import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tedza/constants/constant.dart';
import 'package:tedza/res/widget/buttons.dart';
import 'package:tedza/res/widget/header.dart';
import 'package:tedza/res/widget/shop_items.dart';
import 'package:tedza/viewmodels/shop_viewmodel.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopViewModel>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: safeAreaPadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TZBackButton(onPress: () {
                  Navigator.pop(context);
                }),
                // const Spacer(flex: 2,),
                const HeaderWidget(heading: "Favourite"),
                // const Spacer(flex: 1,),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          IconlyBold.heart,
                          color: AppColor.kPrimaryColor,
                        )),
                
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView(children: [
                verticalSpaceTiny,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: shopProvider.favouriteList.length,
                  itemBuilder: (context, index) {
                    return PPShopCartProductCard(
                      product: shopProvider.favouriteList[index],
                      cart: false,
                    );
                  },
                ),
                
                verticalSpaceLarge
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
