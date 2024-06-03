import 'package:dogs_sitting/favoritenpage/widgets/favoriten_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';
import 'package:dogs_sitting/models/user_text.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteProvider favoriteProvider =
        Provider.of<FavoriteProvider>(context);

    final List<UserText> favorites =
        favoriteProvider.favorites.cast<UserText>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/20330741.jpg',
            fit: BoxFit.cover,
          ),
          ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final UserText favorite = favorites[index];
              return FavoriteListItem(
                favorite: favorite,
              );
            },
          ),
        ],
      ),
    );
  }
}
