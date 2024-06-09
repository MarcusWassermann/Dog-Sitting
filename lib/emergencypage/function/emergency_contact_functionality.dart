// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/emergency_provider.dart';

class EmergencyContactFunctionality extends StatefulWidget {
  final String documentId;

  const EmergencyContactFunctionality({
    super.key,
    required this.documentId,
  });

  @override
  _EmergencyContactFunctionalityState createState() =>
      _EmergencyContactFunctionalityState();
}

class _EmergencyContactFunctionalityState
    extends State<EmergencyContactFunctionality> {
  String _phoneNumber1 = '';
  String _phoneNumber2 = '';
  String _phoneNumber3 = '';
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _phoneController1 = TextEditingController();
  final TextEditingController _phoneController2 = TextEditingController();
  final TextEditingController _phoneController3 = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _postcodeController.addListener(_checkPostcode);
  }

  void _checkPostcode() {
    setState(() {
      _isButtonEnabled = _postcodeController.text.length == 2;
      if (!_isButtonEnabled) {
        _phoneNumber1 = '';
        _phoneNumber2 = '';
        _phoneNumber3 = '';
        _phoneController1.clear();
        _phoneController2.clear();
        _phoneController3.clear();
      }
    });
  }

  Future<void> _loadEmergencyContacts() async {
    final userZipCode = _postcodeController.text;

    final emergencyContactProvider =
        Provider.of<EmergencyContactProvider>(context, listen: false);
    final List<String> phoneNumbers = await emergencyContactProvider
        .fetchEmergencyContact(widget.documentId, userZipCode);

    setState(() {
      _phoneNumber1 = phoneNumbers.isNotEmpty ? phoneNumbers[0] : '';
      _phoneNumber2 = phoneNumbers.length >= 2 ? phoneNumbers[1] : '';
      _phoneNumber3 = phoneNumbers.length >= 3 ? phoneNumbers[2] : '';

      _phoneController1.text = _phoneNumber1;
      _phoneController2.text = _phoneNumber2;
      _phoneController3.text = _phoneNumber3;
    });
  }

  Future<void> _triggerEmergency(BuildContext context) async {
    if (_postcodeController.text.length == 2) {
      await _loadEmergencyContacts();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      final message = _phoneNumber1.isNotEmpty
          ? 'Notfall ausgelöst an $_phoneNumber1, $_phoneNumber2, $_phoneNumber3'
          : 'Keine Telefonnummern verfügbar';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ungültige PLZ')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Telefonnummer 1',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLength: 10,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _phoneController2,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Telefonnummer 2',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLength: 10,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _phoneController3,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Telefonnummer 3',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLength: 10,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isButtonEnabled
                        ? () => _triggerEmergency(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isButtonEnabled ? Colors.orange : Colors.grey,
                    ),
                    child: const Text('Notfall auslösen'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
