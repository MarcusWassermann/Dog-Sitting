// advertisement_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdvertisementService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> saveAdvertisement(
    String enteredText,
    String postcode,
    XFile image,
  ) async {
    Reference storageRef = storage
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    UploadTask uploadTask = storageRef.putFile(File(image.path));
    TaskSnapshot snapshot = await uploadTask;

    String imageUrl = await snapshot.ref.getDownloadURL();

    await firestore.collection('advertisements').add({
      'enteredText': enteredText,
      'postcode': postcode,
      'imageUrl': imageUrl,
    });
  }
}
