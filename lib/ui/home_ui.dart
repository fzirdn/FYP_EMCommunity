import 'package:emcommunity_fyp/ui/alert_ui.dart';
import 'package:emcommunity_fyp/ui/contactlist_ui.dart';
import 'package:emcommunity_fyp/ui/emergency_ui.dart';
import 'package:emcommunity_fyp/ui/login_ui.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    //Emergency contact list button
    final contactListButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactListPage()));
        },
        child: Row(
          children: <Widget>[
            Icon(Icons.contact_phone_rounded),
            Text(
              "Emergency Contact List",
               textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      
    );

    //Emergency button
    final emergencyButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyPage()));
        },
        child: Row(
          children: <Widget>[
            Icon(Icons.add_alert),
            Text(
              "Emergency",
               textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    //Alarm Button
    final alarmButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AlertPage()));
        },
        child: Row(
          children: <Widget>[
            Icon(Icons.music_note),
            Text(
              "Alarm",
               textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    //Logout Button
    final logoutButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Row(
          children: <Widget>[
            Icon(Icons.login_rounded),
            Text(
              "Logout",
               textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"), 
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 180,
              child: Image.asset("assest/logo_2.png", fit: BoxFit.contain),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              //emergency contact list button
              contactListButton,
              SizedBox(height: 15,),

              //emergency button
              emergencyButton,
              SizedBox(height: 15,),

              //alert button
              alarmButton,
              SizedBox(height: 15,),

              //alert button
              logoutButton,
              SizedBox(height: 15,),


              
            ],
          )
        )
      )
    );
  }
}