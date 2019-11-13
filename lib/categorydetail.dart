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
        leading: Icon(Icons.close,color: Colors.black)
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
                  onTap: ()=> Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> new ProductViewDetail(
           //passin the values of product grid view to product view details
                      product_detail_name: snapshot.data[index].data['name'],
                      product_detail_price: snapshot.data[index].data['price'],
                      product_detail_picture: snapshot.data[index].data['picture'],
                    )
                  )
                  ),
                  child: Card(
                  elevation: 5.0,
                  child: new Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Text(snapshot.data[index].data['name'], style: TextStyle(color: Colors.black, fontSize: 20.0),),
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
