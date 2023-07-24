// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:genius_shop/screens/home/tap_screen.dart';
import 'package:provider/provider.dart';
import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore/firebase_firestore.dart';
import '../../provider/app_provider.dart';
import '../../widgets/primary_button/primary_button.dart';
import '../stripe_helper/stripe_helper.dart';


class CartItemCheckout extends StatefulWidget {
  const CartItemCheckout({
    super.key,
  });

  @override
  State<CartItemCheckout> createState() => _CartItemCheckoutState();
}

class _CartItemCheckoutState extends State<CartItemCheckout> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            "الدفع",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 36.0,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 3.0)),
                width: double.infinity,
                child: Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      },
                    ),
                    const Icon(Icons.money),
                    const SizedBox(
                      width: 12.0,
                    ),
                    const Text(
                      "الدفع عند الاستلام",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 24.0,
              // ),
              // Container(
              //   height: 80,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12.0),
              //       border: Border.all(
              //           color: Theme.of(context).primaryColor, width: 3.0)),
              //   width: double.infinity,
              //   child: Row(
              //     children: [
              //       Radio(
              //         value: 2,
              //         groupValue: groupValue,
              //         onChanged: (value) {
              //           setState(() {
              //             groupValue = value!;
              //           });
              //         },
              //       ),
              //       const Icon(Icons.money),
              //       const SizedBox(
              //         width: 12.0,
              //       ),
              //       const Text(
              //         "Pay Online",
              //         style: TextStyle(
              //           fontSize: 18.0,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 24.0,
              ),
              PrimaryButton(
                title: "تأكيد الطلب",
                onPressed: () async {
                  if (groupValue == 1) {
                    bool value = await appProvider
                        .uploadOrderedProductFirebase(
                        appProvider.getBuyProductList,
                        context,
                        "الدفع عند الاستلام");
                    appProvider.clearBuyProduct();
                    if (value) {
                      Future.delayed(const Duration(seconds: 2), () {
                        Routes.instance.push(
                            widget: TabScreen(), context: context);
                      });
                    }
                  } else {
                    int value = double.parse(
                        appProvider.totalPriceBuyProductList().toString())
                        .round()
                        .toInt();
                    String totalPrice = (value * 100).toString();
                    await StripeHelper.instance
                        .makePayment(totalPrice.toString(), context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}