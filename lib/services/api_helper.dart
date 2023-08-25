import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../constants/constant.dart';
import '../models/product_res_model.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  static Future<List<ProductResModel>> getProduct(BuildContext context) async {
    try {
      // ignore: unnecessary_brace_in_string_interps
      final response = await http.get(Uri.parse("${kbaseUrl}${kproductUrl}"));
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

  //
  static Future<List<String>> getProductCategory(BuildContext context) async {
    try {
      final uri = Uri.parse("https://fakestoreapi.com/products/categories");
      final response = await http.get(uri);
      final data = jsonDecode(response.body);
      print("data $data");
      return data.map<String>((e) => e.toString()).toList();
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

  //
  static Future<List<ProductResModel>> getProductByCategoryName(
      BuildContext context, String categoryName) async {
    try {
      String uri = "https://fakestoreapi.com/products/category/$categoryName";
      final response = await http.get(Uri.parse(uri));
      final data = jsonDecode(response.body);
      print("data $data");
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
}
