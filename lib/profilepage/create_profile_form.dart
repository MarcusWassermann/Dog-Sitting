import 'package:dogs_sitting/profilepage/repository/create_profile_repository.dart';
import 'package:dogs_sitting/profilepage/widgets/create_form_design.dart';
import 'package:flutter/material.dart';


class CreateProfileForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController zipCodeController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final bool emergencyContact;
  final VoidCallback onSave;
  final void Function(bool?)? onEmergencyContactChanged;
  final CreateProfileRepository profileRepository;

  const CreateProfileForm({
    super.key,
    required this.usernameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.zipCodeController,
    required this.phoneNumberController,
    required this.emailController,
    required this.emergencyContact,
    required this.onSave,
    this.onEmergencyContactChanged,
    required this.profileRepository,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CreateProfileFormState createState() => _CreateProfileFormState();
}

class _CreateProfileFormState extends State<CreateProfileForm> {
  @override
  Widget build(BuildContext context) {
    return CreateProfileDesign(
      usernameController: widget.usernameController,
      firstNameController: widget.firstNameController,
      lastNameController: widget.lastNameController,
      zipCodeController: widget.zipCodeController,
      phoneNumberController: widget.phoneNumberController,
      emailController: widget.emailController,
      emergencyContact: widget.emergencyContact,
      onSave: widget.onSave, // Added this line
      onEmergencyContactChanged:
          widget.onEmergencyContactChanged, // Added this line
      profileRepository: widget.profileRepository, // Added this line
    );
  }
}
