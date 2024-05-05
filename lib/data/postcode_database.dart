
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PostcodeDatabase {
  static final PostcodeDatabase instance = PostcodeDatabase._init();

  static Database? _database;

  PostcodeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('postcode_database.db');
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
      CREATE TABLE postcodes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        postcode TEXT NOT NULL,
        region TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertPostcode(String postcode, String region) async {
    final db = await instance.database;
    return await db.insert(
      'postcodes',
      {'postcode': postcode, 'region': region},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getRegionForPostcode(String postcode) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'postcodes',
      where: 'postcode = ?',
      whereArgs: [postcode],
    );

    if (maps.isNotEmpty) {
      return maps.first['region'] as String;
    }

    return null;
  }
}

// Beispiel der Verwendung in einem Provider
class UserTextProvider {
  // Weitere Methoden und Variablen ...

  // Methode zur Überprüfung der Postleitzahl unter Verwendung von SQFlite
  Future<bool> checkPostcodeWithDatabase(String postcode) async {
    String? region =
        await PostcodeDatabase.instance.getRegionForPostcode(postcode);
    return region != null;
  }
}
