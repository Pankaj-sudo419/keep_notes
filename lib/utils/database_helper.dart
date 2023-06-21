// ignore_for_file: prefer_conditional_assignment, prefer_interpolation_to_compose_strings

import 'package:keep_note/model/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; //singleton DatabaseHelper
  static Database? _database; //singleton Database

  String noteTable = "note_table";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colPriority = "priority ";
  String colDate = "date";

  DatabaseHelper._createInstance(); //named constructor to create instance of DatabaseHelper
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  //getter for database
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  //to initialize the database
  Future<Database> initializeDatabase() async {
    //get the directory path for both ios and andriod to store data base
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "notes.db";

    //open/create the database at given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  //to create database
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colDescription TEXT,$colPriority INTEGER,$colDate TEXT)");
  }

  //functions to perform CRUD opration.......

  //.................................//

  //fetch opration:Get all note objects to database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery(
        "SELECT * FROM $noteTable order by $colPriority ASC"); // by custome query
    // var result = await db.query(noteTable,
    // orderBy: "$colPriority ASC"); //by sqflite query
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database, it mean number of records in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }
}
