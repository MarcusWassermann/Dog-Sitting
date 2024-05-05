import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;

  const LoginForm({super.key, 
    required this.usernameController,
    required this.passwordController,
    required this.onLogin,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Benutzername',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 200,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Passwort',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onLogin,
              child: const Text('Einloggen'),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: onForgotPassword,
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Passwort vergessen?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
