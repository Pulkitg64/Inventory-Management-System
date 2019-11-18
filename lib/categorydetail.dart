import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_view_details.dart';
class NextPage extends StatefulWidget {
  final String value;

  NextPage({Key key,this.value}): super(key:key);
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {

 
 Future _data;
 Future getCat() async{

  var firestore = Firestore.instance;

  QuerySnapshot qn = await firestore.collection('products').where('category', isEqualTo: "${widget.value}").getDocuments();
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
        title: Text("${widget.value}",style: TextStyle(color: Colors.black)),
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
              )
              );
          });
          }
        }
      )    
    );
  }  

}
