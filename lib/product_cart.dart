import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final int index;
  const ProductCart({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: index % 2 == 0
            ? Color.fromRGBO(216, 240, 253, 1)
            : Color.fromARGB(216, 204, 205, 205),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // SizedBox(
            //   height: 5,
            // ),

            // SizedBox(
            // height: 5,
            // ),
            Center(child: Image.asset(image, height: 175)),
            Text(
              '\৳$price',
              style: Theme.of(context).textTheme.bodySmall,
            ), // Image(image: AssetImage(image)),
          ],
        ),
      ),
    );
  }
}
