import 'package:flutter/material.dart';
import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore/firebase_firestore.dart';
import '../../models/category_model/category_model.dart';
import '../../models/product_model/product_model.dart';
import '../../widgets/products_card.dart';
import '../product_details/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          title:Text(
            widget.categoryModel.name,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: isLoading
            ? Center(
          child: Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        )
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productModelList.isEmpty
                  ? const Center(
                child: Text("Best Product is empty"),
              )
                  : Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: productModelList.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.7,
                        crossAxisCount: 2),
                    itemBuilder: (ctx, index) {
                      ProductModel singleProduct =
                      productModelList[index];
                      return ProductsCard(
                          description: singleProduct.description,
                          image: singleProduct.image ,
                          name: singleProduct.name,
                          price:"Price: ${singleProduct.price}",
                          isLeft: index.isEven,
                          isSelected: true,
                          addHandler:(){
                            Routes.instance.push(
                                widget: ProductDetails(
                                    singleProduct:
                                    singleProduct),
                                context: context);
                          });
                    }),
              ),
              const SizedBox(
                height: 12.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}