// ignore_for_file: library_prefixes

import 'package:dogs_sitting/provider/profile_favoriten_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dogs_sitting/data/abstract_database.dart';
import 'package:dogs_sitting/provider/auth_ptovider.dart'
    as DogSittingAuthProvider;
import 'package:dogs_sitting/provider/favoriten_provider.dart';
import 'package:dogs_sitting/provider/user_text_provider.dart';
import 'package:dogs_sitting/provider/emergency_provider.dart'; // Import des EmergencyContactProvider
import 'package:dogs_sitting/provider/user_provider.dart'; // Import des neuen Benutzer-Providers
import 'package:provider/provider.dart';

import 'home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialisierung der SQLite-Datenbank
  await AbstractDatabase.instance.database;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => DogSittingAuthProvider.AuthProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                ProfileFavoriteProvider()), 
        ChangeNotifierProvider(create: (context) => UserTextProvider()),
        ChangeNotifierProvider(create: (context) => EmergencyContactProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                UserProvider()), 
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
      title: 'Dog Sitting Deckblatt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
