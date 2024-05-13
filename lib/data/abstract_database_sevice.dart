abstract class AbstractDatabaseService {
  Future<bool> isUserValid(String username, String password);
  Future<int> insert(String table, Map<String, dynamic> values);
  Future<List<Map<String, dynamic>>> queryAllRows(String table);
  Future<int> update(String table, int id, Map<String, dynamic> values);
  Future<int> delete(String table, int id);
}

class SqliteDatabaseService implements AbstractDatabaseService {
  @override
  Future<int> insert(String table, Map<String, dynamic> values) async {
    //  Logik für das Einfügen in die SQLite-Datenbank
    return 0; // Beispielwert, ersetze  tatsächlichen Rückgabewert
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    //  Logik für das Abfragen aller Zeilen in der SQLite-Datenbank
    return []; // Beispielwert, ersetze  tatsächlichen Rückgabewert
  }

  @override
  Future<int> update(String table, int id, Map<String, dynamic> values) async {
    //  Logik für das Aktualisieren in der SQLite-Datenbank
    return 0; // Beispielwert, ersetze  tatsächlichen Rückgabewert
  }

  @override
  Future<int> delete(String table, int id) async {
    //  Logik für das Löschen in der SQLite-Datenbank
    return 0; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }

  @override
  Future<bool> isUserValid(String username, String password) async {
    // Implementiere hier deine Logik zur Überprüfung der Benutzeranmeldeinformationen
    // Zum Beispiel: Rückgabe true, wenn die Anmeldeinformationen gültig sind, andernfalls false
    return true; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }
}

class FirestoreDatabaseService implements AbstractDatabaseService {
  @override
  Future<int> insert(String table, Map<String, dynamic> values) async {
    //  Logik für das Einfügen in die Firestore-Datenbank
    return 0; // Beispielwert, ersetze  tatsächlichen Rückgabewert
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    //  Logik für das Abfragen aller Zeilen in der Firestore-Datenbank
    return []; // Beispielwert, ersetze  tatsächlichen Rückgabewert
  }

  @override
  Future<int> update(String table, int id, Map<String, dynamic> values) async {
    //  Logik für das Aktualisieren in der Firestore-Datenbank
    return 0; // Beispielwert, ersetze tatsächlichen Rückgabewert
  }

  @override
  Future<int> delete(String table, int id) async {
    //  Logik für das Löschen in der Firestore-Datenbank
    return 0; // Beispielwert, ersetze tatsächlichen Rückgabewert
  }

  @override
  Future<bool> isUserValid(String username, String password) async {
    // Implementiere hier deine Logik zur Überprüfung der Benutzeranmeldeinformationen
    // Zum Beispiel: Rückgabe true, wenn die Anmeldeinformationen gültig sind, andernfalls false
    return true; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }
}
