import 'package:dogs_sitting/adventisement/advertisement_form.dart';
import 'package:flutter/material.dart';

class AdvertisementPage extends StatelessWidget {
  const AdvertisementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advertisement Page'),
      ),
      body: AdvertisementForm(
        postcodeEditingController: TextEditingController(),
      ),
    );
  }
}
