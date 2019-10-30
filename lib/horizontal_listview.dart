import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
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
            ImageCaption: 'Personel Needs',
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
        width: 100.0,
        child:ListTile(
          title:Image.asset(
            ImageLocation,
            width: 100.0,
            height:80.0,
            ),
          subtitle: Container(
           
            child: Text(ImageCaption),
            ),
          )
        ),
      ),
    );
  }
}