import 'package:flutter/material.dart';
import 'package:genius_shop/screens/favourite_screen/widget/single_favourite_item.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../provider/app_provider.dart';
import '../../utils/screen_utils.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("My Favourite",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
        ),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(35.0),
                  ),
                  Image.asset('assets/images/empty_cart_illu.png'),
                  SizedBox(
                    height: getProportionateScreenHeight(16.0),
                  ),
                  Text(
                    'Oops your wishlish is empty',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(16.0),
                  ),
                  Text(
                    'It seems notinh in here. Explore more and shortlist some items',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: kTextColorAccent,
                        ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(16.0),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: appProvider.getFavouriteProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleFavouriteItem(
                  singleProduct: appProvider.getFavouriteProductList[index],
                );
              }),
    );
  }
}
