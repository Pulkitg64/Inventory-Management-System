import 'package:flutter/material.dart';
import 'registerproduct.dart';

class ShopPage extends StatelessWidget{
  @override
 Widget build(BuildContext context) {
   
   return new Scaffold(
      appBar: AppBar(
       title: const Text('Shopkeeper'),
      ),
      body: ListView(
        children: <Widget>[
          OutlineButton(
          onPressed: (){},
          borderSide: BorderSide(
            width: 5.0,
            color: Colors.deepPurpleAccent
          ),
          color: Colors.deepPurpleAccent,
          highlightedBorderColor: Colors.purple,
          splashColor: Colors.green,
          //highlightColor: Colors.red,
          child: Text("Fetch Order"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0), bottom: Radius.circular(1.0))
          ),
        ),
        OutlineButton(
          onPressed: (){},
          borderSide: BorderSide(
            width: 5.0,
            color: Colors.deepPurpleAccent
          ),
          color: Colors.deepPurpleAccent,
          highlightedBorderColor: Colors.purple,
          splashColor: Colors.green,
          //highlightColor: Colors.red,
          child: Text("View Order"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0), bottom: Radius.circular(1.0))
          ),
        ),
        OutlineButton(
          onPressed: (){},
          borderSide: BorderSide(
            width: 5.0,
            color: Colors.deepPurpleAccent
          ),
          color: Colors.deepPurpleAccent,
          highlightedBorderColor: Colors.purple,
          splashColor: Colors.green,
          //highlightColor: Colors.red,
          child: Text("Initiate Transaction"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0), bottom: Radius.circular(1.0))
          ),
        ),
        OutlineButton(
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomeMaterial()));},
          borderSide: BorderSide(
            width: 5.0,
            color: Colors.deepPurpleAccent
          ),
          color: Colors.deepPurpleAccent,
          highlightedBorderColor: Colors.purple,
          splashColor: Colors.green,
          //highlightColor: Colors.red,
          child: Text("Register Product"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0), bottom: Radius.circular(1.0))
          ),
        ),
        OutlineButton(
          onPressed: (){},
          borderSide: BorderSide(
            width: 5.0,
            color: Colors.deepPurpleAccent
          ),
          color: Colors.deepPurpleAccent,
          highlightedBorderColor: Colors.purple,
          splashColor: Colors.green,
          //highlightColor: Colors.red,
          child: Text("Update Inventory"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0), bottom: Radius.circular(1.0))
          ),
        ),
        ],
      ) ,
    );
       
  }



}