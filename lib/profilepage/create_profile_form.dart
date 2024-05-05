import 'package:flutter/material.dart';

class CreateProfileForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final VoidCallback onSave;

  const CreateProfileForm({super.key, 
    required this.firstNameController,
    required this.lastNameController,
    required this.ageController,
    required this.phoneNumberController,
    required this.emailController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Zusätzliche Aktionen bei Berührung des Bildschirms
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Erstelle dein Profil',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                // Hier könnten Sie das Profilbild hinzufügen
                const SizedBox(height: 16.0),
                _buildProfileTextField(
                  'Vorname',
                  width: 300.0,
                  controller: firstNameController,
                ),
                const SizedBox(height: 16.0),
                _buildProfileTextField(
                  'Nachname',
                  width: 300.0,
                  controller: lastNameController,
                ),
                const SizedBox(height: 16.0),
                _buildProfileTextField(
                  'Alter',
                  width: 100.0,
                  controller: ageController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                _buildProfileTextField(
                  'Telefonnummer',
                  width: 200.0,
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16.0),
                _buildProfileTextField(
                  'E-Mail',
                  width: 300.0,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: onSave,
                  child: const Text('Profil erstellen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTextField(
    String labelText, {
    required double width,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
