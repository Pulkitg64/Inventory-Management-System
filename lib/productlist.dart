import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TextEditingController _searchTextController = TextEditingController();

 
 Future _data;
 Future getCat() async{

  var firestore = Firestore.instance;

  QuerySnapshot qn = await firestore.collection('products').getDocuments();
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
         
        ],
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
              //       var route = MaterialPageRoute(
              //         builder: (BuildContext context) => NextPage(value: snapshot.data[index].data['category']),
              //       );
              //       Navigator.of(context).push(route);
              //  //   Naator.push(context, new MaterialPageRoute(builder: (context) => ProductCategories(categ:  ProductCategories(snapshot.data[index].data['category']))));
                  },
                  child: Card(
                  elevation: 5.0,
                  child: new Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Text(snapshot.data[index].data['name'], style: TextStyle(color: Colors.black, fontSize: 20.0),),
                          // Text('Quantity:', style: TextStyle(color: Colors.black, fontSize: 20.0),),
                          // Text(snapshot.data[index].data['quantity'], style: TextStyle(color: Colors.black, fontSize: 20.0),),
                          // Text('Price:', style: TextStyle(color: Colors.black, fontSize: 20.0),),
                          // Text(snapshot.data[index].data['price'], style: TextStyle(color: Colors.black, fontSize: 20.0),),
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