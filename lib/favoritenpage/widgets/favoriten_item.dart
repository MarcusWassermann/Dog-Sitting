import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';

class FavoriteListItem extends StatelessWidget {
  final UserText favorite;

  const FavoriteListItem({super.key, required this.favorite});

  @override
  Widget build(BuildContext context) {
    final FavoriteProvider favoriteProvider =
        Provider.of<FavoriteProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              color: const Color.fromARGB(255, 94, 101, 106),
              child: favorite.imagePath != null
                  ? Image.asset(
                      favorite.imagePath!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.image,
                      size: 30,
                      color: Colors.white,
                    ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favorite.enteredText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Postleitzahl: ${favorite.postcode}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: () {
                favoriteProvider.removeFromFavorites(favorite);
              },
            ),
          ],
        ),
      ),
    );
  }
}
