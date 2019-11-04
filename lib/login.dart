import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'customer.dart';
import 'main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  
  SharedPreferences preferences;
  bool loading= false;
  bool isLogedin = false;

  @override
  void initState(){
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async{
    setState(() {
      loading= true; 
    });

    preferences= await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();

    if(isLogedin){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CustPage()));
    } 
    setState(() {
      loading=false; 
    });
  }

  Future handleSignTn() async{
    preferences = await SharedPreferences.getInstance();
    setState((){
    loading = true;
    });  

   GoogleSignInAccount googleUser = await googleSignIn.signIn();
   GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
   AuthCredential credential = GoogleAuthProvider.getCredential(
    idToken: googleSignInAuthentication.idToken, 
    accessToken: googleSignInAuthentication.accessToken);
   FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

    if(firebaseUser!=null){
      final QuerySnapshot result = await Firestore.instance
        .collection("users")
        .where("id", isEqualTo: firebaseUser.uid)
        .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if(documents.length==0){
      // insert the user to our colllection

        Firestore.instance
          .collection("users")
          .document(firebaseUser.uid)
          .setData({
            "id": firebaseUser.uid,
            "username": firebaseUser.displayName,
            "profilePicture": firebaseUser.photoUrl,
          });

        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username",firebaseUser.displayName);
        await preferences.setString("photoUrl",firebaseUser.displayName);
      }
      else{
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username",documents[0]['username']);
        await preferences.setString("photoUrl",documents[0]['photoUrl']);
      }

      Fluttertoast.showToast(msg: "Login was successfull");
      setState((){
        loading = false;
      });
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context)=> CustPage()));
    }
    else{
      Fluttertoast.showToast(msg: "Login Failed");
    }
  }

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
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      //=====================EMAIL FIELD===================
                     Padding(
                      padding:const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
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
                          child: TextFormField(
                            controller: _passwordTextController,
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
                      ),
                    ),
                   ),

                   // =================== LOG IN BUTTON=============================
                   Padding(
                     padding:const EdgeInsets.all(8.0),
                     child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blue,
                      elevation: 0.0,
                      child: MaterialButton( onPressed: (){},
                                 // onPressed: () async{
                                    //   if(_formKey.currentState.validate()){
                                    //     if(!await user.signIn(_email.text, _password.text))
                                    //   _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                                    //    }
                                    
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text("Login",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
                        ),
                      )
                    ),
                  ),

                  Expanded(child: Container(),),
                  //===============================SIGN IN WITH GOOGLE======================
                  Divider(color: Colors.white,),
                  Text("Other Sign In Options", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                  Padding(
                     padding:const EdgeInsets.all(8.0),
                     child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red,
                      elevation: 0.0,
                      child: MaterialButton( onPressed: (){
                        handleSignTn();
                        },
                                 // onPressed: () async{
                                    //   if(_formKey.currentState.validate()){
                                    //     if(!await user.signIn(_email.text, _password.text))
                                    //   _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                                    //    }
                                    
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text("Sign In with Google ",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
                        ),
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
  

} 
