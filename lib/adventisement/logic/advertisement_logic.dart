import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

late FirebaseStorage _storage;
late FirebaseFirestore _firestore;

void initStorage() {
  _storage = FirebaseStorage.instance;
  _firestore = FirebaseFirestore.instance;
}

Future<void> uploadImageToStorage(XFile image) async {
  // Bilddatei erstellen
  File imageFile = File(image.path);
  // Referenz zum Speicherort im Firebase Storage
  Reference storageRef = _storage
      .ref()
      .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

  // Bild hochladen
  UploadTask uploadTask = storageRef.putFile(imageFile);
  await uploadTask.whenComplete(() async {
    // URL des hochgeladenen Bildes abrufen
    String imageUrl = await storageRef.getDownloadURL();
    if (kDebugMode) {
      print('Uploaded image URL: $imageUrl');
    }
    // Sammlung und Dokument in Firestore erstellen
    await _firestore.collection('init').doc('init').set({'initialized': true});
  });
}

Future<void> saveAdvertisement(
    String enteredText, String postcode, XFile? image, String userId) async {
  String? imageUrl;
  if (image != null) {
    // Referenz zum Speicherort im Firebase Storage
    Reference storageRef = _storage
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

    // Bild hochladen
    UploadTask uploadTask = storageRef.putFile(File(image.path));
    TaskSnapshot snapshot = await uploadTask;

    // URL des hochgeladenen Bildes abrufen
    imageUrl = await snapshot.ref.getDownloadURL();
  }

  // Anzeige in Firestore speichern
  await _firestore.collection('advertisements').add({
    'enteredText': enteredText,
    'postcode': postcode,
    'imageUrl': imageUrl,
    'userId': userId,
  }).catchError((error) {
    if (kDebugMode) {
      print("Failed to add advertisement: $error");
    }
    throw error;
  });
}
