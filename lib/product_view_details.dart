import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'placeorder.dart';
import 'cart.dart';
class ProductViewDetail extends StatefulWidget {
  final product_detail_name;
  final product_detail_price;
  final product_detail_picture;

  ProductViewDetail({
    this.product_detail_name,
    this.product_detail_price,
    this.product_detail_picture
  });
  @override
  _ProductViewDetailState createState() => _ProductViewDetailState();
}

class _ProductViewDetailState extends State<ProductViewDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: InkWell(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> new PlaceOrder()));},
          child: Text('Place Order')),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search,color: Colors.black),onPressed: (){},),
          new IconButton(icon: Icon(Icons.shopping_basket,color: Colors.black),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));},)
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.product_detail_picture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(widget.product_detail_name, 
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0) ,),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("\₹${widget.product_detail_price}",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red) ,)
                      )
                    ],
                  ),
                )
              ),
            ),
            
          ),
          
          // +===============================================
//                    FIRST BUTTON QUANTITY BUTTON
          //+================================================
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    showDialog(context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Quantity"),
                        content: Text("Choose quantity of item "),
                        actions: <Widget>[
                          MaterialButton(onPressed: (){
                            Navigator.of(context).pop(context);
                          },
                          child: Text("Close",style: TextStyle(color: Colors.blue),),
                          )
                        ],
                      );
                    });

                  },
                  color: Colors.grey[200],
                  textColor: Colors.black,
                  child: Row(
                    children: <Widget>[
                      Text("Quantity"),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                      Expanded(
                        child: MaterialButton(
                          onPressed: (){},
                          color: Colors.red,
                          textColor: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Text("Add To Cart", textAlign: TextAlign.center,),
                              IconButton(icon: Icon(Icons.add_shopping_cart),alignment: Alignment.centerRight,color: Colors.white,onPressed: (){},),
                            ],
                          ),
                        ),
                      ),
                      
                      
                    ],
                  ),
                  ),)
            ],
          ),
         // +===============================================
//                    SECOND BUTTON
          //+===============================================
          //  Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: MaterialButton(
          //         onPressed: (){},
          //         color: Colors.red,
          //         textColor: Colors.white,
          //         child: Row(
          //           children: <Widget>[
          //             Expanded(child: Text("Add To Cart", textAlign: TextAlign.center,)),
          //             IconButton(icon: Icon(Icons.add_shopping_cart),color: Colors.white,onPressed: (){},),
          //           ],
          //         ),
          //         ),
          //         ),

                  
          //   ],
          // )
          Divider(),
          Text(' Similar Products'),
          Container(
            height:300.0,
            child: SimilarProducts(),
          ),
        ],
      )
    );
  }
}

class SimilarProducts extends StatefulWidget {

  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  var product_list=[
     {
      "name":"Amul Butter",
      "picture":"images/c6.jpeg",
      "price":"30",
    },
    {
      "name":"Shampoo",
      "picture":"images/c7.jpg",
      "price":"200",
    }, 
    {
      "name":"Corn Flakes",
      "picture":"images/c8.jpeg",
      "price":"150",
    },
    {
      "name":"Hide n Seek",
      "picture":"images/c4.jpg",
      "price":"30",
    }, 
  ];
  @override
  Widget build(BuildContext context) {
      return GridView.builder(
      itemCount: product_list.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ),
      itemBuilder:(BuildContext context,int index){
        return Similar_Single_prod(
          product_name: product_list[index]['name'],
          product_pictures: product_list[index]['picture'],
          product_price: product_list[index]['price'],
        );
      },
      
    );
    return Container(
      
    );
  }
}

class Similar_Single_prod extends StatelessWidget {
  final product_name;
  final product_pictures;
  final product_price;

  Similar_Single_prod({
    this.product_name,
    this.product_pictures,
    this.product_price,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag:product_name,
        child: Material(
          child: InkWell(
            onTap: ()=> Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> new ProductViewDetail(
                //passing the values of product grid view to product view details
                product_detail_name: product_name,
                product_detail_price: product_price,
                product_detail_picture: product_pictures,
              ))
            ),
            child: GridTile(
              footer: Container(
                
                color: Colors.white70,
                child: ListTile(
                  
                  leading: Text(product_name, style:TextStyle(fontWeight: FontWeight.bold,)),
                  title: Text("\₹$product_price", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800,),
                  ),
                  )
              ), child: Image.asset(
                product_pictures,
                fit:BoxFit.cover,
                ),
            )
           )
        ), 
        ),
    );
  }
}