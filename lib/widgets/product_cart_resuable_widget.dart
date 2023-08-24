// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/product_res_model.dart';

// ignore: camel_case_types
class Product_cart_reusable_widget extends StatelessWidget {
  const Product_cart_reusable_widget({
    super.key,
    required this.product,
  });

  final ProductResModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
            //
            const SizedBox(
              height: 5.0,
            ),
            //
            Text(
              product.title,
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('\$${product.price}'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
