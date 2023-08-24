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
}
