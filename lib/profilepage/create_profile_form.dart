import 'package:flutter/material.dart';

class CreateProfileForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final bool emergencyContact;
  final VoidCallback onSave;
  final void Function(bool?)? onEmergencyContactChanged;

  const CreateProfileForm({
    super.key,
    required this.usernameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.ageController,
    required this.phoneNumberController,
    required this.emailController,
    required this.emergencyContact,
    required this.onSave,
    this.onEmergencyContactChanged,
  });

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
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 50,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(height: 16.0),
                  _buildProfileTextField(
                    'Benutzername',
                    controller: usernameController,
                    width: 200.0,
                    height: 40.0,
                    enabled: true,
                  ),
                  const SizedBox(height: 16.0),
                  _buildProfileTextField(
                    'Vorname',
                    controller: firstNameController,
                    width: 200.0,
                    height: 40.0,
                    enabled: true,
                  ),
                  const SizedBox(height: 16.0),
                  _buildProfileTextField(
                    'Nachname',
                    controller: lastNameController,
                    width: 200.0,
                    height: 40.0,
                    enabled: true,
                  ),
                  const SizedBox(height: 16.0),
                  _buildProfileTextField(
                    'Alter',
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    width: 100.0,
                    height: 40.0,
                    enabled: true,
                  ),
                  const SizedBox(height: 16.0),
                  _buildProfileTextField(
                    'Telefonnummer',
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    width: 150.0,
                    height: 40.0,
                    optional: !emergencyContact,
                    enabled: true,
                  ),
                  const SizedBox(height: 16.0),
                  _buildProfileTextField(
                    'E-Mail',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    width: 300.0,
                    height: 40.0,
                    enabled: true,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      onEmergencyContactChanged?.call(!emergencyContact);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: emergencyContact
                          ? Colors.green
                          : Colors
                              .red, // Grüne oder rote Hintergrundfarbe je nach Zustand
                      minimumSize: const Size(
                          30, 30), // Mindestgröße für den Button festlegen
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                            color: Colors.white,
                            width: 2), // Stärkerer weißer Rand
                      ),
                    ),
                    child: Text(
                      'Notfall Kontakt',
                      style: TextStyle(
                        color: emergencyContact
                            ? Colors.white
                            : Colors
                                .black, // Weiße oder schwarze Schriftfarbe je nach Zustand
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_areFieldsFilled()) {
                        await _saveProfileToFirestore();
                        _resetFields();
                        onSave();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bitte füllen Sie alle Felder aus.'),
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
      ),
    );
  }

  Future<void> _saveProfileToFirestore() async {
    // Hier wird das Benutzerprofil in Firestore gespeichert
  }

  void _resetFields() {
    usernameController.clear();
    firstNameController.clear();
    lastNameController.clear();
    ageController.clear();
    phoneNumberController.clear();
    emailController.clear();
  }

  Widget _buildProfileTextField(
    String labelText, {
    required TextEditingController controller,
    TextInputType? keyboardType,
    required double width,
    required double height,
    bool optional = false,
    bool enabled = true,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        enabled: enabled,
        style: const TextStyle(color: Colors.white), // Weiße Füllschriftfarbe
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle:
              const TextStyle(color: Colors.white), // Weiße Schriftfarbe
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.white, width: 2), // Stärkerer weißer Rand
          ),
        ),
        validator: optional
            ? null
            : (value) {
                if (value == null || value.isEmpty) {
                  return 'Dies ist ein Pflichtfeld';
                }
                return null;
              },
      ),
    );
  }

  bool _areFieldsFilled() {
    return usernameController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty;
  }
}
