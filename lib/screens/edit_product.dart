import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homepage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  // ngambil data seperti detail product
  final Map product;
  EditProduct({required this.product});
  //
  // Controller untuk semua isi inputan, untuk menyimpan semua inputan ke controller
  final _formKey = GlobalKey<FormState>();
  // Controller untuk menyimpan inputan
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  final String url = 'http://10.0.2.2:8000/api/products/';

  Future updateProduct() async {
    final response =
        await http.put(Uri.parse(url + product['id'].toString()), body: {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "price": _priceController.text,
      "image_url": _imageUrlController.text
    });

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Edit Product')),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  // controller untuk memberi nama inputan sesuai controller
                  controller: _nameController..text = product['name'],
                  decoration: InputDecoration(labelText: "Name :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _descriptionController
                    ..text = product['description'],
                  decoration: InputDecoration(labelText: "Description :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Description";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _priceController..text = product['price'],
                  decoration: InputDecoration(labelText: "Price :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Price";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _imageUrlController..text = product['image_url'],
                  decoration: InputDecoration(labelText: "Image Url :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Image Url";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      // untuk memvalidasi controller _formkey
                      if (_formKey.currentState!.validate()) {
                        updateProduct().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          // Untuk menampilkan pesan
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Product Berhasil di Update !')));
                        });
                      } else {}
                    },
                    child: Text('Update'))
              ],
            )));
  }
}
