// ignore_for_file: collection_methods_unrelated_type

import 'package:flutter/material.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            onPressed: () async {
              final FavoriteProvider favoriteProvider =
                  Provider.of<FavoriteProvider>(context, listen: false);
              final FirebaseFirestore firestore = FirebaseFirestore.instance;
              final CollectionReference favorites =
                  firestore.collection('favorites');

              if (isFavorite) {
                // Remove from favorites
                await favorites.doc(userText.id).delete();
                favoriteProvider.removeFromFavorites(userText.text);
              } else {
                // Add to favorites
                await favorites.doc(userText.id).set({'text': userText.text});
                favoriteProvider.addToFavorites(userText.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
