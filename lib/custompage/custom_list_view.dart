// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dogs_sitting/custompage/repository/custom_repository.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:flutter/foundation.dart';

class CustomListViewScreen extends StatefulWidget {
  const CustomListViewScreen({super.key});

  @override
  _CustomListViewScreenState createState() => _CustomListViewScreenState();
}

class _CustomListViewScreenState extends State<CustomListViewScreen> {
  String searchQuery = '';
  bool isSearchInitiated = false;
  List<UserText> advertisements = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void initiateSearch() async {
    setState(() {
      isSearchInitiated = true;
      searchQuery = _searchController.text;
    });
    _searchController.clear();

    try {
      List<UserText> fetchedAdvertisements =
          await CustomRepository().getAdvertisements();
      List<UserText> filteredAdvertisements =
          fetchedAdvertisements.where((advertisement) {
        return advertisement.postcode.contains(searchQuery);
      }).toList();
      setState(() {
        advertisements = filteredAdvertisements;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Fehler beim Abrufen der Anzeigen: $e');
      }
      setState(() {
        advertisements = [];
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
        title: TextField(
          controller: _searchController,
          onSubmitted: (query) {
            initiateSearch();
          },
          decoration: InputDecoration(
            hintText: 'Postleitzahl eingeben...',
            hintStyle: const TextStyle(color: Colors.white),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
            prefixIcon: IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: initiateSearch,
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/16868426.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned.fill(
            child: advertisements.isEmpty
                ? const Center(
                    child: Text(
                      'Geben Sie eine Postleitzahl ein',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  )
                : ListView.builder(
                    itemCount: advertisements.length,
                    itemBuilder: (context, index) {
                      UserText advertisement = advertisements[index];
                      return Card(
                        child: ListTile(
                          leading: advertisement.imagePath != null
                              ? Image.network(
                                  advertisement.imagePath!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey,
                                ),
                          title: Text(
                            advertisement.text,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'Postleitzahl: ${advertisement.postcode}',
                            style: const TextStyle(color: Colors.black),
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
