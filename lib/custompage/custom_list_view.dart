// ignore_for_file: collection_methods_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter_dog/provider/favoriten_provider.dart';
import 'package:flutter_dog/provider/user_text_provider.dart';
import 'package:flutter_dog/models/user_text.dart';
import 'package:provider/provider.dart';

class CustomListViewScreen extends StatelessWidget {
  const CustomListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserText> userTexts =
        Provider.of<UserTextProvider>(context).userTexts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom ListView'),
      ),
      body: ListView.separated(
        itemCount: userTexts.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 16),
        itemBuilder: (BuildContext context, int index) {
          final UserText userText = userTexts[index];
          if (userText.text.isNotEmpty) {
            return CustomListItem(userText: userText);
          } else {
            return const SizedBox.shrink(); //  leere Anzeigen nicht anzeigen
          }
        },
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  final UserText userText;

  const CustomListItem({super.key, required this.userText});

  @override
  Widget build(BuildContext context) {
    final bool isFavorite =
        Provider.of<FavoriteProvider>(context).favorites.contains(userText);

    return Container(
      height: 100,
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 80,
            height: 80,
            color: Colors.blue,
            child: userText.imagePath != null
                ? Image.asset(userText.imagePath!, fit: BoxFit.cover)
                : null,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(userText.text),
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              final FavoriteProvider favoriteProvider =
                  Provider.of<FavoriteProvider>(context, listen: false);
              if (isFavorite) {
                favoriteProvider.removeFromFavorites(userText as String);
              } else {
                favoriteProvider.addToFavorites(userText as String);
              }
            },
          ),
        ],
      ),
    );
  }
}
