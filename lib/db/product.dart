import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

 class ProductService{
   Firestore _firestore = Firestore.instance;
   String ref = 'products';

   void uploadProduct({String productName,String category, int price, int quantity, String image }){
    var id = Uuid();
    String productId = id.v1();

  
    _firestore.collection(ref).document(productId).setData({
      'name': productName,
      'id': productId,
      'category': category,
      'quantity': quantity,
      'price': price,
      'picture' :image
      

    });
  
   }

   getproduct(String cate){

     return _firestore.collection('products')
     .where('category',isEqualTo: cate)
     .getDocuments();

   }


   
 }