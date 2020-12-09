import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:database_app/models/note.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper; //singleton Databasehelper
  static Database _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colName = 'name';
  String colNumber = 'number';

  DatabaseHelper._createInstance(); //named constructor to create instance of DatabaseHelper

  factory DatabaseHelper(){

    if ( _databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;

  }

  Future<Database> get database async {
    if (_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb );
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colNumber TEXT)');
  }
  //FETCH DATA FROM DB
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

  //  var result = await db.rawQuery('SELECT * FROM $noteTable order by $colName ASC');//rawQuery
    var result = await db.query(noteTable, orderBy: '$colName ASC'); //helperfn
    return result;
  }
  //INSERT DATA TO DB
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  //GET NO.OF NOTE OBJECTS IN DB
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) FROM $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [List<Map>] and convert it to 'Note List' [List<Note>]
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<Note> noteList = List<Note>();

    for (int i = 0; i < count ; i++){
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

}