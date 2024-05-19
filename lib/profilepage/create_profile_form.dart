import 'package:dogs_sitting/profilepage/repository/create_profile_repository.dart';
import 'package:dogs_sitting/profilepage/widgets/profile_avatar.dart';
import 'package:dogs_sitting/profilepage/widgets/profile_text_field.dart';
import 'package:flutter/material.dart';

class CreateProfileForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final TextEditingController additionalInfoController =
      TextEditingController();
  final bool emergencyContact;
  final VoidCallback onSave;
  final void Function(bool?)? onEmergencyContactChanged;
  final CreateProfileRepository profileRepository;

  CreateProfileForm({
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
    required this.profileRepository,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ProfileAvatar(),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'Benutzername',
                  controller: usernameController,
                  width: 200.0,
                  height: 40.0,
                ),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'Vorname',
                  controller: firstNameController,
                  width: 200.0,
                  height: 40.0,
                ),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'Nachname',
                  controller: lastNameController,
                  width: 200.0,
                  height: 40.0,
                ),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'Alter',
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  width: 100.0,
                  height: 40.0,
                ),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'Telefonnummer',
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  width: 150.0,
                  height: 40.0,
                  optional: !emergencyContact,
                ),
                const SizedBox(height: 16.0),
                ProfileTextField(
                  labelText: 'E-Mail',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  width: 300.0,
                  height: 40.0,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: additionalInfoController,
                  maxLines: 5,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Zusätzliche Informationen',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    onEmergencyContactChanged?.call(!emergencyContact);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        emergencyContact ? Colors.green : Colors.red,
                    minimumSize: const Size(30, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'Notfall Kontakt',
                    style: TextStyle(
                      color: emergencyContact ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_areFieldsFilled()) {
                      await profileRepository.saveProfileToFirestore({
                        'username': usernameController.text,
                        'firstName': firstNameController.text,
                        'lastName': lastNameController.text,
                        'age': ageController.text,
                        'phoneNumber': phoneNumberController.text,
                        'email': emailController.text,
                        'emergencyContact': emergencyContact,
                        'additionalInfo': additionalInfoController.text,
                      });
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
    );
  }

  void _resetFields() {
    usernameController.clear();
    firstNameController.clear();
    lastNameController.clear();
    ageController.clear();
    phoneNumberController.clear();
    emailController.clear();
    additionalInfoController.clear();
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
