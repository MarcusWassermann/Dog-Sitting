import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader {
  static Future<XFile?> pickImage(ImagePicker picker) async {
    return await picker.pickImage(source: ImageSource.gallery);
  }

  static Future<String> uploadImage(
      XFile image, FirebaseStorage storage) async {
    File imageFile = File(image.path);
    Reference storageRef = storage
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    await uploadTask.whenComplete(() {});
    return await storageRef.getDownloadURL();
  }
}
