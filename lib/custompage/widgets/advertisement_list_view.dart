import 'package:flutter/material.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';

class AdvertisementListView extends StatelessWidget {
  final List<UserText> advertisements;

  const AdvertisementListView({super.key, required this.advertisements});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/2.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned.fill(
          child: advertisements.isEmpty
              ? const Center(
                  child: Text(
                    'Geben Sie eine Postleitzahl ein',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                )
              : Column(
                  children: [
                    const Divider(
                      color: Color.fromARGB(255, 6, 6, 6),
                      thickness: 4.0,
                      height: 6.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: advertisements.length,
                        itemBuilder: (context, index) {
                          UserText advertisement = advertisements[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  advertisement.imagePath != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            advertisement.imagePath!,
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: const Icon(
                                            Icons.image,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          advertisement.enteredText,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          'Postleitzahl: ${advertisement.postcode}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Consumer<FavoriteProvider>(
                                    builder: (context, favoriteProvider, _) {
                                      return IconButton(
                                        icon: Icon(
                                          favoriteProvider
                                                  .isFavorite(advertisement)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: favoriteProvider
                                                  .isFavorite(advertisement)
                                              ? Colors.red
                                              : null,
                                        ),
                                        onPressed: () {
                                          if (favoriteProvider
                                              .isFavorite(advertisement)) {
                                            favoriteProvider
                                                .removeFromFavorites(
                                                    advertisement);
                                          } else {
                                            favoriteProvider
                                                .addToFavorites(advertisement);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
