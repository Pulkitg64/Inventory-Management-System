import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'db/category.dart';
import 'db/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';



class ProductCategories extends StatefulWidget {
  @override
  _ProductCategoryList createState() => _ProductCategoryList();
}

class _ProductCategoryList extends State<ProductCategories>{
  @override
  Widget build(BuildContext context) {
    var categoryList = ["Frozen Foods", "Snacks", "Groceries & Staples", "Personal Needs", "Dairy Products", "Household Needs"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Categories"),
      ),
      body: ListView.builder(
          itemCount: categoryList.length,
          shrinkWrap: true,
          itemBuilder: (builder, index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
              child: InkWell(
                onTap: (){
                  //Navigator.of(context).pushNamed('${widgetList[index]}');
                },
                child: Card(
                  elevation: 5.0,
                  child: new Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Text(categoryList[index], style: TextStyle(color: Colors.black, fontSize: 20.0),),
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
