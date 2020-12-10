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

  final dbHelper = DatabaseHelper.instance;
  List<Car> cars = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    //
    // if (noteList == null) {
    //   noteList = List<Note>();
    //   updateListView();
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Name List'),
      ),
      body: getNameList(),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint('FAB Presseed');
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return NameAdd();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }


  ListView getNameList(){

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: cars.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == cars.length) {
          return RaisedButton(
            child: Text('Refresh'),
            onPressed: () {
              setState(() {
                _queryAll();
              });
            },
          );
        }
        return Container(
          height: 40,
          child: Center(
            child: Text(
              '[${cars[index].id}] ${cars[index].name} - ${cars[index].miles} miles',
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      },
    );
  }

  void _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    cars.clear();
    allRows.forEach((row) => cars.add(Car.fromMap(row)));
    //_showMessageInScaffold('Query done.');
    setState(() {});
  }

  // void updateListView(){
  //
  //   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  //   dbFuture.then((database){
  //
  //     Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
  //     noteListFuture.then((noteList){
  //       setState(() {
  //         this.noteList = noteList;
  //         this.count = noteList.length;
  //       });
  //     });
  //   });
  // }

  // void navigateToDetail(Note note) async {
  //  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
  //     return NameAdd(note);
  //   }));
  //  if (result == true){
  //    updateListView();
  //  }
  // }
}