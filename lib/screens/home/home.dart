import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genius_shop/constants/constant.dart';
import 'package:provider/provider.dart';
import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore/firebase_firestore.dart';
import '../../models/category_model/category_model.dart';
import '../../models/product_model/product_model.dart';
import '../../provider/app_provider.dart';
import '../../utils/screen_utils.dart';
import '../category_view/category_view.dart';
import '../product_details/product_details.dart';
import '../../widgets/products_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

    productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];

  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "عبقرينو للتسوق",
            style:TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const TopTitles(subtitle: "", title: "E Commerce"),
                          defaultFormField(
                            onChange: (value) {
                              searchProducts(value);
                            },
                              controller:search,
                              type: TextInputType.text,
                              validate: (String? value){
                                if(value!.isEmpty){
                                  return "فضلا ادخل كلمة البحث";
                                }
                                return null;
                              },
                              label: "ابحث عن منتج",
                              prefix:Icons.search),
                          const SizedBox(
                            height: 24.0,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'الاقسام',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              // TextButton(
                              //   onPressed: () {
                              //
                              //   },
                              //   child: const Text(
                              //     'See All',
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                    categoriesList.isEmpty
                        ? const Center(
                            child: Text("الاقسام غير متوفرة"),
                          )
                        : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categoriesList
                            .map(
                              (e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Routes.instance.push(
                                    widget:
                                    CategoryView(categoryModel: e),
                                    context: context);
                              },
                              child: Column(
                                children: [
                                  Card(
                                    color: Colors.white,
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    child: SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: Image.network(e.image),
                                    ),
                                  ),
                                  Text(
                                    e.name,
                                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                            .toList(),
                            ),
                          ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    !isSearched()
                        ? const Padding(
                            padding: EdgeInsets.only(top: 12.0, right: 12.0),
                            child: Text(
                              "المنتجات المميزة",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              // style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          )
                        : SizedBox.fromSize(),
                    const SizedBox(
                      height: 5.0,
                    ),
                    search.text.isNotEmpty && searchList.isEmpty
                        ? const Center(
                            child: Text("لا يوجد منتجات مطابقة للبحث"),
                          )
                        : searchList.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GridView.builder(
                                    padding: const EdgeInsets.only(bottom: 50),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: searchList.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (ctx, index) {
                                      ProductModel singleProduct =
                                          searchList[index];
                                      return  ProductsCard(
                                          description: singleProduct.description,
                                          image: singleProduct.image ,
                                          name: singleProduct.name,
                                          price:"السعر : ${singleProduct.price}",
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
                              )
                            : productModelList.isEmpty
                                ? const Center(
                                    child: Text("لا يوجد منتجات متاحة"),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: GridView.builder(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: productModelList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 20,
                                                crossAxisSpacing:20,
                                                childAspectRatio: 0.7,
                                                crossAxisCount: 2),
                                        itemBuilder: (ctx, index) {
                                          ProductModel singleProduct =
                                              productModelList[index];
                                          return ProductsCard(
                                            description: singleProduct.description,
                                              image: singleProduct.image ,
                                              name: singleProduct.name,
                                              price:"السعر : ${singleProduct.price}",
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

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
