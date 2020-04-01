import 'dart:io';
import 'package:isolationhero/core/models/setting.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableSettings = 'AppSettings';
final String columnId = '_id';
final String columnKey = 'key';
final String columnValue = 'value';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "IsolationHero.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableSettings (
                $columnId INTEGER PRIMARY KEY,
                $columnKey TEXT NOT NULL,
                $columnValue TEXT NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(Setting setting) async {
    int result = 0;
    Database db = await database;
    Future<Setting> settingFromDb = querySetting(setting.key);
    Setting value;
    if (settingFromDb == null) {
      result = await db.insert(tableSettings, setting.toMap());
    } else {
      settingFromDb.then((val) {
        value = val;
      });
    }
    if (value == null) {
      result = await db.insert(tableSettings, setting.toMap());
    } else {
      setting.id = value.id;
      result = await db.update(tableSettings, setting.toMap(),
          where: '$columnId = ?', whereArgs: [setting.id]);
    }

    return result;
  }

  Future<Setting> querySetting(String key) async {
    Database db = await database;
    List<Map> maps = await db.query(tableSettings,
        columns: [columnId, columnKey, columnValue],
        where: '$columnKey = ?',
        whereArgs: [key]);
    if (maps.length > 0) {
      return Setting.fromMap(maps.first);
    }
    return null;
  }

  Future<void> delete(String settingName) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      tableSettings,
      // Use a `where` clause to delete a specific dog.
      where: "key = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [settingName],
    );
  }
}