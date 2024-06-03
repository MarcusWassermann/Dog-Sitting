// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dogs_sitting/custompage/widgets/profile_list.dart';
import 'package:dogs_sitting/models/user_profile.dart';
import 'package:dogs_sitting/custompage/repository/profile_repository.dart';

class ProfileListView extends StatefulWidget {
  const ProfileListView({super.key});

  @override
  _ProfileListViewState createState() => _ProfileListViewState();
}

class _ProfileListViewState extends State<ProfileListView> {
  late TextEditingController _searchController;
  List<UserProfile> profiles = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    loadProfiles();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadProfiles() async {
    try {
      List<UserProfile> fetchedProfiles =
          await ProfileRepository().getProfiles();
      setState(() {
        profiles = fetchedProfiles;
      });
    } catch (e) {
      debugPrint('Fehler beim Laden der Profile: $e');
    }
  }

  void search(String value) async {
    if (value.isNotEmpty) {
      try {
        List<UserProfile> fetchedProfiles =
            await ProfileRepository().searchProfiles(value);
        setState(() {
          profiles = fetchedProfiles;
        });
      } catch (e) {
        debugPrint('Fehler beim Suchen der Profile: $e');
      }
    } else {
      loadProfiles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: const TextStyle(color: Colors.black),
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.black),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          loadProfiles();
                        });
                      },
                    )
                  : null,
            ),
            style: const TextStyle(color: Colors.black),
            onChanged: search,
          ),
        ),
      ),
      body: ProfileList(profiles: profiles),
    );
  }
}
