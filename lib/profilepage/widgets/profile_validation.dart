import 'package:flutter/material.dart';

bool areFieldsFilled({
  required TextEditingController usernameController,
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController ageController,
  required TextEditingController phoneNumberController,
  required TextEditingController emailController,
}) {
  return usernameController.text.isNotEmpty &&
      firstNameController.text.isNotEmpty &&
      lastNameController.text.isNotEmpty &&
      ageController.text.isNotEmpty &&
      phoneNumberController.text.isNotEmpty &&
      emailController.text.isNotEmpty;
}
