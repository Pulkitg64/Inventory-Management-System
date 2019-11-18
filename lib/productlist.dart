import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_view_details.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: InkWell(
                  onTap: ()=> Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> new ProductViewDetail(
                      //passing the values of product grid view to product view details
                      product_detail_name: snapshot.data[index].data['name'],
                      product_detail_price: snapshot.data[index].data['price'],
                      product_detail_picture: snapshot.data[index].data['picture'],
                      product_detail_quantity: snapshot.data[index].data['quantity'],
                    )
                  )
                  
                  ),
                
                child: Container(
                height: 150.0,
                child: GridTile(
                  child: Container(
                    color: Colors.white,
                    //child: Image.asset('images/c3.jpg'),
                    child: Image.network(snapshot.data[index].data['picture']),
                  ),

                  footer: Container(
              color: Colors.white,     
              child: ListTile(
                title: Text(snapshot.data[index].data['name'], style:TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(snapshot.data[index].data['price'].toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800,),),
              )
                  ),
              
                ),
                
              )
              ),
            );
            }
          );
          }
        }
      )

    
    );
  }  

}