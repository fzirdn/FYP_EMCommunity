import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emcommunity_fyp/ui/contactlist/contact_list.dart';
import 'package:emcommunity_fyp/ui/home_ui.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatelessWidget {

  //controller
  TextEditingController name = TextEditingController();
  TextEditingController phoneNum = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('contacts');

  //form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    //Name Field
    final nameField = TextFormField(
      autofocus: false,
      controller: name,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle_rounded),
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        hintText: "Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //Phone Num Field
    final phoneNumField = TextFormField(
      autofocus: false,
      controller: phoneNum,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone_iphone_rounded),
        contentPadding: EdgeInsets.fromLTRB(0, 15, 20, 0),
        hintText: "Phone Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //Save Button
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          ref.add({
              'name': name.text,
              'phoneNum': phoneNum.text,
            }).whenComplete(() {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ContactListPage()));
            });
        },
        child: Text(
          "Save",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
          ),
        ),
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Emergency Contact List"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.red,
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
          }),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      " Add New Emergency Contact ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                      ),
                    ),
                    SizedBox(height: 15),
                    
                    nameField,
                    SizedBox(height: 15),

                    phoneNumField,
                    SizedBox(height: 15),

                    saveButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
