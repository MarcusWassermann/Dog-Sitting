// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:dogs_sitting/adventisement/widgets/advertisement_design.dart';
import 'package:dogs_sitting/adventisement/widgets/advertisement_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dogs_sitting/adventisement/logic/advertisement_logic.dart';
import 'package:dogs_sitting/models/user_text.dart';


class AdvertisementForm extends StatefulWidget {
  final TextEditingController postcodeEditingController;

  const AdvertisementForm({super.key,required this.postcodeEditingController});

  @override
  _AdvertisementFormState createState() => _AdvertisementFormState();
}

class _AdvertisementFormState extends State<AdvertisementForm> {
  late TextEditingController _textEditingController;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    initStorage(); // Firebase Storage initialisieren
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    widget.postcodeEditingController.dispose();
    super.dispose();
  }

  Future<UserText> createUserText(
    String enteredText,
    String postcode,
    XFile? image,
  ) async {
    // ignore: unused_local_variable
    Widget advertisementItem = buildAdvertisementWidget(enteredText, image);
    return UserText(
      enteredText,
      id: '',
      postcode: postcode,
      imagePath: null,
      isApproved: false,
      enteredText: '',
    );
  }

  Future<void> _saveData() async {
    String enteredText = _textEditingController.text;
    String postcode = widget.postcodeEditingController.text;
    User? user = FirebaseAuth.instance.currentUser; // Benutzer abrufen

    if (enteredText.isNotEmpty && postcode.isNotEmpty && user != null) {
      try {
        // ignore: unused_local_variable
        UserText userText = await createUserText(
          enteredText,
          postcode,
          _image,
        );

        await saveAdvertisement(
            enteredText, postcode, _image, user.uid); // Benutzer-ID verwenden

        setState(() {
          _textEditingController.clear();
          widget.postcodeEditingController.clear();
          _image = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Daten erfolgreich gespeichert'),
          duration: Duration(seconds: 2),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Fehler beim Speichern der Daten: $e'),
          duration: const Duration(seconds: 2),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Bitte füllen Sie alle erforderlichen Felder aus und stellen Sie sicher, dass der Benutzer authentifiziert ist'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void _uploadImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
    if (_image != null) {
      await uploadImageToStorage(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdvertisementDesign(
      image: _image,
      textEditingController: _textEditingController,
      postcodeEditingController: widget.postcodeEditingController,
      uploadImage: _uploadImage,
      saveData: _saveData,
    );
  }
}
