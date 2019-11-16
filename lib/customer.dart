import 'package:flutter/material.dart';
import 'placeorder.dart';
import 'cart_product.dart';
import 'product_categories.dart';
import 'productlist.dart';


class CustPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer'),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
              accountName: Text('Priyanshu'),
              accountEmail: Text('pgupta@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white,),
                ),
              ),
              decoration: new BoxDecoration(
                  color: Colors.orange
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CustPage()));
              },
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new Single_cart_product()));
              },
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new ProductList()));
              },
              child: ListTile(
                title: Text('Products'),
                leading: Icon(Icons.dashboard),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new ProductCategories()));
              },
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.category),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite),
              ),
            ),

            Divider(),

            InkWell(
              onTap: (){
                //user.signOut();
              },
              child: ListTile(
                title: Text('Log out'),
                leading: Icon(Icons.transit_enterexit, color: Colors.grey,),
              ),
            ),

          ],
        ),
      ),
      body: Column(
          children: <Widget>[

            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Card(
                      child: ListTile(
                        title: FlatButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.shopping_cart),
                          label: Text("")
                        ),
                        subtitle: Text(
                          'Place Order',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                            
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>PlaceOrder()));
                        }        
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.track_changes),
                              label: Text("")),
                          subtitle: Text(
                            'Confirm Order',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                          onTap: () {
                        //  Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductList()));
                        }    
                        ),
                    ),
                  ),
                 
                ],
              ),
            ),
          ],
        )
    
    );
      
    
  }
}
