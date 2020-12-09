import 'package:database_app/models/note.dart';
import 'package:database_app/screens/namedetail.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:database_app/utils/database_helper.dart';

class NameList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return NameListState();
  }

}
class NameListState extends State<NameList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Name List'),
      ),
      body: getNameList(),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint('FAB Presseed');
          Navigator.push(context, MaterialPageRoute(builder: (context){
             navigateToDetail(Note('', ''));
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }


  ListView getNameList(){

    return ListView.builder(
      itemCount: count,
        itemBuilder: (BuildContext context, int position){

        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(this.noteList[position].name,),
            subtitle: Text(this.noteList[position].number,),
            // trailing: Icon(Icons.delete, color: Colors.grey,),
          ),
        );
        }
    );

  }

  void updateListView(){

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList){
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void navigateToDetail(Note note) async {
   bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
      return NameAdd(note);
    }));
   if (result == true){
     updateListView();
   }
  }
}