abstract class AbstractDatabaseService {
  Future<int> insert(String table, Map<String, dynamic> values);
  Future<List<Map<String, dynamic>>> queryAllRows(String table);
  Future<int> update(String table, int id, Map<String, dynamic> values);
  Future<int> delete(String table, int id);
}

class SqliteDatabaseService implements AbstractDatabaseService {
  @override
  Future<int> insert(String table, Map<String, dynamic> values) async {
    // Implementiere die Logik für das Einfügen in die SQLite-Datenbank
    return 0; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    // Implementiere die Logik für das Abfragen aller Zeilen in der SQLite-Datenbank
    return []; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }

  @override
  Future<int> update(String table, int id, Map<String, dynamic> values) async {
    // Implementiere die Logik für das Aktualisieren in der SQLite-Datenbank
    return 0; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }

  @override
  Future<int> delete(String table, int id) async {
    // Implementiere die Logik für das Löschen in der SQLite-Datenbank
    return 0; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }
}

class FirestoreDatabaseService implements AbstractDatabaseService {
  @override
  Future<int> insert(String table, Map<String, dynamic> values) async {
    // Implementiere die Logik für das Einfügen in die Firestore-Datenbank
    return 0; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    // Implementiere die Logik für das Abfragen aller Zeilen in der Firestore-Datenbank
    return []; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }

  @override
  Future<int> update(String table, int id, Map<String, dynamic> values) async {
    // Implementiere die Logik für das Aktualisieren in der Firestore-Datenbank
    return 0; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }

  @override
  Future<int> delete(String table, int id) async {
    // Implementiere die Logik für das Löschen in der Firestore-Datenbank
    return 0; // Beispielwert, ersetze durch tatsächlichen Rückgabewert
  }
}
