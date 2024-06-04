// ignore_for_file: use_build_context_synchronously

import 'package:dogs_sitting/profilepage/widgets/profile_avatar.dart';
import 'package:dogs_sitting/profilepage/widgets/profile_text_field.dart';
import 'package:flutter/material.dart';
import 'create_form_design.dart';

// ignore: unused_element
class _CreateProfileDesignState extends State<CreateProfileDesign> {
  final TextEditingController additionalInfoController =
      TextEditingController();

  @override
  void dispose() {
    additionalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProfileAvatar(),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'Benutzername',
                  controller: widget.usernameController,
                  width: 200.0,
                  height: 40.0,
                ),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'Vorname',
                  controller: widget.firstNameController,
                  width: 200.0,
                  height: 40.0,
                ),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'Nachname',
                  controller: widget.lastNameController,
                  width: 200.0,
                  height: 40.0,
                ),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'PLZ',
                  controller: widget.zipCodeController,
                  keyboardType: TextInputType.number,
                  width: 100.0,
                  height: 40.0,
                ),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'E-Mail',
                  controller: widget.emailController,
                  keyboardType: TextInputType.emailAddress,
                  width: 300.0,
                  height: 40.0,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    widget.onEmergencyContactChanged
                        ?.call(!widget.emergencyContact);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        widget.emergencyContact ? Colors.green : Colors.red,
                    minimumSize: const Size(30, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'Notfall Kontakt',
                    style: TextStyle(
                      color:
                          widget.emergencyContact ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'Telefonnummer',
                  controller: widget.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  width: 150.0,
                  height: 40.0,
                  optional: !widget.emergencyContact,
                  fillColor: Colors.grey[200], // Füllfarbe hinzugefügt
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: additionalInfoController,
                  maxLines: 5,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Gebe dein Profiltext ein',
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white, width: 2.0),
                    ),
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white, width: 2.0),
                    ),
                    fillColor: Colors.grey[200], // Füllfarbe hinzugefügt
                    filled: true, // Hinzugefügt, um die Füllfarbe zu aktivieren
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_areFieldsFilled()) {
                      try {
                        await widget.profileRepository.saveProfileToFirestore({
                          'username': widget.usernameController.text,
                          'firstName': widget.firstNameController.text,
                          'lastName': widget.lastNameController.text,
                          'zipCode': widget.zipCodeController.text,
                          'phoneNumber': widget.phoneNumberController.text,
                          'email': widget.emailController.text,
                          'emergencyContact': widget.emergencyContact,
                          'additionalInfo': additionalInfoController.text,
                        });
                        _resetFields();
                        widget.onSave();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Fehler beim Speichern des Profils: $e'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Bitte füllen Sie alle erforderlichen Felder aus.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                  ),
                  child: const Text(
                    'Profil erstellen',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetFields() {
    widget.usernameController.clear();
    widget.firstNameController.clear();
    widget.lastNameController.clear();
    widget.zipCodeController.clear();
    widget.phoneNumberController.clear();
    widget.emailController.clear();
    additionalInfoController.clear();
  }

  bool _areFieldsFilled() {
    bool areFieldsFilled = widget.usernameController.text.isNotEmpty &&
        widget.firstNameController.text.isNotEmpty &&
        widget.lastNameController.text.isNotEmpty &&
        widget.zipCodeController.text.isNotEmpty &&
        widget.emailController.text.isNotEmpty;

    if (widget.emergencyContact) {
      areFieldsFilled &= widget.phoneNumberController.text.isNotEmpty;
    }

    return areFieldsFilled;
  }
}
