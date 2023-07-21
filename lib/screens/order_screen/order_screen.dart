import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../firebase_helper/firebase_firestore/firebase_firestore.dart';
import '../../models/order_model/order_model.dart';
import '../../utils/screen_utils.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Your Orders",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Stream.fromFuture(
          FirebaseFirestoreHelper.instance.getUserOrder(),
        ),
        // future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return Center(
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
                    "No Order Found",
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
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.3)),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.3)),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          child: Image.network(
                            orderModel.products[0].image,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderModel.products[0].name,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              orderModel.products.length > 1
                                  ? SizedBox.fromSize()
                                  : Column(
                                      children: [
                                        Text(
                                          "Quanity: ${orderModel.products[0].qty.toString()}",
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                      ],
                                    ),
                              Text(
                                "Total Price: \$${orderModel.totalPrice.toString()}",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                "Order Status: ${orderModel.status}",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              // orderModel.status =="Pending" || orderModel.status == "Delivery" ?
                              // CupertinoButton(
                              //     onPressed: () {},
                              //     child: Container(
                              //       height: 48,
                              //       width: 120,
                              //       alignment: Alignment.center,
                              //       decoration: BoxDecoration(
                              //         color: Theme.of(context).primaryColor,
                              //         borderRadius: BorderRadius.circular(12.0),
                              //       ),
                              //       child: const Text("Cancel Order",
                              //           style: TextStyle(
                              //             fontSize: 12.0,
                              //             color: Colors.white,
                              //           )),
                              //     )) : SizedBox.fromSize(),
                              // Row(
                              //   children: [
                              //     orderModel.status == "Pending" ||
                              //             orderModel.status == "Delivery"
                              //         ? SizedBox(
                              //             height: 50,
                              //             width: 100,
                              //             child: ElevatedButton(
                              //                 onPressed: () async {
                              //                   await FirebaseFirestoreHelper
                              //                       .instance
                              //                       .updateOrder(
                              //                           orderModel, "Cancel");
                              //                   orderModel.status = "Cancel";
                              //                   setState(() {});
                              //                 },
                              //                 child: const Text("Cancel")),
                              //           )
                              //         : SizedBox.fromSize(),
                              //     orderModel.status == "Delivery"
                              //         ? Container(
                              //             height: 50,
                              //             width: 100,
                              //             child: ElevatedButton(
                              //                 onPressed: () async {
                              //                   await FirebaseFirestoreHelper
                              //                       .instance
                              //                       .updateOrder(orderModel,
                              //                           "Completed");
                              //                   orderModel.status = "Completed";
                              //                   setState(() {});
                              //                 },
                              //                 child: const Text(
                              //                     "Delivered Order")),
                              //           )
                              //         : SizedBox.fromSize(),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? [
                            const Text("Details"),
                            Divider(color: Theme.of(context).primaryColor),
                            ...orderModel.products.map((singleProduct) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 6.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5),
                                          child: Image.network(
                                            singleProduct.image,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                singleProduct.name,
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Quanity: ${singleProduct.qty.toString()}",
                                                    style: const TextStyle(
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12.0,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Price: \$${singleProduct.price.toString()}",
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                        color: Theme.of(context).primaryColor),
                                  ],
                                ),
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
