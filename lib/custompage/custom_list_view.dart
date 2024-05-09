import 'package:dogs_sitting/models/user_text.dart';
import 'package:dogs_sitting/provider/user_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';

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
            return const SizedBox.shrink(); // Leere Anzeigen nicht anzeigen
          }
        },
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  final UserText userText;

  const CustomListItem({super.key,required this.userText});

  @override
  Widget build(BuildContext context) {
    final bool isFavorite =
        Provider.of<FavoriteProvider>(context).isFavorite(userText);

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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                userText.text,
                overflow: TextOverflow.ellipsis,
                maxLines: 3, // Zeige maximal 3 Zeilen Text an
              ),
            ),
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
                favoriteProvider.removeFromFavorites(userText);
              } else {
                favoriteProvider.addToFavorites(userText);
              }
            },
          ),
        ],
      ),
    );
  }
}
