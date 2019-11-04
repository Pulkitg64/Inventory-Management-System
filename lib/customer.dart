import 'package:flutter/material.dart';
import 'placeorder.dart';


class CustPage extends StatelessWidget{
  @override
 Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
       title: const Text('Customer'),
      ),
      body: ListView(
        //color: Colors.white,
      
        children: <Widget>[
          MaterialButton(
          minWidth: 5.0,
          onPressed: ()=> Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> new PlaceOrder())
            ),
          colorBrightness: Brightness.dark,
          color: Colors.deepPurpleAccent,
          elevation: 20.0,
          splashColor: Colors.green,
          //highlightColor: Colors.red,
          highlightElevation: 1.0,
          child: Text("Place Order"),
        ),
        MaterialButton(
          minWidth: 250.0,
          onPressed: (){},
          colorBrightness: Brightness.dark,
          color: Colors.deepPurpleAccent,
          elevation: 20.0,
          splashColor: Colors.green,
          //highlightColor: Colors.red,
          highlightElevation: 1.0,
          child: Text("Order Confirmation"),
        ),
        ],
      
    )
    );
       
  }



}
