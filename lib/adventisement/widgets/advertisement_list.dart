import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdvertisementList extends StatelessWidget {
  final String postcode;

  const AdvertisementList({super.key, required this.postcode});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('advertisements')
          .where('postcode', isEqualTo: postcode) // Filtern nach Postleitzahl
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Text('Keine Anzeigen gefunden.');
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['enteredText']),
              subtitle: Text(data['postcode']),
              // Hier können Sie weitere Anzeigendetails anzeigen
            );
          }).toList(),
        );
      },
    );
  }
}
