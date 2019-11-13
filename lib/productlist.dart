import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: ListProducts(),
    );
  }
}

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
   Future getProduct() async{
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection("products").getDocuments();
    return qn.documents;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getProduct(),
        builder: (_,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child:Text("Loading......") ,
            );
        } 
        else{
          ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(_,index){
              return ListTile(

                title: Text(snapshot.data[index].data['name']),
              );
            },

              
          );
          
        }
      }),
    );
  }
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}