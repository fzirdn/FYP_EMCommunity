import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emcommunity_fyp/ui/contactlist/contact_list.dart';
import 'package:flutter/material.dart';

class EditContactPage extends StatefulWidget {
  DocumentSnapshot docid;
  EditContactPage({required this.docid});

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {

  //controller
  TextEditingController name = TextEditingController();
  TextEditingController phoneNum = TextEditingController();

  @override
  void initState () {

    name = TextEditingController(text: widget.docid.get('name'));
    phoneNum = TextEditingController(text: widget.docid.get('phoneNum'));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Emergency Contact List"),
        actions: [
          MaterialButton(onPressed: () {
            widget.docid.reference.update({
              'name': name.text,
              'phoneNum': phoneNum.text,
            }).whenComplete(() {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ContactListPage()));
            });
          },
          child: Text("update"),
          ),
          MaterialButton(onPressed: () {
            widget.docid.reference.delete().whenComplete(() {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ContactListPage()));
            });
          },
          child: Text("delete"),
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
                    hintText: 'Phone Number',
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}