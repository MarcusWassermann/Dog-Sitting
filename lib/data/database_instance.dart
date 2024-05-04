import 'package:flutter/foundation.dart';
import 'package:flutter_dog/data/mydatabase.dart';

void main() async {
  final database = MyDatabase.instance;

  // Ein Datensatz einfügen
  final id = await database.insert('my_table', {'name': 'John', 'age': 30});

  // Alle Datensätze abrufen
  // ignore: unused_local_variable
  final allRows = await database.queryAllRows('my_table');

  // Einen Datensatz aktualisieren
  await database.update('my_table', id, {'name': 'Jane', 'age': 25});

  // Einen Datensatz löschen
  final rowsDeleted = await database.delete('my_table', id);

  if (kDebugMode) {
    print(
      'Rows deleted: $rowsDeleted');
  } // Zeigen Sie die Anzahl der gelöschten Zeilen an
}
