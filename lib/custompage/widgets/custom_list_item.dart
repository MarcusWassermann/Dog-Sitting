import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';
import 'package:dogs_sitting/chatpage/chat_screen.dart';

class CustomListItem extends StatelessWidget {
  final UserText userText;

  const CustomListItem({super.key, required this.userText});

  @override
  Widget build(BuildContext context) {
    final bool isFavorite =
        Provider.of<FavoriteProvider>(context).isFavorite(userText);

    return GestureDetector(
      onTap: () {
        // Navigieren Sie zum ChatScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatScreen(userText: userText, chatPartnerName: ''),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
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
                  maxLines: 3,
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
      ),
    );
  }
}
