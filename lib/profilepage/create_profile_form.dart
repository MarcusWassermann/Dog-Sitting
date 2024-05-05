import 'package:flutter/material.dart';

class CreateProfileForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final VoidCallback onSave;

  const CreateProfileForm({
    super.key,
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
                const CircleAvatar(
                  backgroundColor: Colors.grey, // Hier kann ein Icon oder ein Bild verwendet werden
                  radius: 50, // Hintergrundfarbe des Avatars
                  child: Icon(Icons
                      .person),
                ),
                const SizedBox(height: 16.0),
                _buildProfileTextField(
                  'Vorname',
                  controller: firstNameController,
                  width: 300.0,
                ),
                const SizedBox(height: 16.0),
                _buildProfileTextField(
                  'Nachname',
                  controller: lastNameController,
                  width: 300.0,
                ),
                const SizedBox(height: 16.0),
                _buildProfileTextField(
                  'Alter',
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  width: 100.0,
                ),
                const SizedBox(height: 16.0),
                _buildProfileTextField(
                  'Telefonnummer',
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  width: 200.0,
                ),
                const SizedBox(height: 16.0),
                _buildProfileTextField(
                  'E-Mail',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  width: 300.0,
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
    required TextEditingController controller,
    TextInputType? keyboardType,
    required double width,
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
