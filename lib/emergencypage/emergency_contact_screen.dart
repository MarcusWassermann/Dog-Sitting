import 'package:flutter/material.dart';

class EmergencyContactScreen extends StatelessWidget {
  final String contactName; // Name des Notfallkontakts

  const EmergencyContactScreen({super.key, required this.contactName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notfallkontakt - $contactName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0), // Äußeres Padding hinzufügen
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 2), // Rote Umrandung
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
                  'Notfallkontakt-Funktion',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Notfallfunktionalität noch nicht implementiert'),
                      ),
                    );
                  },
                  child: const Text('Notfall auslösen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
