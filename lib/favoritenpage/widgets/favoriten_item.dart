import 'package:flutter/material.dart';
import 'package:dogs_sitting/models/user_profile.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';
import 'package:dogs_sitting/provider/profile_favoriten_provider.dart';

class FavoriteListItem extends StatelessWidget {
  final dynamic favorite;

  const FavoriteListItem({Key? key, required this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final profileFavoriteProvider =
        Provider.of<ProfileFavoriteProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 197, 186, 186).withOpacity(0.7),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30,
              child: Icon(Icons.person, size: 30, color: Colors.black),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (favorite is UserProfile)
                    Text(
                      favorite.username ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  if (favorite is UserText)
                    Text(
                      favorite.enteredText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  if (favorite is UserProfile)
                    Text(
                      'Postleitzahl: ${favorite.zipCode ?? ''}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  if (favorite is UserText)
                    Text(
                      'Postleitzahl: ${favorite.postcode}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  if (favorite is UserProfile &&
                      favorite.additionalInfo !=
                          null) // Nur wenn es zusätzliche Informationen gibt
                    Text(
                      '${favorite.additionalInfo}', // Zeige die zusätzlichen Informationen an
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: () {
                if (favorite is UserProfile) {
                  profileFavoriteProvider.removeFromFavorites(favorite);
                } else if (favorite is UserText) {
                  favoriteProvider.removeFromFavorites(favorite);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
