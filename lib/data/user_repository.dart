import 'package:dogs_sitting/data/abstract_database.dart';

class UserRepository {
  final AbstractDatabase _database;

  UserRepository(this._database);

  Future<void> addUser(String name, int age) async {
    await _database.insert('my_table', {'name': name, 'age': age});
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    return await _database.queryAllRows('my_table');
  }

  // Weitere Methoden für Datenverwaltung ...
}
