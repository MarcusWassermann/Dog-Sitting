// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_dog/models/user_text.dart';
import 'package:flutter_dog/provider/user_text_provider.dart';
import 'package:provider/provider.dart';

class AdvertisementPage extends StatelessWidget {
  const AdvertisementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advertisement Page'),
      ),
      body: const AdvertisementForm(),
    );
  }
}

class AdvertisementForm extends StatefulWidget {
  const AdvertisementForm({super.key});

  @override
  _AdvertisementFormState createState() => _AdvertisementFormState();
}

class _AdvertisementFormState extends State<AdvertisementForm> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _saveText() {
    String enteredText = _textEditingController.text;
    if (enteredText.isNotEmpty) {
      UserText userText = UserText(enteredText);
      Provider.of<UserTextProvider>(context, listen: false)
          .addUserText(userText);
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200, // Anpassen der Höhe des Bild-Containers
            child: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Text eingeben',
                prefixIcon: Container(
                  width: 50, // Anpassen der Breite des Bild-Containers
                  height: 50, // Anpassen der Höhe des Bild-Containers
                  margin: const EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _saveText,
            child: const Text('Daten speichern'),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Hier den Code zum Hochladen des Bildes einfügen
            },
            child: const Text('Bild hochladen'),
          ),
        ],
      ),
    );
  }
}
