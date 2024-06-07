import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';
import 'package:dogs_sitting/provider/profile_favoriten_provider.dart';
import 'package:dogs_sitting/favoritenpage/widgets/favoriten_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final profileFavoriteProvider =
        Provider.of<ProfileFavoriteProvider>(context);

    // Combine favorites from both providers
    final favorites = [
      ...favoriteProvider.favorites,
      ...profileFavoriteProvider.favorites
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Favoriten',
          style: TextStyle(color: Color.fromARGB(255, 64, 55, 55)),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 35, 34, 34)),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/9.png',
            fit: BoxFit.cover,
          ),
          ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return FavoriteListItem(favorite: favorite);
            },
          ),
        ],
      ),
    );
  }
}
