import 'package:api_with_facke_store/models/product_res_model.dart';
import 'package:api_with_facke_store/services/api_helper.dart';
import 'package:flutter/material.dart';
import '../../widgets/product_cart_resuable_widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<ProductResModel>> _productFuture;
  late Future<List<String>> _futureCategory;

  @override
  void initState() {
    _productFuture = APIHelper.getProduct(context);
    _futureCategory = APIHelper.getProductCategory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 70, 121, 132),
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text("shop Online"),
      ),
      body: FutureBuilder<List>(
        future: Future.wait([_productFuture, _futureCategory]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('error with snapshot: ${snapshot.hasError}'),
            );
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No product available'),
            );
          }
          //and opposite condition have data return
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 96,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            prefixIcon: const Icon(Icons.search),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            hintText: "Search Products",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      //
                      const SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () => _show(context, snapshot.data![1]),
                        child: Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          child: const Icon(Icons.filter_list),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: snapshot.data![0].length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: 1 / 1.5,
                    ),
                    itemBuilder: (context, index) {
                      final product = snapshot.data![0][index];
                      return Product_cart_reusable_widget(product: product);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //Method show BottomSheet
  // ignore: unused_element
  void _show(BuildContext context, List<String> lsCategories) {
    showModalBottomSheet(
      isScrollControlled: true,
      // elevation: 5,
      context: context,
      builder: (context) => Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: ListView.builder(
          itemCount: lsCategories.length,
          itemBuilder: (context, index) {
            IconData icon;
            // Set the icon based on the index or any other logic
            switch (index) {
              case 0:
                icon = Icons.electric_bolt_outlined;
              case 1:
                icon = Icons.work;
              case 2:
                icon = Icons.category;
              default:
                icon = Icons.shopping_bag_outlined;
            }
            String categoryName = lsCategories[index];
            return ListTile(
              onTap: () {
                _productFuture =
                    APIHelper.getProductByCategoryName(context, categoryName);
                setState(() {});
                Navigator.pop(context);
              },
              leading: Icon(icon),
              // ignore: unnecessary_string_interpolations
              title: Text("${lsCategories[index]}"),
            );
          },
        ),
      ),
    );
  }
}
