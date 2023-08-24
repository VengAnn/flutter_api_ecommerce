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
  late Future<List<ProductResModel>> _productResModel;

  @override
  void initState() {
    _productResModel = APIHelper.getProduct(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: const Text("shop Online"),
      ),
      body: FutureBuilder(
        future: _productResModel,
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
            child: GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: 1 / 1.5,
              ),
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Product_cart_reusable_widget(product: product);
              },
            ),
          );
        },
      ),
    );
  }
}
