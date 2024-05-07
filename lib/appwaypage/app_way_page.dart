import 'package:dogs_sitting/adventisement/adventisement_page.dart';
import 'package:dogs_sitting/chatpage/chat_screen.dart';
import 'package:dogs_sitting/emergencypage/emergency_contact_screen.dart';
import 'package:dogs_sitting/favoritenpage/favoriten_screen.dart';
import 'package:dogs_sitting/gallerypage/gallery_page.dart';
import 'package:dogs_sitting/profilepage/createprofile_screen.dart';
import 'package:dogs_sitting/settingpage/settings_page.dart';
import 'package:flutter/material.dart';

class AppWayScreen extends StatelessWidget {
  const AppWayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Way'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCategoryButton(context, 'Favoriten', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoriteScreen()),
            );
          }),
          _buildCategoryButton(context, 'Einstellungen', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          }),
          _buildCategoryButton(context, 'Profil erstellen', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateProfileScreen()),
            );
          }),
          _buildCategoryButton(context, 'Anzeigen', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdvertisementPage()),
            );
          }),
          _buildCategoryButton(context, 'Notfallkontakt', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const EmergencyContactScreen(contactName: '')),
            );
          }),
          _buildCategoryButton(context, 'Galerie', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GalleryPage()),
            );
          }),
          _buildCategoryButton(context, 'Chat', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          }),
          // Weitere Kategorien können hier hinzugefügt werden
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
