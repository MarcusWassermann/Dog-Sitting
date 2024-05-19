// widgets/advertisement_item.dart

import 'dart:io';
import 'package:flutter/material.dart';

class AdvertisementItem extends StatelessWidget {
  final String enteredText;
  final File? image;

  const AdvertisementItem({super.key, required this.enteredText, this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (image != null)
          SizedBox(
            width: 100,
            height: 100,
            child: Image.file(image!),
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
  }
}
