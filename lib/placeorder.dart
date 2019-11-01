import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'horizontal_listview.dart';
import 'products_grid_view.dart';
import 'cart.dart';
class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  Widget build(BuildContext context) {
  Widget image_carousel = new Container(
    height: 200.0,
    child: Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('images/c1.jpg'),
        AssetImage('images/c2.jpg'),
        AssetImage('images/c3.jpg'),
        AssetImage('images/c4.jpg'),
        AssetImage('images/c5.jpg'),
      ],
      indicatorBgPadding: 4.0,
      dotSize: 4.0,
      dotBgColor: Colors.transparent,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
    ),

  ); 
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search,color: Colors.black),onPressed: (){},),
          new IconButton(icon: Icon(Icons.shopping_basket,color: Colors.black),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));},)
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[

          ],
        )
      ),
      body: Column(
        children: <Widget>[
          //image carousel begins 
          image_carousel,

          Divider(),
          //Padding Widget
          Padding(padding: const EdgeInsets.all(1.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text('  Category'),
            ),
          ),
          //Horizontal List View

          HorizontalList(),
          Divider(),
         
          Container(
            height: 20.0,
            child: Text('  Recent Products',),
            alignment: Alignment.centerLeft,
          ),
          // //Padding Widget
          // Padding(padding: const EdgeInsets.all(35.0),
          // child: Text('Recent Products', textAlign: TextAlign.left,textDirection: TextDirection.ltr,),),

          //grid View

          Flexible(
            
            child: ProductsGridView(),
          )

        ],
      ),
    );
  }
}