// ignore_for_file: library_private_types_in_public_api

import 'package:dogs_sitting/provider/emergency_provider.dart';
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
  String _phoneNumber1 = '';
  final String _phoneNumber2 = '';
  final String _phoneNumber3 = '';
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _phoneController1 = TextEditingController();
  final TextEditingController _phoneController2 = TextEditingController();
  final TextEditingController _phoneController3 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getEmergencyContact() async {
    try {
      final emergencyContactProvider =
          Provider.of<EmergencyContactProvider>(context, listen: false);
      await emergencyContactProvider.fetchEmergencyContact(widget.documentId);
      setState(() {
        _phoneNumber1 = emergencyContactProvider.phoneNumber;
        _phoneController1.text = _phoneNumber1;
      });
    } catch (error) {
      // Fehlerbehandlung
    }
  }

  Future<void> _triggerEmergency(BuildContext context) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final message = _phoneNumber1.isNotEmpty
        ? 'Notfall ausgelöst an $_phoneNumber1, $_phoneNumber2, $_phoneNumber3'
        : '';

    setState(() {
      _emergencyTriggered = true;
      _emergencyMessage = message;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    await _getEmergencyContact();
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
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red, width: 5),
                  borderRadius: BorderRadius.circular(10),
                ),
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
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: _postcodeController,
                        decoration: const InputDecoration(
                          labelText: 'PLZ',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _phoneController1,
                        decoration: const InputDecoration(
                          labelText: 'Telefonnummer 1',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _phoneController2,
                        decoration: const InputDecoration(
                          labelText: 'Telefonnummer 2',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _phoneController3,
                        decoration: const InputDecoration(
                          labelText: 'Telefonnummer 3',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
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
            ],
          ),
        ),
      ),
    );
  }
}
