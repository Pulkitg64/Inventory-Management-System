import 'package:flutter/material.dart';
import 'package:hello_world/horizontal_listview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_view_details.dart';

class CategoryView extends StatefulWidget {
  final String value;

  CategoryView({Key key,this.value}): super(key:key);
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

Future _data;
 Future getCata() async{

  var firestore = Firestore.instance;

  QuerySnapshot qn = await firestore.collection('products').where('category', isEqualTo: "${widget.value}").getDocuments();
   return qn.documents;
 }

  @override
  void initState(){
    super.initState();

    _data = getCata();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (_,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: Text("Loading....."),
          );
        }
        else
        {
          return GridView.builder(
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder:(_,int index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Single_prod(
                  product_name: snapshot.data[index].data['name'],
                  product_pictures: snapshot.data[index].data['picture'],
                  product_price: snapshot.data[index].data['price'],
                ),
              );
            },
      
          );
        }
      }
    );    
  }  
}

class Single_prod extends StatelessWidget {
  final product_name;
  final product_pictures;
  final product_price;

  Single_prod({
    this.product_name,
    this.product_pictures,
    this.product_price,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        child: InkWell(
          onTap: ()=> {},
          child: GridTile(          
            footer: Container(
              color: Colors.white,     
              child: ListTile(
                title: Text(product_name, style:TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text("\₹$product_price", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800,),),
              )
            ), 
            child: Container(
                    color: Colors.white,
                    child: Image.asset('images/c3.jpg'),
                  ),
          ),
        ),
      ), 
        
    );
  }
}