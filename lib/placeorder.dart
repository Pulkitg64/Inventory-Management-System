import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:hello_world/cart_product.dart';
import 'package:hello_world/main.dart';
import 'package:hello_world/productlist.dart';
import 'customer.dart';
import 'product_categories.dart';
import 'package:provider/provider.dart';
import 'horizontal_listview.dart';
import 'products_grid_view.dart';
import 'cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'provider/user_provider.dart';
class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  TextEditingController _searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   // final user = Provider.of<UserProvider>(context);
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

        title:  Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black.withOpacity(0.2),
          elevation: 0.0,
          child:  TextFormField(
            controller: _searchTextController,                    
            decoration: InputDecoration(
              hintText: "  Search...",
        
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value.isEmpty) {
                 return "The search field cannot be empty";
              }                   
              return null;
            },
          ),    
        ),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search,color: Colors.black),onPressed: (){},),
          new IconButton(icon: Icon(Icons.shopping_basket,color: Colors.black),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> new Single_cart_product()));},)
        ],
      ),
    
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
              accountName: Text('Priyanshu'),
              accountEmail: Text('pgupta@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white,),
                ),
              ),
              decoration: new BoxDecoration(
                  color: Colors.orange
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CustPage()));
              },
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new Single_cart_product()));
              },
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new ProductList()));
              },
              child: ListTile(
                title: Text('Products'),
                leading: Icon(Icons.dashboard),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new ProductCategories()));
              },
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.category),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite),
              ),
            ),

            Divider(),

            InkWell(
              onTap: (){
                //user.signOut();
              },
              child: ListTile(
                title: Text('Log out'),
                leading: Icon(Icons.transit_enterexit, color: Colors.grey,),
              ),
            ),

          ],
        ),
      ),

      body:Column(
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