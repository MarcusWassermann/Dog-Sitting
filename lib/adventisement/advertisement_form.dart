// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:dogs_sitting/models/user_text.dart';
import 'package:dogs_sitting/provider/user_text_provider.dart';

class AdvertisementForm extends StatefulWidget {
  final TextEditingController postcodeEditingController;

  const AdvertisementForm({super.key, required this.postcodeEditingController});

  @override
  _AdvertisementFormState createState() => _AdvertisementFormState();
}

class _AdvertisementFormState extends State<AdvertisementForm> {
  late TextEditingController _textEditingController;
  late FirebaseStorage _storage;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _storage = FirebaseStorage.instance;
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
      // Hier erstellen wir das Widget, das wir übergeben wollen
      Widget advertisementItem = Row(
        children: [
          if (_image != null)
            SizedBox(
              width: 100,
              height: 100,
              child: Image.file(File(_image!.path)),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(1.0),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          'Container',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Text(
                              enteredText,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

      UserText userText = UserText(
        enteredText,
        id: '',
        postcode: postcode,
        widget: advertisementItem,
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
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
    if (_image != null) {
      File imageFile = File(_image!.path);
      Reference storageRef = _storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      await uploadTask.whenComplete(() async {
        String imageUrl = await storageRef.getDownloadURL();
        if (kDebugMode) {
          print('Uploaded image URL: $imageUrl');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              if (_image != null)
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.file(File(_image!.path)),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.blue,
                          child: const Center(
                            child: Text(
                              'Container',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: TextField(
                                  controller: _textEditingController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Text eingeben',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: 250, // Begrenzung der Breite des Postcode-Eingabebereichs
            child: TextField(
              controller: widget.postcodeEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Postcode eingeben',
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _saveData,
            child: const Text('Daten speichern'),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _uploadImage,
            child: const Text('Bild hochladen'),
          ),
        ],
      ),
    );
  }
}
