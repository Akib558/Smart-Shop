import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/product_details_page.dart';
import 'package:shop_app/product_cart.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Addidas', 'Nike', 'Bata'];
  late String selectedFilter;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.95, // Adjust as needed
  );

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
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
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "ShopLuxe",
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
                  padding: EdgeInsets.symmetric(
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
                      side: BorderSide(
                        color: Color.fromARGB(255, 249, 249, 249),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      label: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Text(
                          filter,
                          style: TextStyle(
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
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: PageView(
            controller: _pageController,
            children: [
              for (var index = 0; index < products.length; index++)
                if (products[index]["company"] == selectedFilter ||
                    selectedFilter == "All")
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ProductDetailsPage(product: products[index]);
                        },
                      ));
                    },
                    child: ProductCart(
                      title: products[index]['title'] as String,
                      price: products[index]['price'] as double,
                      image: products[index]['imageUrl'] as String,
                      index: index,
                    ),
                  ),
            ],
          )),
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