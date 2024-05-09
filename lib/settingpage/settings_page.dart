import 'package:dogs_sitting/provider/auth_ptovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/user_text_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<UserTextProvider>(context, listen: false)
                    .deleteAllUserTexts();
              },
              child: const Text('Delete All User Texts'),
            ),
            ElevatedButton(
              onPressed: () {
                
              },
              child: const Text('Delete Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                // Hier können Sie die Funktion zum Löschen der Anzeige einfügen
                // Zum Beispiel:
                // Provider.of<AdProvider>(context, listen: false).deleteAd();
              },
              child: const Text('Delete Ad'),
            ),
            ElevatedButton(
              onPressed: () {
                // Hier können Sie die Funktion zum Entfernen als Notfallkontakt einfügen
                // Zum Beispiel:
                // Provider.of<ContactProvider>(context, listen: false).removeAsEmergencyContact();
              },
              child: const Text('Remove as Emergency Contact'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
