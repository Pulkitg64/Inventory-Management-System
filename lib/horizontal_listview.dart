import 'package:flutter/material.dart';
import 'categorydetail.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            ImageLocation: 'images/m1.png',
            ImageCaption: 'Groceries & Staples',
            
          ),
          Category(
            ImageLocation: 'images/m2.png',
            ImageCaption: 'Household Needs',
            
          ),
          Category(
            ImageLocation: 'images/m3.png',
            ImageCaption: 'Personal Needs',
          ),
           Category(
            ImageLocation: 'images/m4.png',
            ImageCaption: 'Dairy Products',
          ),
           Category(
            ImageLocation: 'images/m5.png',
            ImageCaption: 'Frozen Food',
          ),
          Category(
            ImageLocation: 'images/m6.png',
            ImageCaption: 'Snacks',
          ),
         
          
        ],
      ),
      
    );
  }
}

class Category extends StatelessWidget {
  final String ImageLocation;
  final String ImageCaption;
  
  Category({
    this.ImageLocation,
    this.ImageCaption,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2.0),
    child: InkWell(onTap: (){},
      child: Container(
        width: 150.0,
        child:InkWell(
            onTap: (){
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) => NextPage(value: ImageCaption),
                    );
                    Navigator.of(context).push(route);
               //   Naator.push(context, new MaterialPageRoute(builder: (context) => ProductCategories(categ:  ProductCategories(snapshot.data[index].data['category']))));
                  },
          child: ListTile(
            title:Image.asset(
            // IMAGE LOCATION
              ImageLocation,
              width: 100.0,
              height:80.0,
              ),
            subtitle: Container(
             
              child: Text(ImageCaption, textAlign: TextAlign.center,),
              
              ),
              
            ),
        )
        ),
      ),
    );
  }
}