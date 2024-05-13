// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:dogs_sitting/settingpage/widgets/delete_dialog.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteProvider favoriteProvider =
        Provider.of<FavoriteProvider>(context);

    final List<UserText> favorites = favoriteProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background_image.jpg', // Pfad zum Hintergrundbild anpassen
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

class FavoriteListItem extends StatelessWidget {
  final UserText favorite;

  const FavoriteListItem({super.key, required this.favorite});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(favorite.text),
      leading: favorite.imagePath != null
          ? Image.asset(favorite.imagePath!)
          : const Icon(Icons.image),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final bool? result = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return const DeleteDialog(
                action: '',
              );
            },
          );

          // Prüfen, ob das Widget noch im Baum vorhanden ist
          if (result == true) {
            Provider.of<FavoriteProvider>(context, listen: false)
                .removeFromFavorites(favorite);
          }
        },
      ),
    );
  }
}
