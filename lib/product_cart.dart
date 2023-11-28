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
    // double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 300,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: index % 2 == 0
            ? const Color.fromRGBO(216, 240, 253, 1)
            : const Color.fromARGB(216, 204, 205, 205),
      ),
      child: Container(
        // width: double.infinity,
        width: 300,
        padding: const EdgeInsets.all(8),
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
            Center(
              child: Image.network(
                height: 175,
                image,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Text('Error loading image');
                },
              ),
            ),
            Text(
              '৳$price',
              style: Theme.of(context).textTheme.bodySmall,
            ), // Image(image: AssetImage(image)),
          ],
        ),
      ),
    );
  }
}
