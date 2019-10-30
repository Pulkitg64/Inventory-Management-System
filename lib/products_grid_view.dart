import 'package:flutter/material.dart';
import 'package:hello_world/placeorder.dart';

class ProductsGridView extends StatefulWidget {
  @override
  _ProductsGridViewState createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  var product_list=[
    {
      "name":"Hide n Seek",
      "picture":"images/c4.jpg",
      "price":"30",
    },
    {
      "name":"Lays",
      "picture":"images/c3.jpg",
      "price":"20",
    },
    {
      "name":"Bourn Vita",
      "picture":"images/c1.jpg",
      "price":"100",
    },
    {
      "name":"Chocolate",
      "picture":"images/c2.jpg",
      "price":"50",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ),
      itemBuilder:(BuildContext context,int index){
        return Single_prod(
          product_name: product_list[index]['name'],
          product_pictures: product_list[index]['picture'],
          product_price: product_list[index]['price'],
        );
      },
      
    );
  }
}

class Single_prod extends StatelessWidget {
  final product_name;
  final product_pictures;
  final product_price;

  Single_prod({
    this.product_name,
    this.product_pictures,
    this.product_price,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag:product_name,
        child: Material(
          child: InkWell(
            onTap: (){},
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(product_name, style:TextStyle(fontWeight: FontWeight.bold)),
                  title: Text("\₹$product_price", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                  ),
                  )
              ), child: Image.asset(
                product_pictures,
                fit:BoxFit.cover,
                ),
            )
           )
        ), 
        ),
    );
  }
}