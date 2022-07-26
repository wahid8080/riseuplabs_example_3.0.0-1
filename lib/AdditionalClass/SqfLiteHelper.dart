import 'package:emp/Model/InboxModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static const _databaseName = "email_s.db";
  static const _databaseVersion = 1;

  static const table = 'email_store';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnEmail = 'email';
  static const columnDetails = 'details';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnDetails TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(InboxModel inboxModel) async {
    Database db = await instance.database;
    return await db.insert(table, {'title': inboxModel.title, 'email': inboxModel.email,'details' : inboxModel.details});
  }
}