import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emcommunity_fyp/models/user_model.dart';
import 'package:emcommunity_fyp/ui/home_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //our form key
  final _formKey = GlobalKey<FormState>();

  //editing Controller
  final emailEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  // firebase 
  final _auth = FirebaseAuth.instance;
  

  @override
  Widget build(BuildContext context) {

    //username field 
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if(value!.isEmpty){
          return ("Please Enter Your Email");
        }

        //reg expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {

        emailEditingController.text = value!;//value!

      },//onSaved
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //phone number field
    final phoneNumField = TextFormField(
      autofocus: false,
      controller: phoneNumberEditingController,
      keyboardType: TextInputType.text,
      validator: (value){
        RegExp regex = new RegExp(r'^.{10,}$');
        if(value!.isEmpty){
          return ("Phone Number cannot be Empty");
        }
        if(!regex.hasMatch(value)){
          return ("Please Enter Valid Phone Number(Min. 10 Character)");
        }
        return null;
      },
      onSaved: (value) {

        phoneNumberEditingController.text = value!;//value!

      },//onSaved
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone_android_sharp),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Phone Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return ("Password is required for login");
        }
        if(!regex.hasMatch(value)){
          return ("Please Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {

        passwordEditingController.text = value!;//value!

      },//onSaved
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value){
        if(confirmPasswordEditingController.text != passwordEditingController.text)
        {
          return ("Password dont match");
        }
        return null;
      },
      onSaved: (value) {

        passwordEditingController.text = value!;//value!

      },//onSaved
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //register button
    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
          ),
        ),
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.red,
          onPressed: (){
            Navigator.of(context).pop();
          }),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset("assest/logo_2.png", fit: BoxFit.contain,)
                    ),
                    SizedBox(height: 45,),
                    
                    emailField, 
                    SizedBox(height: 20,),

                    phoneNumField, 
                    SizedBox(height: 20,),
                    
                    passwordField,
                    SizedBox(height: 20,),

                    confirmPasswordField,
                    SizedBox(height: 20,),
                    
                    registerButton,
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );//Scaffold
  }

  void signUp(String email, String password) async {
    if(_formKey.currentState!.validate()) {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        postDetailToFirestore(),
      }).catchError((e) 
      {
        Fluttertoast.showToast(msg: e!.message);  
      });
    }
  }

  postDetailToFirestore() async {
    // calling our firestore
    //calling our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    
    //writing all the values 
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.phoneNum = phoneNumberEditingController.text;

    await firebaseFirestore
     .collection("users")
     .doc(user.uid)
     .set(userModel.toMap());
    
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil(context, 
    MaterialPageRoute(builder: (context) => HomePage()), 
    (route) => false);

  }
}