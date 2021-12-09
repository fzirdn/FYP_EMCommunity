import 'package:emcommunity_fyp/ui/contactlist/add_contact.dart';
import 'package:flutter/material.dart';

class ContactListPage extends StatefulWidget {
  ContactListPage({Key? key}) : super(key: key);

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
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
            Navigator.of(context).pop();
          }),
      ),

      //button to add new contact
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add, color: Colors.black),
        focusColor: Colors.red,
      ),
    );
  }
}