import 'package:flutter/material.dart';
import 'package:flutter_dog/provider/auth_ptovider.dart';
import 'package:flutter_dog/provider/favoriten_provider.dart';
import 'package:flutter_dog/provider/user_text_provider.dart';
import 'package:flutter_dog/home/home_screen.dart';
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
