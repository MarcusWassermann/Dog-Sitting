// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dogs_sitting/custompage/repository/profile_repository.dart';
import 'package:dogs_sitting/models/user_profile.dart';

class ProfileListView extends StatefulWidget {
  const ProfileListView({Key? key}) : super(key: key);

  @override
  _ProfileListViewState createState() => _ProfileListViewState();
}

class _ProfileListViewState extends State<ProfileListView> {
  List<UserProfile> profiles = [];

  @override
  void initState() {
    super.initState();
    loadProfiles();
  }

  Future<void> loadProfiles() async {
    try {
      List<UserProfile> fetchedProfiles =
          await ProfileRepository().getProfiles();
      setState(() {
        profiles = fetchedProfiles;
      });
    } catch (e) {
      debugPrint('Error loading profiles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/14116837.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned.fill(
            child: ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                UserProfile profile = profiles[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 60, // Größe des Avatars erhöht
                      child: Icon(Icons.person, size: 72),
                    ),
                    title: Text(
                      profile.username ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          profile.text ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Container(
                          height: 24, // Höhe des Containers für den Abstand
                          child: Row(
                            children: [
                              Text(
                                profile.zipCode ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(), // Hinzugefügt, um den Abstand zu maximieren
                            ],
                          ),
                        ),
                        Text(profile.additionalInfo ?? ''),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
