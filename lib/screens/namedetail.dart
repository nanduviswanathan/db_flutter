import 'package:database_app/models/note.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:database_app/utils/database_helper.dart';

class NameAdd extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {

    return NameAddState();
  }

}

class NameAddState extends State<NameAdd>{

  final dbHelper = DatabaseHelper.instance;
  List<Car> cars = [];



  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // void _showMessageInScaffold(String message){
  //   _scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         content: Text(message),
  //       )
  //   );
  // }



  @override
  Widget build(BuildContext context) {


    return  WillPopScope(

      onWillPop: () {
        moveToLastscreen();
      },

    child: Scaffold(
      appBar: AppBar(
        title: Text('Add Contact',),
        leading: IconButton(icon: Icon(
          Icons.arrow_back),
          onPressed: (){
            moveToLastscreen();
          }
        ),),
      body: Padding (
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 15.0, bottom:  15.0),
                child: TextField(
                  controller: nameController,
                  onChanged: (value){
                    debugPrint('Somethingh chged');
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),

            )),

            Padding(
                padding: EdgeInsets.only(top: 15.0, bottom:  15.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: numberController,
                  onChanged: (value){
                    debugPrint('Somethingh chged');
                  },
                  decoration: InputDecoration(
                    labelText: 'Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text('Save',
                  textScaleFactor: 1.5,),
                  onPressed: (){
                      debugPrint("Save Button Pressed");
                      String name = nameController.text;
                      int miles = int.parse(numberController.text);
                      _insert(name, miles);

                  },
                ),
            )
          ],
        ),
      )
    ));
  }

  void _insert(name, miles) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnMiles: miles
    };
    Car car = Car.fromMap(row);
    final id = await dbHelper.insert(car);
    //_showMessageInScaffold('inserted row id: $id');
  }

  void moveToLastscreen(){
    Navigator.pop(context, true);
  }


}
