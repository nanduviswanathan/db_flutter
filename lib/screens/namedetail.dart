import 'package:database_app/models/note.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:database_app/utils/database_helper.dart';

class NameAdd extends StatefulWidget{

  final Note note;

  NameAdd(this.note);


  @override
  State<StatefulWidget> createState() {

    return NameAddState(this.note);
  }

}

class NameAddState extends State<NameAdd>{


  DatabaseHelper helper = DatabaseHelper();

  Note note;

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  NameAddState(this.note);



  @override
  Widget build(BuildContext context) {

    nameController.text = note.name;
    numberController.text = note.number;

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
                    updateName();
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
                    updateNumber();
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
                    setState(() {
                      debugPrint("Save Button Pressed");
                      _save();
                    });
                  },
                ),
            )
          ],
        ),
      )
    ));
  }

  void moveToLastscreen(){
    Navigator.pop(context, true);
  }

  void _save() async {

    moveToLastscreen();

    int result;
    result = await helper.insertNote(note);

    if (result != 0) {
      //sucess
      _showAlert('status', 'Note Saved');
    } else {
      _showAlert('status', 'error saving data');
    }
  }

    void _showAlert(String name, String message){

    AlertDialog alertDialog = AlertDialog(
      title: Text(name),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog);
    }

    void updateName(){
    note.name = nameController.text;
    }
    void updateNumber(){
    note.number = numberController.text;
    }

}
