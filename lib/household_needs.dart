import 'package:flutter/material.dart';
import 'package:hello_world/db/product.dart';
import 'cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HouseholdNeeds extends StatefulWidget {
  @override
  _HouseholdNeedsState createState() => _HouseholdNeedsState();
}

class _HouseholdNeedsState extends State<HouseholdNeeds> {
  
  bool reviewFlag = false;
  var products;
  @override
  void initState(){

    super.initState();

    ProductService().getproduct('Household Needs')
    .then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){

        reviewFlag = true;
        products = docs.documents[0].data;
      }

    });
  }

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
      body: Card(
    
        child: ListTile(
        // =================LEADING PICTURE===========
   
        leading: Image.asset(products['picture'],width: 80.0,height: 80.0),
        //===================TITLE=================
        title: Text(products['name']),
        //===================SUBTITLE===============
        subtitle: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              child: Text("\₹$products['price']",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.red),)
            ), 
            Container(
              width: 120.0,
            ),
          ],  
        ),
        trailing:FittedBox(
          fit: BoxFit.fill,
          child:Column(
            children: <Widget>[
              Text(products['quantity'],style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
            ],
          ),
        )  
      ),
    )
    );
  }
}