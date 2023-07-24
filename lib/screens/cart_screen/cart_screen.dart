import 'package:flutter/material.dart';
import 'package:genius_shop/screens/cart_screen/widget/single_cart_item.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/constant.dart';
import '../../constants/routes.dart';
import '../../provider/app_provider.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/primary_button/primary_button.dart';
import '../cart_item_checkout/cart_item_checkout.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "اجمالي الدفع",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${appProvider.totalPrice().toString()}جنيه",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              PrimaryButton(
                title: "تأكيد الطلب",
                onPressed: () {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductCartList();
                  appProvider.clearCart();
                  if (appProvider.getBuyProductList.isEmpty) {
                    showMessage("لا يوجد منتجات في السلة");
                  } else {
                    Routes.instance.push(
                        widget: const CartItemCheckout(), context: context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
            'سلة المشتريات',
            style:TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,

            )
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ?  Center(
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
              'عذرا ، قائمة المشتريات بك فارغة',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(16.0),
            ),
            Text(
              'يجب أن تضيف بعض المنتجات إلى قائمة المشتريات لتتمكن من الشراء',
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
          itemCount: appProvider.getCartProductList.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (ctx, index) {
            return SingleCartItem(
              singleProduct: appProvider.getCartProductList[index],
            );
          }),
    );
  }
}