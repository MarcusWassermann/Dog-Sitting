// ignore_for_file: library_private_types_in_public_api


import 'package:dogs_sitting/provider/auth_ptovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/appwaypage/app_way_page.dart';
import 'login_form.dart';

// Definition der LoginScreen-Klasse
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// Definition des LoginScreenState
class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  // Initialisierung der Textcontroller und Überprüfung des Anmeldezustands
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    // Überprüfen des Anmeldezustands bei der Initialisierung
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().checkLoginState();
    });
  }

  // Freigabe der Textcontroller
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Methode zum Ausführen des Anmeldevorgangs
  void _login(AuthProvider authProvider) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        authProvider.signInWithUsernameAndPassword(username, password);
        if (authProvider.isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AppWayScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Anmeldung fehlgeschlagen! Benutzername oder Passwort ist falsch.'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Anmeldung fehlgeschlagen! Es ist ein Fehler aufgetreten.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Benutzername und Passwort dürfen nicht leer sein.'),
        ),
      );
    }
  }

  // Methode für 'Passwort vergessen'-Aktion
  void _forgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passwort vergessen?'),
      ),
    );
  }

  // Erstellen des UIs für den Login-Bildschirm
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/13.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginForm(
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                    onLogin: () => _login(context.read<AuthProvider>()),
                    onForgotPassword: _forgotPassword,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
