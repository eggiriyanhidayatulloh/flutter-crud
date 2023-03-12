import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/add_product.dart';
import 'package:flutter_application_1/screens/edit_product.dart';
import 'package:flutter_application_1/screens/product_detail.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'http://10.0.2.2:8000/api/products';

  // android emulator http://10.0.2.2
  Future getProducts() async {
    var response = await http.get(Uri.parse(url));

    return json.decode(response.body);
  }

  // function delete
  Future deleteProduct(String productId) async {
    String url1 = 'http://10.0.2.2:8000/api/products/' + productId;

    var response = await http.delete(Uri.parse(url1));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getProducts();
    return Scaffold(
        // untuk membuat tombol tambah product
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProduct()));
            },
            child: Icon(Icons.add)),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 226, 7, 7),
          title: Text('Erhit Store'),
        ),
        // karena bentuknya future maka menggunakan futurebuillder
        body: FutureBuilder(
            // future mksdnya datanya ngambil dari function getProducts
            future: getProducts(),
            // untuk parameter nya menggunakan context dan snapshot
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // menggunakan listview.builder karena menampilkan nya sesuai bnyak nya data
                return ListView.builder(
                    // menampilkan data sesuai bnyak nya data
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 180,
                        child: Card(
                          // bayangan card
                          elevation: 5,
                          child: Row(
                            children: [
                              // gambar di bungkus ini agar ketika disentuh langsung nglink
                              GestureDetector(
                                // ontap apabila di tap akan menjalankan
                                onTap: () {
                                  // berpindah halaman ketika di tap
                                  Navigator.push(
                                      context,
                                      // pindah ke page ProductDetail
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                product: snapshot.data['data']
                                                    [index],
                                              )));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: 120,
                                  width: 120,
                                  child: Image.network(
                                    snapshot.data['data'][index]['image_url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // expanded mengisi penuh halam kosong disamping gmbar
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot.data['data'][index]['name'],
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot.data['data'][index]
                                              ['description'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data['data'][index]
                                                ['price'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  EditProduct(
                                                                    product: snapshot
                                                                            .data['data']
                                                                        [index],
                                                                  )));
                                                },
                                                child: Icon(Icons.edit),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    deleteProduct(snapshot
                                                            .data['data'][index]
                                                                ['id']
                                                            .toString())
                                                        .then((value) {
                                                      setState(() {});
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  'Product Berhasil di Hapus !')));
                                                    });
                                                  },
                                                  child: Icon(Icons.delete))
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Text('Data Error');
              }
            }));
  }
}
