// home_material.dart
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'db/category.dart';

class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}
class _HomeMaterialState extends State {
  CategoryService _categoryService = CategoryService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown= <DropdownMenuItem<String>>[];
  String _currentCategory = "test";
  TextEditingController _productPrice = TextEditingController();
  
  
  @override
  void initState(){
    _getCategories();
    categoriesDropDown = getCategoriesDropdown();
 //   _currentCategory= categoriesDropDown[0].value;
  }
    
  List<DropdownMenuItem<String>> getCategoriesDropdown(){
    List<DropdownMenuItem<String>> items = new List();
    for(DocumentSnapshot category in categories){
    items.add(DropdownMenuItem(child: Text(category['category']),
      value: category['category'],
      )
     );
    }
    return items;
  }
  final _user = User();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product',style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: Icon(Icons.close,color: Colors.black,),
      ),
      body: Container(
        padding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            
              child: Builder(
                builder: (context) => Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _productNameController,
                        decoration:InputDecoration(labelText: 'Product Name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter product name';
                          }
                        },
                           // onSaved: (val) =>
                           //   setState(() => _user.ProductName = val),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context,index){
                            return ListTile(
                              title: Text(categories[index]['category']),
                            );
                          }
                        ),
                      ),
                      Center(
                        child: DropdownButton(
                          items: categoriesDropDown,
                          value: _currentCategory,
                          onChanged: changeSelectedCategory,
                        ),
                      ),
                      TextFormField(
                        decoration:InputDecoration(labelText: 'Product Price'),
                        validator: (value) {
                         if (value.isEmpty) {
                          return 'Please enter product price.';
                          }
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                        child: Text('Upload Image'),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                        child: Text('Product Category'),
                      ),        
                                
                        //CheckboxListTile(
                        //   title: const Text('Groceries & Staples'),
                         //  value: _user.category[User.CategoryGrocery],
                       //                                         onChanged: (val) {
                                //                                           setState(() =>
                                //                                           _user.category[User.CategoryGrocery] = val);
                                //                                         }),
                                //                                       CheckboxListTile(
                                //                                         title: const Text('Personal Needs'),
                                //                                         value: _user.category[User.CategoryPersonal],
                                //                                         onChanged: (val) {
                                //                                           setState(() => _user
                                //                                            .category[User.CategoryPersonal] = val);
                                //                                         }),
                                //                                       CheckboxListTile(
                                //                                           title: const Text('Household Needs'),
                                //                                           value: _user.category[User.CategoryHousehold],
                                //                                           onChanged: (val) {
                                //                                             setState(() =>
                                //                                             _user.category[User.CategoryHousehold] = val);
                                //                                           }),
                                //                                       CheckboxListTile(
                                //                                           title: const Text('Snacks'),
                                //                                           value: _user.category[User.CategorySnacks],
                                //                                           onChanged: (val) {
                                //                                             setState(() =>
                                //                                             _user.category[User.CategorySnacks] = val);
                                //                                           }),
                                //                                       CheckboxListTile(
                                //                                           title: const Text('Dairy Product'),
                                //                                           value: _user.category[User.CategoryDairy],
                                //                                           onChanged: (val) {
                                //                                             setState(() =>
                                //                                             _user.category[User.CategoryDairy] = val);
                                //                                           }),
                                //                                       CheckboxListTile(
                                //                                           title: const Text('Frozen Food'),
                                //                                           value: _user.category[User.CategoryFrozenFood],
                                //                                           onChanged: (val) {
                                //                                             setState(() =>
                                //                                             _user.category[User.CategoryFrozenFood] = val);
                                //                                           }),
                                                                      /*
                                                                  Container(
                                                                      padding: const EdgeInsets.symmetric(
                                                                          vertical: 16.0, horizontal: 16.0),
                                                                      child: RaisedButton(
                                                                          onPressed: () {
                                                                            final form = _formKey.currentState;
                                                                            if (form.validate()) {
                                                                              form.save();
                                                                              _user.save();
                                                                              _showDialog(context);
                                                                            }
                                                                          },
                                                                          child: Text('Save'))),
                                                                   */
                  ]
                )
              )
            )
          
        )
      );
    }
   _showDialog(BuildContext context) {
      Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Submitting form')));
    }
                                        
  _getCategories() async{                   
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    
    print(data.length);
    setState((){
      categories = data;
     });
   }
                                    
  void changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory= selectedCategory);
  }
}