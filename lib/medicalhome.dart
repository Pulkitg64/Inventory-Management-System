import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'db/category.dart';
import 'db/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MedicalHome extends StatefulWidget {
  @override
  _MedicalHomeState createState() => _MedicalHomeState();
}

class _MedicalHomeState extends State<MedicalHome> {
   @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Home"),
      ),
    );
  }
      
}

