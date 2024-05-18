import 'package:flutter/material.dart';

class EmergencyContactScreen extends StatelessWidget {
  final String contactName; // Name des Notfallkontakts

  const EmergencyContactScreen({super.key,required this.contactName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Hintergrund über die App-Leiste hinaus erweitern
      appBar: AppBar(
        title: Text(' - $contactName'),
        backgroundColor: Colors.transparent, // Transparente App-Leiste
        elevation: 0, // Kein Schatten
      ),
      body: Container(
        color: Colors.blue, // Hintergrundfarbe
        child: Padding(
          padding: const EdgeInsets.all(30.0), // Äußeres Padding hinzufügen
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Weiße Füllfarbe beibehalten
              border: Border.all(color: Colors.red, width: 5), // Rote Umrandung
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Orangefarbener Button
                    ),
                    child: const Text('Notfall auslösen'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
