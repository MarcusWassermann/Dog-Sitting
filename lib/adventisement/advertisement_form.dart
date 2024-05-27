// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dogs_sitting/adventisement/logic/advertisement_logic.dart';
import 'package:dogs_sitting/adventisement/widgets/advertisement_widget.dart';
import 'package:dogs_sitting/models/user_text.dart';

class AdvertisementForm extends StatefulWidget {
  final TextEditingController postcodeEditingController;

  const AdvertisementForm({super.key, required this.postcodeEditingController});

  @override
  _AdvertisementFormState createState() => _AdvertisementFormState();
}

class _AdvertisementFormState extends State<AdvertisementForm> {
  late TextEditingController _textEditingController;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    initStorage(); // Firebase Storage initialisieren
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    widget.postcodeEditingController.dispose();
    super.dispose();
  }

  Future<UserText> createUserText(
    String enteredText,
    String postcode,
    XFile? image,
  ) async {
    // ignore: unused_local_variable
    Widget advertisementItem = buildAdvertisementWidget(enteredText, image);
    return UserText(
      enteredText,
      id: '',
      postcode: postcode,
      imagePath: null,
      isApproved: false,
    );
  }

  Future<void> _saveData() async {
    String enteredText = _textEditingController.text;
    String postcode = widget.postcodeEditingController.text;
    User? user = FirebaseAuth.instance.currentUser; // Benutzer abrufen

    if (enteredText.isNotEmpty && postcode.isNotEmpty && user != null) {
      try {
        // ignore: unused_local_variable
        UserText userText = await createUserText(
          enteredText,
          postcode,
          _image,
        );

        await saveAdvertisement(
            enteredText, postcode, _image, user.uid); // Benutzer-ID verwenden

        setState(() {
          _textEditingController.clear();
          widget.postcodeEditingController.clear();
          _image = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Daten erfolgreich gespeichert'),
          duration: Duration(seconds: 2),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Fehler beim Speichern der Daten: $e'),
          duration: const Duration(seconds: 2),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Bitte füllen Sie alle erforderlichen Felder aus und stellen Sie sicher, dass der Benutzer authentifiziert ist'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void _uploadImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
    if (_image != null) {
      await uploadImageToStorage(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/1906154.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  buildFormBody(_image, _textEditingController, _uploadImage),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: 150, // Angepasste Breite für 5 Zeichen
                    child: TextField(
                      controller: widget.postcodeEditingController,
                      maxLength: 5, // Maximal 5 Zeichen
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Postcode eingeben',
                        filled: true,
                        fillColor: Colors.white,
                        counterText:
                            "", // Verhindert die Anzeige der Zähleranzeige
                      ),
                    ),
                  ),
                  const SizedBox(height: 320.0),
                  ElevatedButton(
                    onPressed: () {
                      _saveData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Grüne Farbe
                    ),
                    child: const Text('Daten speichern'),
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
