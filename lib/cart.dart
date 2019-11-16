import 'package:flutter/material.dart';
import 'cart_product.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        
        title: Text('Your Cart',),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search,color: Colors.black),onPressed: (){},),
        ],
      ),
      body: new Single_cart_product(),
      bottomNavigationBar: 
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text("Total"),
                  subtitle: Text("₹230"),
                )
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: (){},
                  child: Text("Check Out",style: TextStyle(color: Colors.white)),
                  color: Colors.orange,             
                )
              ),
            ],
          ),
        ),
    );
  }
}