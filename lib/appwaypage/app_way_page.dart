// app_way_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_dog/adventisement/adventisement_page.dart';
import 'package:flutter_dog/chatpage/chat_screen.dart';
import 'package:flutter_dog/favoritenpage/favoriten_screen.dart';
import 'package:flutter_dog/gallerypage/gallery_page.dart';
import 'package:flutter_dog/profilepage/createprofile_screen.dart';
import 'package:flutter_dog/settingpage/settings_page.dart';
import 'package:flutter_dog/emergencypage/emergency_contact_screen.dart';


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
              MaterialPageRoute(
                  builder: (context) => const FavoriteScreen(favorites: [])),
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
            // Neu hinzugefügt
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
