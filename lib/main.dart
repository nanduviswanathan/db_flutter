import 'package:database_app/screens/namedetail.dart';
import 'package:database_app/screens/namelist.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name List',
      debugShowCheckedModeBanner: false,
      home: NameList(),
    );

  }

}