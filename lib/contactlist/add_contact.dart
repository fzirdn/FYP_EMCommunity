import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emcommunity_fyp/ui/contactlist/contact_list.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatelessWidget {

  //controller
  TextEditingController name = TextEditingController();
  TextEditingController phoneNum = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('contacts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(onPressed: () {
            ref.add({
              'name': name.text,
              'phoneNum': phoneNum.text,
            }).whenComplete(() {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ContactListPage()));
            });
          },
          child: Text("save"),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: phoneNum,
                  decoration: InputDecoration(
                    hintText: 'phoneNum',
                  ),
                ),
            ),
            
          ],
        ),
      ),
    );
  }
}