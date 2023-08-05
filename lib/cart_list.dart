import 'package:flutter/material.dart';
import 'package:shop_app/cart_provider.dart';
// import 'package:shop_app/global_variables.dart';
import 'package:provider/provider.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    // print(Provider.of<String>(context));
    final cart = context.watch<CartProvider>().cart;
    // final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Cart')),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index){
          final cartItem = cart[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(cartItem['imageUrl'] as String),
              radius: 30,
            ),
            trailing: IconButton(
              onPressed: (){
                showDialog(
                // barrierDismissible: false, // not allow leaving dialog 
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete Product',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                    content: Text('Are you sure want to delete item from cart?'),
                    actions: [
                      TextButton(onPressed: (){
                        context.read<CartProvider>().removeProduct(cartItem);
                        // Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
                        Navigator.of(context).pop();
                      }, child: Text('Yes', style: TextStyle(color: Colors.red))),
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text('No', style: TextStyle(color: Colors.green))),

                    ],
                  );
                },
                );
              },
              icon: Icon(Icons.delete,
              color: Colors.red,)
            ),
            title: Text(
              cartItem['title'].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text(
              '\$'+cartItem['price'].toString(),
            ),
          );
        },
        ),
    );
  }
}