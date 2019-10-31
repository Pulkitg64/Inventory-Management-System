import 'package:flutter/material.dart';


class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var Products_on_the_cart=[
    {
      "name":"Amul Butter",
      "picture":"images/c6.jpeg",
      "price":"30",
      "Qty": 5,
    },
    {
      "name":"Shampoo",
      "picture":"images/c7.jpg",
      "price":"200",
      "Qty": 7,
    }, 
  ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: Products_on_the_cart.length,
      itemBuilder: (context, index){
        return Single_cart_product(
          cart_product_name: Products_on_the_cart[index]["name"] ,
          cart_product_pictures: Products_on_the_cart[index]["picture"],
          cart_product_price: Products_on_the_cart[index]["price"],
          cart_product_qty: Products_on_the_cart[index]["Qty"],
        );

      },
    );
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_product_name;
  final cart_product_pictures;
  final cart_product_price;
  var cart_product_qty;

  Single_cart_product({
    this.cart_product_name,   
    this.cart_product_pictures,
    this.cart_product_price,
    this.cart_product_qty,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // =================LEADING PICTURE===========
        leading: Image.asset(cart_product_pictures,width: 80.0,height: 80.0),
        //===================TITLE=================
        title: Text(cart_product_name),
        //===================SUBTITLE===============
        subtitle: Row(
          children: <Widget>[
            
            Container(
              alignment: Alignment.bottomLeft,
              child: Text("\$$cart_product_price",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.red),)
            ), 
            Container(
              width: 120.0,
            ),
          ],  
        ),
        trailing:FittedBox(
          fit: BoxFit.fill,
          child:
          Column(
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_drop_up),iconSize: 40, onPressed: () {}),
              Text('$cart_product_qty',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              IconButton(icon: Icon(Icons.arrow_drop_down),iconSize: 40, onPressed: () {}),

            ],
          ),
        ),
            
      ),
        
    );
  }
}