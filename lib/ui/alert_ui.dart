import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  AlertPage({Key? key}) : super(key: key);

  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Alert Page"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.red,
          onPressed: (){
            Navigator.of(context).pop();
          }),
      ),
    );
  }
}