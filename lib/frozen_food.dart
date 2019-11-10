import 'package:flutter/material.dart';
import 'products_grid_view.dart';
import 'cart.dart';
class FrozenFoods extends StatefulWidget {
  @override
  _FrozenFoodsState createState() => _FrozenFoodsState();
}

class _FrozenFoodsState extends State<FrozenFoods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frozen Foods'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search,color: Colors.black),onPressed: (){},),
          new IconButton(icon: Icon(Icons.shopping_basket,color: Colors.black),
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> new Cart()));},)
        ],
      ),
      body: Column(
        children: <Widget>[
          //image carousel begins

          Divider(),
          //Padding Widget


          Container(
            height: 20.0,
            child: Text('All Frozen Foods',),
            alignment: Alignment.centerLeft,
          ),
          // //Padding Widget
          // Padding(padding: const EdgeInsets.all(35.0),
          // child: Text('Recent Products', textAlign: TextAlign.left,textDirection: TextDirection.ltr,),),

          //grid View

          Flexible(

            child: ProductsGridView(),
          )

        ],
      ),
    );
  }
}