import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/models/user_profile.dart';
import 'package:dogs_sitting/provider/profile_favoriten_provider.dart';

class ProfileListItem extends StatelessWidget {
  final UserProfile profile;
  final bool isFavorite;

  const ProfileListItem({
    super.key,
    required this.profile,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
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
                  Text(
                    profile.username ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    profile.zipCode ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    profile.additionalInfo ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
              ),
              onPressed: () {
                final provider = Provider.of<ProfileFavoriteProvider>(context,
                    listen: false);
                if (isFavorite) {
                  provider.removeFromFavorites(profile);
                } else {
                  provider.addToFavorites(profile);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
