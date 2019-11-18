import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/confirm_order.dart';
class Single_cart_product extends StatefulWidget {
  @override
  _Single_cart_productState createState() => _Single_cart_productState();
}

class _Single_cart_productState extends State<Single_cart_product> {

  Future _data;
  Future getCart() async{

    var firestore = Firestore.instance;
    
    QuerySnapshot qn = await firestore.collection('cart').getDocuments();
    return qn.documents;
  }
  @override
  void initState(){
    super.initState();

    _data = getCart();
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
            return  ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (_, index){
                
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                   child: ListTile(
                    // =================LEADING PICTURE===========
                    leading: Image.network(snapshot.data[index].data['picture'],width: 80.0,height: 80.0),
                    //===================TITLE=================
                    title: Text(snapshot.data[index].data['name']),
                    //===================SUBTITLE===============
                    subtitle: Row(
                      children: <Widget>[
                        Container(
                          
                          alignment: Alignment.bottomLeft,
                          child: Text(snapshot.data[index].data['price'].toString(),style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.red),)
                        ), 
                        Container(
                          width: 120.0,
                        ),
                      ],  
                    ),
                    trailing:FittedBox(
                      fit: BoxFit.fill,
                      child:
                      Column(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.arrow_drop_up),iconSize: 40, onPressed: () {}),
                          Text(snapshot.data[index].data['quantity'].toString(),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                          IconButton(icon: Icon(Icons.arrow_drop_down),iconSize: 40, onPressed: () {}),
                        ],
                      ),
                    ),
                  
                  ),
            
                   ),
                );
              });
          }
        }
      ),

      bottomNavigationBar: 
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text("Total"),
                  subtitle: Text("₹230"),
                )
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ConfirmOrder()));
                  },
                  child: Text("Check Out",style: TextStyle(color: Colors.white)),
                  color: Colors.orange,             
                )
              ),
            ],
          ),
        ),
    );
  }
}