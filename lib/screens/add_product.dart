import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homepage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatelessWidget {
  // Controller untuk semua isi inputan, untuk menyimpan semua inputan ke controller
  final _formKey = GlobalKey<FormState>();
  // Controller untuk menyimpan inputan
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  final String url = 'http://10.0.2.2:8000/api/products';

  Future saveProduct() async {
    final response = await http.post(Uri.parse(url), body: {
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
        appBar: AppBar(title: Text('Add Product')),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  // controller untuk memberi nama inputan sesuai controller
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Name :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: "Description :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Description";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: "Price :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Price";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageUrlController,
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
                        saveProduct().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Product Berhasil di tambahkan !')));
                        });
                      } else {}
                    },
                    child: Text('Save'))
              ],
            )));
  }
}
