import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emcommunity_fyp/ui/contactlist/add_contact.dart';
import 'package:emcommunity_fyp/ui/contactlist/edit_contact.dart';
import 'package:emcommunity_fyp/ui/home_ui.dart';
import 'package:flutter/material.dart';

class ContactListPage extends StatefulWidget {
  ContactListPage({Key? key}) : super(key: key);


  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {

  final Stream<QuerySnapshot> _userStream = 
      FirebaseFirestore.instance.collection('contacts').snapshots();
  
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
          }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AddContactPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add, color: Colors.black),
        focusColor: Colors.red,
      ),

      body: StreamBuilder(
        stream: _userStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => EditContactPage(docid: snapshot.data!.docs[index])));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            snapshot.data!.docChanges[index].doc['name'],
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data!.docChanges[index].doc['phoneNum'],
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      
      )
    );
      
  }

  
}