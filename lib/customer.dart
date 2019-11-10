import 'package:flutter/material.dart';
import 'package:hello_world/login.dart';
import 'placeorder.dart';
import 'package:provider/provider.dart';
import 'provider/user_provider.dart';
import 'splash.dart';

class CustPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //   runApp(
    ChangeNotifierProvider(
      builder: (_)=> UserProvider.initialize(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepOrange
        ),
        home: ScreensController(),
      )
    );
  
  }
}


 
class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    switch(user.status){
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
      return Login();
      case Status.Authenticated:
        return PlaceOrder();
      default: return Login();
    }
  }
}
