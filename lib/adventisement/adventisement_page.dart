// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _saveData() async {
    String enteredText = _textEditingController.text;
    if (enteredText.isNotEmpty) {
      // Daten in Firestore speichern
      await _firestore.collection('advertisements').add({'text': enteredText});
      _textEditingController.clear();
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
          SizedBox(
            height: 200,
            child: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Text eingeben',
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
          if (_image != null) Image.file(File(_image!.path)),
        ],
      ),
    );
  }
}
