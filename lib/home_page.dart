import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/product_cart.dart';
import 'package:shop_app/product_details_page.dart';
import 'package:shop_app/product_list.dart';
import 'package:shop_app/cart_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Bata'];

  late String selectedFilter;
  int currentPage = 0;

  List<Widget> pages = [
    ProductList(),
    CartList(),
  ];

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      body: IndexedStack( // for maintain scroll position
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        currentIndex: currentPage,
        onTap: (value){
          setState(() {
            currentPage = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: '',),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
          label: '',),
        ],
      ),
    );
  }
}