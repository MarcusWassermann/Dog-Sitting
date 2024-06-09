// EmergencyContactScreen.dart

import 'package:dogs_sitting/emergencypage/function/emergency_contact_functionality.dart';
import 'package:flutter/material.dart';

class EmergencyContactScreen extends StatelessWidget {
  final String contactName;
  final String documentId;

  const EmergencyContactScreen({super.key, 
    required this.contactName,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(contactName),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: EmergencyContactFunctionality(documentId: documentId),
    );
  }
}
