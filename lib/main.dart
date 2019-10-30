import 'package:flutter/material.dart';
import 'container_widget.dart';
import 'text_widget.dart';
import 'appar_widget.dart';
import 'column_widget.dart';
import 'row_widget.dart';
import 'button_widget.dart';
import 'stack_widget.dart';
import 'customer.dart';
import 'shopkeeper.dart';
import 'placeorder.dart';

void main() => runApp(new MyApp());

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
        'Place Order': (BuildContext context)=> PlaceOrder(),
        'Customer': (BuildContext context)=> CustPage(),
        'Shopkeeper': (BuildContext context)=> ShopPage(),
        'Text': (BuildContext context) => TextWidget(),
        'Appbar': (BuildContext context) => AppBarWidget(),
        'Container' : (BuildContext context) => ContainerWidget(),
        'Column' : (BuildContext context) => ColumnWidget(),
        'Row' : (BuildContext context) => RowWidget(),
        'Button' : (BuildContext context) => ButtonWidget(),
        'Stack' : (BuildContext context) => StackWidget(),


      },
    );
  }
}

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var widgetList = ["Place Order","Customer","Shopkeeper","Text", "Appbar", "Container", "Column", "Row", "Button", "Stack" ];

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
