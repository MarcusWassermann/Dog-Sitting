// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dogs_sitting/adventisement/logic/advertisement_logic.dart';
import 'package:dogs_sitting/adventisement/widgets/advertisement_widget.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:dogs_sitting/provider/user_text_provider.dart';
import 'package:provider/provider.dart';

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
    initStorage();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    widget.postcodeEditingController.dispose();
    super.dispose();
  }

  void _saveData() async {
    String enteredText = _textEditingController.text;
    String postcode = widget.postcodeEditingController.text;
    if (enteredText.isNotEmpty && postcode.isNotEmpty) {
      UserText userText = await createUserText(
        enteredText,
        postcode,
        _image,
        context,
      );

      Provider.of<UserTextProvider>(context, listen: false)
          .addUserText(userText);

      _textEditingController.clear();
      widget.postcodeEditingController.clear();
      setState(() {
        _image = null;
      });
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
      appBar: null, // Entfernt die AppBar aus der AdvertisementForm
      body: Stack(
        children: [
          // Hintergrundbild
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/1906154.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Formularelemente
          Positioned(
            top: MediaQuery.of(context).padding.top, // Positioniert die Elemente unter der StatusBar
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
                    width: 100,
                    child: TextField(
                      controller: widget.postcodeEditingController,
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Postcode eingeben',
                        filled: true,
                        fillColor: Colors.white,
                        counterText: "",
                      ),
                    ),
                  ),
                  const SizedBox(height: 320.0),
                  ElevatedButton(
                    onPressed: _saveData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Textfarbe schwarz
                    ),
                    child: const Text('Daten speichern',
                        style: TextStyle(color: Colors.white)), // Textfarbe weiß
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
