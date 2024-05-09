import 'package:flutter/material.dart';

class CreateProfileForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final bool emergencyContact;
  final bool normalContact;
  final VoidCallback onSave;
  final void Function(bool?)? onEmergencyContactChanged;
  final void Function(bool?)? onNormalContactChanged;

  const CreateProfileForm({
    super.key,
    required this.usernameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.ageController,
    required this.phoneNumberController,
    required this.emailController,
    required this.emergencyContact,
    required this.normalContact,
    required this.onSave,
    this.onEmergencyContactChanged,
    this.onNormalContactChanged,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Notfall Kontakt'),
                      Checkbox(
                        value: emergencyContact,
                        onChanged: onEmergencyContactChanged,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Normal Kontakt'),
                      Checkbox(
                        value: normalContact,
                        onChanged: onNormalContactChanged,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: onSave,
                    child: const Text('Profil erstellen'),
                  ),
                ],
              ),
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
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
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
}
