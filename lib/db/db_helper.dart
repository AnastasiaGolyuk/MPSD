import 'dart:io';

import 'package:my_app/db/achievement.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:my_app/db/record.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'labwork1.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE records(
          id INTEGER PRIMARY KEY,
          name TEXT,
          date DateTime,
          satiety INTEGER
      )
      ''');

    await db.execute('''
    CREATE TABLE achievements(
        id INTEGER PRIMARY KEY,
        name TEXT,
        title TEXT,
        subTitle TEXT
    )
    ''');
  }

  Future<int> getSizeRecords() async {
    Database db = await instance.database;
    var results = await db.query('records');
    List<Record> recordList = results.isNotEmpty
        ? results.map((c) => Record.fromMap(c)).toList()
        : [];
    return recordList.length;
  }

  Future<int> getSizeAchievements() async {
    Database db = await instance.database;
    var results = await db.query('achievements');
    List<Achievement> achievementList = results.isNotEmpty
        ? results.map((c) => Achievement.fromMap(c)).toList()
        : [];
    return achievementList.length;
  }

  Future<Record> getLastRecord() async {
    Database db = await instance.database;
    var results = await db.query('records', orderBy: 'date');
    List<Record> recordList = results.isNotEmpty
        ? results.map((c) => Record.fromMap(c)).toList()
        : [];
    return recordList.last;
  }

  Future<List<Record>> getResults() async {
    Database db = await instance.database;
    var results = await db.query('records');
    List<Record> recordList = results.isNotEmpty
        ? results.map((c) => Record.fromMap(c)).toList()
        : [];
    return recordList;
  }

  Future<List<Achievement>> getAchievements() async {
    Database db = await instance.database;
    var results = await db.query('achievements');
    List<Achievement> achievementList = results.isNotEmpty
        ? results.map((c) => Achievement.fromMap(c)).toList()
        : [];
    return achievementList;
  }

  Future<List<Record>> getRecordsSorted() async {
    Database db = await instance.database;
    var results = await db.query('records', orderBy: 'satiety');
    List<Record> recordList = results.isNotEmpty
        ? results.map((c) => Record.fromMap(c)).toList()
        : [];
    return recordList.reversed.toList();
  }

  Future<int> addRecord(Record record) async {
    Database db = await instance.database;
    return await db.insert('records', record.toMap());
  }

  Future<int> addAchievement(Achievement achievement) async {
    Database db = await instance.database;
    return await db.insert('achievements', achievement.toMap());
  }

  Future<bool> isAchievementExist(String title, String name) async {
    List<Achievement> list = await getAchievements();
    for (int i=0;i<list.length;i++){
      if (list[i].title==title&&list[i].name==name){
        return true;
      }
    }
    return false;
  }

  Future<int> remove(int id, String tableName) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
