import 'dart:io';

import 'package:dogs_sitting/adventisement/widgets/advertisement_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:dogs_sitting/models/user_text.dart';
import 'package:image_picker/image_picker.dart';


late FirebaseStorage _storage;

void initStorage() {
  _storage = FirebaseStorage.instance;
}

Future<void> uploadImageToStorage(XFile image) async {
  File imageFile = File(image.path);
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

Future<UserText> createUserText(
  String enteredText,
  String postcode,
  XFile? image,
  BuildContext context,
) async {
  Widget advertisementItem = buildAdvertisementWidget(enteredText, image);
  return UserText(
    enteredText,
    id: '',
    postcode: postcode,
    widget: advertisementItem,
  );
}
