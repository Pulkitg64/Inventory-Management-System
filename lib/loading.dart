import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator()      
    );
  }
}