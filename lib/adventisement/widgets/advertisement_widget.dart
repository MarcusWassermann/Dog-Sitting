import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget buildAdvertisementWidget(String enteredText, XFile? image) {
  return Row(
    children: [
      if (image != null)
        SizedBox(
          width: 100,
          height: 100,
          child: Image.file(File(image.path)),
        ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: Stack(
                    children: [
                      Center(
                        child: image != null
                            ? CircleAvatar(
                                radius: 40,
                                backgroundImage: FileImage(File(image.path)),
                              )
                            : const CircleAvatar(
                                radius: 40,
                                child: Icon(Icons.person, size: 40),
                              ),
                      ),
                      Positioned(
                        right: 0,
                        child: PopupMenuButton<String>(
                          onSelected: (value) {
                            // Handle menu actions if needed
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem(
                                value: 'upload',
                                child: Text('Bild hochladen'),
                              ),
                              const PopupMenuItem(
                                value: 'change',
                                child: Text('Bild ändern'),
                              ),
                            ];
                          },
                        ),
                      ),
                    ],
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

Widget buildFormBody(
  XFile? image,
  TextEditingController textEditingController,
  VoidCallback uploadImage,
) {
  return Row(
    children: [
      if (image != null)
        SizedBox(
          width: 100,
          height: 100,
          child: Image.file(File(image.path)),
        ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: Stack(
                    children: [
                      Center(
                        child: image != null
                            ? CircleAvatar(
                                radius: 40,
                                backgroundImage: FileImage(File(image.path)),
                              )
                            : const CircleAvatar(
                                radius: 40,
                                child: Icon(Icons.person, size: 40),
                              ),
                      ),
                      Positioned(
                        right: 0,
                        child: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'upload') {
                              uploadImage();
                            } else if (value == 'change') {
                              uploadImage();
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem(
                                value: 'upload',
                                child: Text('Bild hochladen'),
                              ),
                              const PopupMenuItem(
                                value: 'change',
                                child: Text('Bild ändern'),
                              ),
                            ];
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: textEditingController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Text eingeben',
                            filled: true,
                            fillColor: Colors.white,
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
  );
}
