// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dogs_sitting/custompage/widgets/advertisement_list_view.dart';
import 'package:dogs_sitting/custompage/repository/custom_repository.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:flutter/foundation.dart';

class CustomListViewScreen extends StatefulWidget {
  const CustomListViewScreen({super.key});

  @override
  _CustomListViewScreenState createState() => _CustomListViewScreenState();
}

class _CustomListViewScreenState extends State<CustomListViewScreen> {
  late TextEditingController _searchController;
  List<UserText> advertisements = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    loadAdvertisements();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadAdvertisements() async {
    try {
      List<UserText> fetchedAdvertisements =
          await CustomRepository().getAdvertisements();
      setState(() {
        advertisements = fetchedAdvertisements;
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Fehler beim Laden der Anzeigen: $e');
      }
    }
  }

  void initiateSearch() async {
    setState(() {
      searchQuery = _searchController.text
          .substring(0, 2); // Extrahiere die ersten beiden Zeichen
    });
    _searchController.clear();

    try {
      List<UserText> fetchedAdvertisements =
          await CustomRepository().getAdvertisements();
      List<UserText> filteredAdvertisements =
          fetchedAdvertisements.where((advertisement) {
        return advertisement.postcode.startsWith(
            searchQuery); // Suche nach den ersten beiden Zeichen der Postleitzahl
      }).toList();
      setState(() {
        advertisements = filteredAdvertisements;
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Fehler beim Abrufen der Anzeigen: $e');
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
          onSubmitted: (_) => initiateSearch(),
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
      body: AdvertisementListView(advertisements: advertisements),
    );
  }
}
