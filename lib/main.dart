import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dog/data/mydatabase.dart';
import 'package:flutter_dog/provider/auth_ptovider.dart';
import 'package:flutter_dog/provider/favoriten_provider.dart';
import 'package:flutter_dog/provider/user_text_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => UserTextProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Database Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final database = MyDatabase.instance;

              // Ein Datensatz einfügen
              final id = await database
                  .insert('my_table', {'name': 'John', 'age': 30});

              // Alle Datensätze abrufen
              final allRows = await database.queryAllRows('my_table');
              if (kDebugMode) {
                print(allRows);
              }

              // Einen Datensatz aktualisieren
              await database
                  .update('my_table', id, {'name': 'Jane', 'age': 25});
              final updatedRow = await database.queryAllRows('my_table');
              if (kDebugMode) {
                print(updatedRow);
              }

              // Einen Datensatz löschen
              final rowsDeleted = await database.delete('my_table', id);
              if (kDebugMode) {
                print(rowsDeleted);
              }
            },
            child: const Text('Perform Database Operations'),
          ),
        ),
      ),
    );
  }
}


