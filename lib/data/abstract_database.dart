import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AbstractDatabase {
  static final AbstractDatabase instance = AbstractDatabase._init();

  static Database? _database;

  AbstractDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('abstract_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        _createAdvertisementsTable(db, version);
        _createProfilesTable(db,
            version); // Neue Methode zum Erstellen der Profil-Tabelle hinzufügen
      },
    );
  }

  Future<void> _createAdvertisementsTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE advertisements (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        postcode TEXT NOT NULL,
        imagePath TEXT
      )
    ''');
  }

  // Neue Methode zum Erstellen der Profil-Tabelle hinzufügen
  Future<void> _createProfilesTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE profiles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        postcode TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await instance.database;
    return await db.insert(table, values);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(String table, int id, Map<String, dynamic> values) async {
    final db = await instance.database;
    return await db.update(
      table,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(String table, int id) async {
    final db = await instance.database;
    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
