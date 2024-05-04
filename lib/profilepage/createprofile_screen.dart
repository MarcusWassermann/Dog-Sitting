import 'package:flutter/material.dart';
import 'package:flutter_dog/adventisement/adventisement_page.dart';
class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Hier könnten Sie zusätzliche Aktionen ausführen, wenn auf den Bildschirm getippt wird
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Erstelle dein Profil',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                _buildProfileImage(context),
                const SizedBox(height: 16.0),
                _buildProfileTextField('Vorname', width: 300.0, height: 50.0),
                const SizedBox(height: 16.0),
                _buildProfileTextField('Nachname', width: 300.0, height: 50.0),
                const SizedBox(height: 16.0),
                _buildProfileTextField('Alter', width: 100.0, height: 50.0),
                const SizedBox(height: 16.0),
                _buildProfileTextField('Telefonnummer',
                    width: 200.0, height: 50.0),
                const SizedBox(height: 16.0),
                _buildProfileTextField('E-Mail', width: 300.0, height: 50.0),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Hier könnte die Logik für die Profilerstellung stehen
                    // Beispiel: Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AdvertisementPage()), // Hier wird zur AdvertisementPage navigiert
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profil erfolgreich erstellt!'),
                      ),
                    );
                  },
                  child: const Text(
                    'Profil erstellen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTextField(
    String labelText, {
    double width = 300.0,
    double height = 50.0,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: TextField(
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hier könnte die Logik zum Hochladen eines Bildes stehen
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        child: const Center(
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
