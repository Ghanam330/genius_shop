import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/constant.dart';
import '../../constants/routes.dart';
import '../../models/product_model/product_model.dart';
import '../../provider/app_provider.dart';
import '../cart_screen/cart_screen.dart';
import '../check_out/check_out.dart';


class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                ProductModel productModel =
                widget.singleProduct.copyWith(qty: qty);
                appProvider.addCartProduct(productModel);
                showMessage("تمت الاضافة الى السلة");
              },
              icon: const Icon(Icons.shopping_cart),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.singleProduct.image,
                  height: 400,
                  width: 400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.singleProduct.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.singleProduct.isFavourite =
                          !widget.singleProduct.isFavourite;
                        });
                        if (widget.singleProduct.isFavourite) {
                          appProvider.addFavouriteProduct(widget.singleProduct);
                        } else {
                          appProvider
                              .removeFavouriteProduct(widget.singleProduct);
                        }
                      },
                      icon: Icon(appProvider.getFavouriteProductList
                          .contains(widget.singleProduct)
                          ? Icons.favorite
                          : Icons.favorite_border),
                    ),
                  ],
                ),
                Text(widget.singleProduct.description),
                const SizedBox(
                  height: 12.00,
                ),
                Row(
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        if (qty >= 1) {
                          setState(() {
                            qty--;
                          });
                        }
                      },
                      padding: EdgeInsets.zero,
                      child: const CircleAvatar(
                        backgroundColor: kPrimaryGreen,
                        child: Icon(Icons.remove, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      qty.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    CupertinoButton(
                      onPressed: () {
                        setState(() {
                          qty++;
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: const CircleAvatar(
                        backgroundColor: kPrimaryGreen,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
                const SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
            ),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              ProductModel productModel =
              widget.singleProduct.copyWith(qty: qty);
              Routes.instance.push(
                  widget: Checkout(singleProduct: productModel),
                  context: context);
            },
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'شراء الان',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}