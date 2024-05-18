// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:dogs_sitting/custompage/custom_list_view.dart';
import 'package:dogs_sitting/adventisement/adventisement_page.dart';
import 'package:dogs_sitting/emergencypage/emergency_contact_screen.dart';
import 'package:dogs_sitting/favoritenpage/favoriten_screen.dart';
import 'package:dogs_sitting/gallerypage/gallery_page.dart';
import 'package:dogs_sitting/profilepage/createprofile_screen.dart';
import 'package:dogs_sitting/settingpage/settings_page.dart';

class AppWayScreen extends StatelessWidget {
  const AppWayScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/358238.jpg', 
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: kToolbarHeight + 40.0, left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 5),
                _buildButton(
                  context,
                  'Favoriten',
                  Icons.favorite,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoriteScreen(),
                      ),
                    );
                  },
                  Alignment.centerLeft,
                ),
                const SizedBox(height: 5),
                _buildButton(
                  context,
                  'Einstellungen',
                  Icons.settings,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                  Alignment.centerRight,
                ),
                const SizedBox(height: 5),
                _buildButton(
                  context,
                  'Profil erstellen',
                  Icons.person_add,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateProfileScreen(),
                      ),
                    );
                  },
                  Alignment.centerLeft,
                ),
                const SizedBox(height: 5),
                _buildButton(
                  context,
                  'Notfallkontakt',
                  Icons.emergency,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const EmergencyContactScreen(contactName: ''),
                      ),
                    );
                  },
                  Alignment.centerRight,
                ),
                const SizedBox(height: 5),
                _buildButton(
                  context,
                  'Galerie',
                  Icons.photo_library,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GalleryPage(),
                      ),
                    );
                  },
                  Alignment.centerLeft,
                ),
                const SizedBox(height: 5),
                _buildButton(
                  context,
                  'Anzeigen',
                  Icons.view_list,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomListViewScreen(),
                      ),
                    );
                  },
                  Alignment.centerRight,
                ),
                const SizedBox(height: 5),
                _buildButton(
                  context,
                  'Anzeigen aufgeben',
                  Icons.add_box,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdvertisementPage(),
                      ),
                    );
                  },
                  Alignment.centerLeft,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
    Alignment alignment,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: alignment,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.black), // Icon Farbe anpassen
          label: Text(
            label,
            style: const TextStyle(color: Colors.black), // Textfarbe anpassen
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white, // Textfarbe anpassen
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Colors.black),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          ),
        ),
      ),
    );
  }
}
