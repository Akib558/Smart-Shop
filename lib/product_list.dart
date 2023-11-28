import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/product_details_page.dart';
import 'package:shop_app/product_cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Addidas', 'Nike', 'Bata'];
  late String selectedFilter;
  int currentPage = 0;
  late List mainData;

  Future<List> fetchData() async {
    var url = Uri.parse(
        'https://fakestoreapi.com/products'); // Replace with your API endpoint
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
        // Process jsonData here
        // print(jsonData);
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    // fetchData();
  }

  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.95, // Adjust as needed
  );

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(118, 118, 118, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "SmartShop",
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Expanded(
              //   child: TextField(
              //     decoration: InputDecoration(
              //       hintText: "Search",
              //       prefixIcon: Icon(Icons.search),
              //       border: border,
              //       enabledBorder: border,
              //       focusedBorder: border,
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      // vertical: 20,
                      horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(169, 170, 171, 111),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 249, 249, 249),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      label: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          filter,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data available'));
                } else {
                  List<dynamic> dataList = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          // return Text(dataList[index]['title']);
                          return ProductCart(
                            title: dataList[index]['title'] as String,
                            price: dataList[index]['price'] * 1.0 as double,
                            image: dataList[index]['image'] as String,
                            index: index,
                          );
                        }),
                  );
                  // return ListView.builder(
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: dataList.length,
                  //   itemBuilder: (BuildContext context, int index) {},
                  // );
                }
              }),
        ],
      ),
    );
  }
}

// PageView.builder(
//                 // controller: _pageController,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   if (products[index]["company"] == selectedFilter ||
//                       selectedFilter == "All") {
//                     final product = products[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) {
//                             return ProductDetailsPage(product: product);
//                           },
//                         ));
//                       },
//                       child: ProductCart(
//                         title: product['title'] as String,
//                         price: product['price'] as double,
//                         image: product['imageUrl'] as String,
//                         index: index,
//                       ),
//                     );
//                   }
//                   // else {
//                   // return null;
//                   // }
//                 // })
