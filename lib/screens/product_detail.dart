import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  // Map itu tipe data product untuk ngambil datanya
  final Map product;

  // Constructor
  ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Column(children: [
        Container(
          child: Image.network(product['image_url']),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                product['name'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Text(
          product['description'],
          style: TextStyle(fontSize: 18),
        ),
        Text(
          product['price'],
          style: TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
