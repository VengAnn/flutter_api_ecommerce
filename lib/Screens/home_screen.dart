import 'dart:convert';

import 'package:api_with_facke_store/constants/constant.dart';
import 'package:api_with_facke_store/models/product_res_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<ProductResModel>> _productResModel;
  Future<List<ProductResModel>> _getProduct() async {
    try {
      final response = await http.get(Uri.parse('$kbaseUrl$kproductUrl'));
      final data = jsonDecode(response.body); //convert to type dart
      //print("data: $data");
      return data
          .map<ProductResModel>((e) => ProductResModel.fromJson(e))
          .toList();
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'error: $e',
      );
      throw Exception("Error: $e");
    }
  }

  @override
  void initState() {
    _productResModel = _getProduct();
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
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      //
                    ],
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
