import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogs_sitting/models/user_text.dart';
import 'package:dogs_sitting/provider/user_text_provider.dart';
import 'package:dogs_sitting/provider/favoriten_provider.dart';

class CustomListViewScreen extends StatelessWidget {
  const CustomListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserText> userTexts =
        Provider.of<UserTextProvider>(context).userTexts;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Custom ListView'),
      ),
      body: Stack(
        children: [
          // Hintergrundbild über die ganze Seite
          Image.asset(
            'assets/16868426.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          // ListView mit benutzerdefinierten Listenelementen
          ListView.separated(
            itemCount: userTexts.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 16),
            itemBuilder: (BuildContext context, int index) {
              final UserText userText = userTexts[index];
              if (userText.text.isNotEmpty) {
                return CustomListItem(userText: userText);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
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
    );
  }
}

