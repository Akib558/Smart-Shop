import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final int index;
  const ProductCart({super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: index%2 == 0 ? Color.fromRGBO(216, 240, 253, 1) :  Color.fromARGB(216, 204, 205, 205),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium,),
          SizedBox(height: 5,),
          Text('\$$price', style: Theme.of(context).textTheme.bodySmall,),
          SizedBox(height: 5,),
          Center(child: Image.asset(image, height: 175)),
          // Image(image: AssetImage(image)),
        ],
        ),
    );
  }
}