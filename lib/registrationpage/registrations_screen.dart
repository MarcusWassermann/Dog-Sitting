import 'package:flutter/material.dart';
import 'package:flutter_dog/registrationpage/registration_form.dart';


class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('Registrieren'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: RegistrationForm(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 252, 252, 252),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                color: Color.fromARGB(255, 5, 5, 5),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
