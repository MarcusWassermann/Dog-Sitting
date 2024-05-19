// widgets/image_display.dart

import 'dart:io';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final File imageFile;

  const ImageDisplay({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.file(imageFile),
    );
  }
}
