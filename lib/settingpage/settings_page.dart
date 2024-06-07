
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
            image: AssetImage('assets/14.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildElevatedButton(
                context,
                'Profil löschen',
                () {
                  _showDeleteConfirmation(context, "Profil löschen", () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .deleteProfile();
                    Navigator.pop(context);
                  });
                },
              ),
              const SizedBox(height: 60),
              _buildElevatedButton(
                context,
                'Anzeige löschen',
                () {
                  _deleteAd(context);
                },
              ),
              const SizedBox(height: 250),
              _buildElevatedButton(
                context,
                'Als Notfallkontakt entfernen',
                () {
                  _showDeleteConfirmation(
                      context, "Als Notfallkontakt entfernen", () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .removeAsEmergencyContact(
                            'userId'); // 'userId' durch den tatsächlichen Benutzer-ID-Wert ersetzen
                    Navigator.pop(context);
                  });
                },
              ),
              const SizedBox(height: 60),
              _buildElevatedButton(
                context,
                'Abmelden',
                () {
                  _showDeleteConfirmation(context, "Abmelden", () {
                    Provider.of<AuthProvider>(context, listen: false).signOut();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(20),
        side: const BorderSide(width: 2, color: Colors.black),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, String action, Function onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          action: action,
          onDelete: onDelete,
        );
      },
    );
  }

  void _deleteAd(BuildContext context) {
    _showDeleteConfirmation(context, "Anzeige löschen", () {
      Provider.of<AuthProvider>(context, listen: false).deleteAd(
          'adId'); // 'adId' durch den tatsächlichen Anzeigen-ID-Wert ersetzen
      Navigator.pop(context);
    });
  }
}
