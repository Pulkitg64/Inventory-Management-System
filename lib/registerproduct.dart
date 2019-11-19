import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'db/category.dart';
import 'db/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
enum Page { Camera, Gallery }


class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}
class _HomeMaterialState extends State {
  Page _selectedPage = Page.Gallery;
  CategoryService _categoryService = CategoryService();
  ProductService _productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productQuantityController = TextEditingController();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown= <DropdownMenuItem<String>>[];
   MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  String _currentCategory = "test";
  bool typeFlag = false;
  File _image1;
  bool isLoading = false;
  
  @override
  void initState(){
    _getCategories();
  }
    
  
  List<DropdownMenuItem<String>> getCategoriesDropdown(){
    List<DropdownMenuItem<String>> items = new List();
    for(int i = 0; i < categories.length; i++){
      setState(() {
        items.insert(0, DropdownMenuItem(child: Text(categories[i].data['category']),
            value: categories[i]['category']));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product',style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading:IconButton(
          icon: Icon(
            Icons.close,color: Colors.black
          ),
          onPressed: ()
          {Navigator.pop(context);
          },
        )
      ),
      body: Container(
        padding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Builder(
            builder: (context) => Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: isLoading ? CircularProgressIndicator(): Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 2.5),
                                onPressed: (){
                                  if(typeFlag == false)
                                  {
                                    _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 1);
                                  }
                                  else
                                  {
                                    _selectImage(ImagePicker.pickImage(source: ImageSource.camera), 1);
                                  }
                                },
                                child: _displayChild1()
                            ),
                          ),
                        ),
                      ],
                    ),
                   
                   Padding(padding: EdgeInsets.all(8), 
                      child: Text('Select an option then click on "+" ',style: TextStyle(color: Colors.red),),),
                
                  Row(    
                    children: <Widget> [
                       Expanded(
                        child: FlatButton.icon(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(6),
                          onPressed: (){
                            typeFlag = false;
                            setState(() => _selectedPage = Page.Gallery);
                          },
                          icon: Icon(
                            Icons.storage,
                            color: _selectedPage == Page.Gallery? active: notActive,
                          ),
                          label: Text('Use Gallery')
                        )

                      ),
                       Padding(padding: EdgeInsets.all(8), 
                     child: Text('or'),),
                      Expanded(
                        child: FlatButton.icon(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(6),
                          onPressed: (){
                            typeFlag = true;
                            setState(() => _selectedPage = Page.Camera);
                          },
                          icon: Icon(
                            Icons.camera,
                            color: _selectedPage == Page.Camera? active: notActive,
                          ),
                          label: Text('Take Picture')
                        )
                      ),
                     
                    //   FlatButton(
                    //       color: Colors.blue,
                    //       textColor: Colors.white,
                    //       padding: EdgeInsets.all(6),
                    //       onPressed: ()
                    //       {
                    //         typeFlag = false;
                    //       },
                    //       child: Text("Use Gallery", style: TextStyle(fontSize: 15.0),)
                          
                    //   ),
                    //   Icon(Icons.storage),
                    //   Padding(padding: EdgeInsets.all(8), 
                    //   child: Text('or'),),
                    //   FlatButton(
                    //       color: Colors.blue,
                    //       textColor: Colors.white,
                    //       padding: EdgeInsets.all(6),
                    //       onPressed: ()
                    //       {
                    //         typeFlag = true;
                    //       },
                          
                    //       child: Text("Take Picture", style: TextStyle(fontSize: 15.0),)
                    //   ),
                    //     Icon(Icons.camera)
                     ]
                  ),

                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _productNameController,
                        decoration:InputDecoration(labelText: 'Product Name'),
                        validator: (value) {
                          if (value.isEmpty) {
                             return 'Please enter product name';
                          }
                        },
                      )
                  ),
                  Row(
                    children: <Widget>[ 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Category',style: TextStyle(color: Colors.red),
                        ),
                      ),
                
                      Expanded(
                        child:  DropdownButton(
                          items: categoriesDropDown,
                          value: _currentCategory,
                          onChanged: changeSelectedCategory,
                        ),
                      ),

                    ],
                  ),
                      
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _productPriceController,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration:InputDecoration(labelText: 'Product Price'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter product price';
                        }
                      },
                    ),
                  ),           

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _productQuantityController,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration:InputDecoration(labelText: 'Quantity'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter product Quantity';
                        }
                      },
                    ),
                  ),           
                       
                  FlatButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Add product'),
                    onPressed: (){
                      validateAndUpload();
                    },
                  )
                ]
              )
            )
          )
        )                          
      )
    );
  }
  void _selectImage(Future<File> pickImage, int imageNumber) async{
    File tempImg = await pickImage;
    switch(imageNumber){
      case 1:  setState(() => _image1 = tempImg);
      break;
    }
  }
  Widget _displayChild1() {
    if(_image1 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: Colors.grey,),
      );
    }
    else{
      return Image.file(_image1, fit: BoxFit.fill, width: double.infinity,);
    }
  }
                         
                                                              
   _getCategories() async{                   
      List<DocumentSnapshot> data = await _categoryService.getCategories();                         
      print(data.length);
      setState((){
      categories = data;
      categoriesDropDown = getCategoriesDropdown();
      _currentCategory = categories[0].data['category'];
    });
  }
                                                          
  void changeSelectedCategory(String selectedCategory) 
  {
    setState(() => _currentCategory= selectedCategory);
  }
                      
  void validateAndUpload() async{
    if(_formKey.currentState.validate()){
      setState(() =>isLoading = true);

      if(_image1 != null){
        String imageUrl1;
        final FirebaseStorage storage = FirebaseStorage.instance;
        final String picture1 = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task1 =  storage.ref().child(picture1).putFile(_image1);
        StorageTaskSnapshot snapshot1 = await task1.onComplete.then((snapshot)=>snapshot);
         
        task1.onComplete.then((snapshot1) async{

          imageUrl1 = await snapshot1.ref.getDownloadURL();
        
          _productService.uploadProduct(
            productName: _productNameController.text,
            category: _currentCategory,
            price: int.parse(_productPriceController.text),
            quantity: int.parse(_productQuantityController.text), 
            image: imageUrl1 
          );
          _formKey.currentState.reset();
      
          setState(() => isLoading = false);

          Fluttertoast.showToast(msg: 'Product added to the database');

          Navigator.pop(context);
            
        });
      }
      else
      {
        setState(() =>isLoading = false);
        Fluttertoast.showToast(msg: 'at least one images must be provided');
      }
    }
  
  }
}       