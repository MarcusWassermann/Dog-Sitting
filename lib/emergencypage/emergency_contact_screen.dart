// ignore_for_file: library_private_types_in_public_api

import 'package:dogs_sitting/provider/emergency_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmergencyContactScreen extends StatefulWidget {
  final String contactName;
  final String documentId;

  const EmergencyContactScreen({
    super.key,
    required this.contactName,
    required this.documentId,
  });

  @override
  _EmergencyContactScreenState createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  bool _emergencyTriggered = false;
  String _emergencyMessage = '';

  @override
  void initState() {
    super.initState();
    _getEmergencyContact();
  }

  Future<void> _getEmergencyContact() async {
    try {
      final emergencyContactProvider =
          Provider.of<EmergencyContactProvider>(context, listen: false);
      await emergencyContactProvider.fetchEmergencyContact(widget.documentId);
      if (kDebugMode) {
        print('Emergency contact fetched in initState');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching emergency contact: $error');
      }
    }
  }

  Future<void> _triggerEmergency(BuildContext context) async {
    final emergencyContactProvider =
        Provider.of<EmergencyContactProvider>(context, listen: false);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final message = emergencyContactProvider.phoneNumber.isNotEmpty
        ? 'Notfall ausgelöst an ${emergencyContactProvider.phoneNumber}'
        : 'Notfallkontakt nicht gefunden';

    setState(() {
      _emergencyTriggered = true;
      _emergencyMessage = message;
    });

    if (kDebugMode) {
      print('Trigger emergency message: $message');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<EmergencyContactProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.contactName),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red, width: 5),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning,
                        size: 100,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Notfallkontakt',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _triggerEmergency(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('Notfall auslösen'),
                      ),
                      if (_emergencyTriggered) ...[
                        const SizedBox(height: 20),
                        Text(
                          _emergencyMessage,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
