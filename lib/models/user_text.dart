

import 'package:flutter/material.dart';

class UserText {
  final String text;
  final String id;
  final String postcode; // Hinzugefügt
  final String? imagePath; // Hinzugefügt
  bool isApproved; // Hinzugefügt

  UserText(this.text,
      {required this.id,
      required this.postcode,
      this.imagePath,
      this.isApproved = false, required Widget widget});

  @override
  String toString() {
    return 'UserText{text: $text, id: $id, postcode: $postcode, imagePath: $imagePath, isApproved: $isApproved}';
  }
}
