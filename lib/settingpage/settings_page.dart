import 'package:dogs_sitting/provider/auth_ptovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/settingpage/widgets/delete_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Einstellungen',
          style: TextStyle(
            color: Color.fromARGB(255, 232, 224, 224),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/1147812.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  side: const BorderSide(width: 2, color: Colors.black),
                ),
                onPressed: () {
                  _showDeleteConfirmation(context, "Profil löschen");
                },
                child: const Text('Profil löschen'),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  side: const BorderSide(width: 2, color: Colors.black),
                ),
                onPressed: () {
                  _showDeleteConfirmation(context, "Anzeige löschen");
                  Provider.of<AuthProvider>(context, listen: false).deleteAd();
                },
                child: const Text('Anzeige löschen'),
              ),
              const SizedBox(height: 250),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  side: const BorderSide(width: 2, color: Colors.black),
                ),
                onPressed: () {
                  _showDeleteConfirmation(
                      context, "Als Notfallkontakt entfernen");
                  Provider.of<AuthProvider>(context, listen: false)
                      .removeAsEmergencyContact();
                },
                child: const Text('Als Notfallkontakt entfernen'),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  side: const BorderSide(width: 2, color: Colors.black),
                ),
                onPressed: () {
                  _showDeleteConfirmation(context, "Abmelden");
                  Provider.of<AuthProvider>(context, listen: false).signOut();
                },
                child: const Text('Abmelden'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(action: action);
      },
    );
  }
}
