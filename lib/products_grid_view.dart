import 'package:flutter/material.dart';
import 'product_view_details.dart';
class ProductsGridView extends StatefulWidget {
  @override
  _ProductsGridViewState createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
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
    {
      "name":"Lays",
      "picture":"images/c3.jpg",
      "price":"20",
    },
     {
      "name":"Bourn Vita",
      "picture":"images/c1.jpg",
      "price":"100",
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Single_prod(
            product_name: product_list[index]['name'],
            product_pictures: product_list[index]['picture'],
            product_price: product_list[index]['price'],
          ),
        );
      },
      
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
          onTap: ()=> Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> new ProductViewDetail(
           //passing the values of product grid view to product view details
            product_detail_name: product_name,
            product_detail_price: product_price,
            product_detail_picture: product_pictures,
            )
          )
          ),
          child: GridTile(          
            footer: Container(
              color: Colors.white,     
              child: ListTile(
                title: Text(product_name, style:TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text("\₹$product_price", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800,),),
              )
            ), 
            child: Image.asset(
              product_pictures,
              fit:BoxFit.cover,
              ),
          ),
        ),
      ), 
        
    );
  }
}