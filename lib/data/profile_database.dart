import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProfileDatabase {
  static final ProfileDatabase instance = ProfileDatabase._init();

  static Database? _database;

  ProfileDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('profile_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE profiles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        postalCode TEXT NOT NULL,
        imagePath TEXT
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> profile) async {
    final db = await instance.database;
    return await db.insert('profiles', profile);
  }

  Future<List<Map<String, dynamic>>> getAllProfiles() async {
    final db = await instance.database;
    return await db.query('profiles');
  }

  Future<int> update(int id, Map<String, dynamic> profile) async {
    final db = await instance.database;
    return await db.update(
      'profiles',
      profile,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'profiles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
