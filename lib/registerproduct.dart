// home_material.dart
import 'package:flutter/material.dart';
import 'user.dart';
class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}
class _HomeMaterialState extends State {
  final _formKey = GlobalKey();
  final _user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Register New Product')),
        body: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: SingleChildScrollView(
                child: Builder(
                    builder: (context) => Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                decoration:
                                InputDecoration(labelText: 'Product Name'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter product name';
                                  }
                                },
                                onSaved: (val) =>
                                    setState(() => _user.ProductName = val),
                              ),
                              TextFormField(
                                  decoration:
                                  InputDecoration(labelText: 'Product Price'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter product price.';
                                    }
                                  },
                                  onSaved: (val) =>
                                      setState(() => _user.ProductPrice = val)),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                                child: Text('Upload Image'),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                                child: Text('Product Category'),
                              ),
                              CheckboxListTile(
                                  title: const Text('Groceries & Staples'),
                                  value: _user.category[User.CategoryGrocery],
                                  onChanged: (val) {
                                    setState(() =>
                                    _user.category[User.CategoryGrocery] = val);
                                  }),
                              CheckboxListTile(
                                  title: const Text('Personal Needs'),
                                  value: _user.category[User.CategoryPersonal],
                                  onChanged: (val) {
                                    setState(() => _user
                                        .category[User.CategoryPersonal] = val);
                                  }),
                              CheckboxListTile(
                                  title: const Text('Household Needs'),
                                  value: _user.category[User.CategoryHousehold],
                                  onChanged: (val) {
                                    setState(() =>
                                    _user.category[User.CategoryHousehold] = val);
                                  }),
                              CheckboxListTile(
                                  title: const Text('Snacks'),
                                  value: _user.category[User.CategorySnacks],
                                  onChanged: (val) {
                                    setState(() =>
                                    _user.category[User.CategorySnacks] = val);
                                  }),
                              CheckboxListTile(
                                  title: const Text('Dairy Product'),
                                  value: _user.category[User.CategoryDairy],
                                  onChanged: (val) {
                                    setState(() =>
                                    _user.category[User.CategoryDairy] = val);
                                  }),
                              CheckboxListTile(
                                  title: const Text('Frozen Food'),
                                  value: _user.category[User.CategoryFrozenFood],
                                  onChanged: (val) {
                                    setState(() =>
                                    _user.category[User.CategoryFrozenFood] = val);
                                  }),
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
                            ])))
            )
            ));
  }
  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}