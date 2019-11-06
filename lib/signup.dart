import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'customer.dart';
import 'login.dart';
import 'db/users.dart';
import 'placeorder.dart';
import 'main.dart';


class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmpasswordTextController = TextEditingController();
  bool hidePass = true;

  bool loading= false;
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   title: Text("Login",style: TextStyle(color: Colors.red.shade900),),
      //   elevation: 0.1,
      // ),
      body: Stack(
        children: <Widget>[
          Image.asset('images/login.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,  
          ),
          Container(
            color: Colors.black.withOpacity(0.2),
            width: double.infinity,
            height: double.infinity,  
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[

                      //=======================NAME========================
                      Padding(padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.8),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _nameTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              icon: Icon(Icons.person_outline),
                            ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "The name field cannot be empty";
                            } 
                         return null;
                         },
                        ),
                      ),
                    ),
                   ),
                      //=====================EMAIL FIELD===================
                     Padding(padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                       child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.8),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _emailTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              icon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                Pattern pattern =
                                 r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Please make sure your email address is valid';
                                else
                                  return null;
                               }
                             },
                           ),
                          ),
                        ), 
                      ),

                      // ==============PASSWORD FIELD ==============================
                    Padding(padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.8),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              controller: _passwordTextController,
                              obscureText: hidePass,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                icon: Icon(Icons.lock_outline),
                              ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "The password field cannot be empty";
                              } 
                              else if (value.length < 6) {
                                  return "the password has to be at least 6 characters long";
                                }
                               
                         return null;
                         },
                        ),
                        trailing: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: (){
                          setState(() {
                           hidePass= !hidePass; 
                          });
                        },
                        ),
                          ),
                      ),
                    ),
                   ),
                   //==============CONFIRM PASSWORD=====================
                    Padding(padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.8),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                              title: TextFormField(
                              controller: _confirmpasswordTextController,
                              obscureText: hidePass,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Confirm Password",
                                icon: Icon(Icons.lock_outline),
                              ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "The password field cannot be empty";
                              } 
                              else if (value.length < 6) {
                                  return "the password has to be at least 6 characters long";
                              }
                              else if(_passwordTextController.text!=value)
                              {
                                  return "The Password do not match";
                              }        
                         return null;
                         },
                        ),
                        trailing: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: (){
                          setState(() {
                           hidePass= !hidePass; 
                          });
                        },
                        ),
                       ),
                      ),
                    ),
                   ),
                   // =================== REGISTER  =============================
                   Padding(
                     padding:const EdgeInsets.all(8.0),
                     child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red,
                      elevation: 0.0,
                      child: MaterialButton( onPressed: ()async{
                        validateForm();
                      },                                                            
                      minWidth: MediaQuery.of(context).size.width,
                       child: Text("Register",textAlign: TextAlign.center,
                       style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
                     ),
                       )
                       ),
                     ),
                            
                     // ===============Login==========================
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.6),
                      child: 
                      Padding(padding: const EdgeInsets.all(8.0),          
                        child: InkWell(
                          onTap: (){
                           Navigator.pop(context);
                          },              
                          child: Text("Login",textAlign: TextAlign.center,style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 15.0)),
                        )            
                      )                 
                    ),
                  ),                                            
               ],
              ),
            ),
          ),
        ),
      ),
        Visibility(
          visible: loading ?? true,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              color: Colors.white.withOpacity(0.9),
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            )
           ),
          ),
         )
       ],
     ),
    );
  }
                        
  
  Future validateForm() async {
    FormState formState = _formKey.currentState;

    if (formState.validate()) {
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text,)
            .then((user)=> {
            _userServices.createUser(
            {
            "username": _nameTextController.text,
            "email": _emailTextController.text,
           // "password": _passwordTextController
          //  "userId": user.uid,
            }
            )
           }).catchError((err) => {print(err.toString())});
   Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => CustPage()));

      }
    }
  }

} 

  


