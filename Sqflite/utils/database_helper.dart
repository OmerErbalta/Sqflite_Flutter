import 'dart:io';
import 'package:flutter/services.dart';
import 'package:myapp/models/katagori.dart';
import 'package:myapp/models/notlar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper!;
    } else {
      return _databaseHelper!;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
// NewDatabaseName = database built into the phone
    var path = join(databasesPath, "NewDatabaseName.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      //the prepared database is copied from the assets file and saved in the phone
      ByteData data = await rootBundle.load(join("assets", "PreparedDatabase.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

// open the database
    return await openDatabase(
      path,
    );
  }

  Future<List<Map<String, dynamic>>> callTable() async {
    var db = await _getDatabase();
    var result = db.query("TableName");
    return result;
  }

  Future<int> insertTable(ClassName className) async {
    var db = await _getDatabase();
    var result = await db.insert("TableName", className.toMap());
    return result;
  }

  Future<int> updateTable(ClassName className) async {
    var db = await _getDatabase();
    var result = await db.update("TableName", className.toMap(),
        where: 'ID=?', whereArgs: [className.ID]);
    return result;
  }

  Future<int> DeleteRow(ClassName className) async {
    var db = await _getDatabase();
    var result = await db.delete("TableName",
        where: 'ID', whereArgs: [className.ID]);
    return result;
  }