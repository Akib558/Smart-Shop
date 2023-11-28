import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // final List<String> filters = const ['9', '10', '11', '12'];

  late int selectedFilter;
  // int selectedSize = 0;

  void onTap() {
    if (selectedFilter != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct(
        {
          'id': widget.product['id'],
          'title': widget.product['title'],
          'price': widget.product['price'],
          'imageUrl': widget.product['imageUrl'],
          'company': widget.product['company'],
          'sizes': selectedFilter,
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Successfully added!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please select a size option"),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    selectedFilter = 0;
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.product['title'] as String;
    final image = widget.product['imageUrl'] as String;
    final price = widget.product['price'] as double;
    final List<int> filters = widget.product['sizes'] as List<int>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            // SizedBox(height: 100,),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                image,
                height: 250,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            // SizedBox(height: 80,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 239, 236, 236),
              ),
              child: Column(children: [
                Text(
                  '৳$price',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                              color: Color.fromARGB(255, 46, 46, 46),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                '$filter',
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
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton.icon(
                    onPressed: onTap,
                    //   onPressed: (){
                    //   Provider.of<CartProvider>(context, listen: false).addProduct(widget.product);
                    // },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 5,
                    ),

                    label: const Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
