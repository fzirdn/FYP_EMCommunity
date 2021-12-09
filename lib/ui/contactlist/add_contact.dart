import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {

  bool isLoading = false;
  Map<String, dynamic>? userMap;
  final TextEditingController _search = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    

    var size = MediaQuery.of(context).size;

    void onSearch() async {

      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      setState(() {
              isLoading = true;
            });

      await _firestore.collection('users')
                      .where("email", isEqualTo: _search.text)
                      .get().then((value) {setState ( () {
                        userMap = value.docs[0].data();
                        isLoading = false;
                       });
                       print(userMap);
                      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add New Emergency Contact"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.red,
          onPressed: (){
            Navigator.of(context).pop();
          }),
      ),
       
      body: isLoading? Center(
        child: Container(
          height: size.height / 20, 
          width: size.width /20,
          child: CircularProgressIndicator(),)) 

      :Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search",
                  icon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          
          SizedBox(
            height: size.height / 50,
          ),
          ElevatedButton(onPressed: (){ onSearch();}, 
          child: Text("Search")
          ),

          SizedBox(
            height: size.height / 30,
          ),

          userMap != null ? ListTile(
            onTap: (){},
            leading: Icon(Icons.account_box, color: Colors.black),
            title: Text(
              userMap!['phoneNum'],
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),),
            subtitle: Text(userMap!['email']),
            trailing: Icon(Icons.add, color: Colors.red,),

          ): Container(),
        ],
      ),
    );
  }
}