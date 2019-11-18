import 'package:flutter/material.dart';
import 'package:hello_world/adminhome.dart';
import 'package:hello_world/customer.dart';
import 'shopkeeper.dart';
//import 'login.dart';
import 'adminhome.dart';
import 'placeorder.dart';

void main(){ 
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Widgets Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new HomePage(), 
      routes: <String, WidgetBuilder>{
        'Customer': (BuildContext context)=> CustPage(),
        'Shopkeeper': (BuildContext context)=> Admin(),  
        //'Admin': (BuildContext context)=> Admin(),
        //'Place Order': (BuildContext context)=> PlaceOrder(),
      
        //'Medical': (BuildContext context)=> MedicalLogin(),
        //'Login': (BuildContext context)=> Login(),
//        'Medical Home': (BuildContext context)=> MedicalHome(),

      },
    );
  }
}

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var widgetList = ["Customer","Shopkeeper",];

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: ListView.builder(
          itemCount: widgetList.length,
          shrinkWrap: true,
          itemBuilder: (builder, index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('${widgetList[index]}');
                },
                child: Card(
                  elevation: 5.0,
                  child: new Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Text(widgetList[index], style: TextStyle(color: Colors.black, fontSize: 20.0),),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                  ),
                ),
              ),
            );
          }),
    );
  }
}
