import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'categorydetail.dart';
import 'package:hello_world/horizontal_listview.dart';
import 'package:hello_world/main.dart';
import 'db/category.dart';
import 'db/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductCategories extends StatefulWidget {
  @override
  _ProductCategoriesState createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
 
 
 Future _data;
 Future getCat() async{

  var firestore = Firestore.instance;

  QuerySnapshot qn = await firestore.collection('categories').getDocuments();
   return qn.documents;
 }

  @override
  void initState(){
    super.initState();

    _data = getCat();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories',style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading:IconButton(
          icon: Icon(
            Icons.close,color: Colors.black
          ),
          onPressed: ()
          {Navigator.pop(context);
          },
        )
        //  onPressed: Navigator.pop(),
      ),
     
      body: FutureBuilder(
        future: _data,
        builder: (_,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: Text("Loading....."),
            );
          }
          else
          {
            return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (_, index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: InkWell(
                  onTap: (){
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) => NextPage(value: snapshot.data[index].data['category']),
                    );
                    Navigator.of(context).push(route);
               //   Naator.push(context, new MaterialPageRoute(builder: (context) => ProductCategories(categ:  ProductCategories(snapshot.data[index].data['category']))));
                  },
                  child: Card(
                  elevation: 5.0,
                  child: new Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Text(snapshot.data[index].data['category'], style: TextStyle(color: Colors.black, fontSize: 20.0),),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      )
                  ),
                ),
              ),
            );
          });
          }
        }
      )

    
    );
  }  

}
