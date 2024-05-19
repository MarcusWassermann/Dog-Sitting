// repositories/image_repository.dart

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ImageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile) async {
    Reference storageRef = _storage
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    await uploadTask.whenComplete(() {});
    return await storageRef.getDownloadURL();
  }
}
