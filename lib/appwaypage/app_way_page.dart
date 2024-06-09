import 'package:dogs_sitting/appwaypage/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:dogs_sitting/custompage/sitter_list_view.dart';
import 'package:dogs_sitting/custompage/custom_list_view.dart';
import 'package:dogs_sitting/adventisement/adventisement_page.dart';
import 'package:dogs_sitting/emergencypage/emergency_contact_screen.dart';
import 'package:dogs_sitting/favoritenpage/favoriten_screen.dart';
import 'package:dogs_sitting/gallerypage/gallery_page.dart';
import 'package:dogs_sitting/settingpage/settings_page.dart';

class AppWayScreen extends StatelessWidget {
  const AppWayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Ensure the body extends behind the AppBar
      appBar: AppBar(
        title: const Text('Wegweiser'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/8.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: kToolbarHeight + 20.0,
                left: 20.0,
                right: 20.0,
                bottom: 20.0 // Added bottom padding
                ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                      height:
                          40), // Space added to offset the removed IconButton
                  ButtonWidgets.buildButton(
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
                  ButtonWidgets.buildButton(
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
                  ButtonWidgets.buildSitterProfileButton(context),
                  const SizedBox(height: 5),
                  ButtonWidgets.buildButton(
                    context,
                    'Notfallkontakt',
                    Icons.emergency,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmergencyContactScreen(
                            contactName: 'Notfallkontakt',
                            documentId: 'DEINE_DOCUMENT_ID',
                          ),
                        ),
                      );
                    },
                    Alignment.centerRight,
                  ),
                  const SizedBox(height: 5),
                  ButtonWidgets.buildButton(
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
                  ButtonWidgets.buildButton(
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
                  ButtonWidgets.buildButton(
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
                  const SizedBox(height: 5),
                  ButtonWidgets.buildButton(
                    context,
                    'Sitter',
                    Icons.pets,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileListView(),
                        ),
                      );
                    },
                    Alignment.centerRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
