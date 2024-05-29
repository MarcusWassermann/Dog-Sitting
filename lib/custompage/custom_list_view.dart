// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dogs_sitting/custompage/sitter_list_view.dart';
import 'package:dogs_sitting/custompage/repository/custom_repository.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';

class CustomListViewScreen extends StatefulWidget {
  const CustomListViewScreen({super.key});

  @override
  _CustomListViewScreenState createState() => _CustomListViewScreenState();
}

class _CustomListViewScreenState extends State<CustomListViewScreen>
    with SingleTickerProviderStateMixin {
  String searchQuery = '';
  bool isSearchInitiated = false;
  List<UserText> advertisements = [];
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadAdvertisements();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
                'Anzeigen',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Tab(
              child: Text(
                'Sitter',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAdvertisementsList(),
          const ProfileListView(),
        ],
      ),
    );
  }

  Widget _buildAdvertisementsList() {
    return Stack(
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
                          advertisement.enteredText,
                          style: const TextStyle(
                            fontSize: 16, // Schriftgröße verringern
                            fontWeight: FontWeight.normal, // Weniger fett
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          'Postleitzahl: ${advertisement.postcode}',
                          style: const TextStyle(
                            fontSize: 14, // Schriftgröße verringern
                            color: Colors.black,
                          ),
                        ),
                        trailing: Consumer<FavoriteProvider>(
                          builder: (context, favoriteProvider, _) {
                            return IconButton(
                              icon: Icon(
                                  favoriteProvider.isFavorite(advertisement)
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                              onPressed: () {
                                if (favoriteProvider
                                    .isFavorite(advertisement)) {
                                  favoriteProvider
                                      .removeFromFavorites(advertisement);
                                } else {
                                  favoriteProvider
                                      .addToFavorites(advertisement);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
