// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dogs_sitting/custompage/repository/profile_repository.dart';
import 'package:dogs_sitting/models/user_profile.dart';

class ProfileListView extends StatefulWidget {
  const ProfileListView({super.key});

  @override
  _ProfileListViewState createState() => _ProfileListViewState();
}

class _ProfileListViewState extends State<ProfileListView> {
  List<UserProfile> profiles = [];
  bool isSearchInitiated = false;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

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

  void initiateSearch() async {
    setState(() {
      isSearchInitiated = true;
      searchQuery = _searchController.text;
    });
    _searchController.clear();

    try {
      List<UserProfile> fetchedProfiles =
          await ProfileRepository().getProfiles();
      List<UserProfile> filteredProfiles = fetchedProfiles.where((profile) {
        return profile.zipCode == searchQuery;
      }).toList();
      setState(() {
        profiles = filteredProfiles;
      });
    } catch (e) {
      debugPrint('Error loading profiles: $e');
      setState(() {
        profiles = [];
      });
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
                      vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30,
                          child: Icon(Icons.person, size: 30),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.username ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                profile.zipCode ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                profile.text ?? '',
                                style: const TextStyle(fontSize: 4),
                              ),
                              Text(
                                profile.additionalInfo ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
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
