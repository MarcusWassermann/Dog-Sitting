import 'package:dogs_sitting/adventisement/widgets/advertisement_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdvertisementDesign extends StatelessWidget {
  final XFile? image;
  final TextEditingController textEditingController;
  final TextEditingController postcodeEditingController;
  final VoidCallback uploadImage;
  final VoidCallback saveData;

  const AdvertisementDesign({
    super.key,
    required this.image,
    required this.textEditingController,
    required this.postcodeEditingController,
    required this.uploadImage,
    required this.saveData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/1906154.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  buildFormBody(image, textEditingController, uploadImage),
                  const SizedBox(height: 20.0),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.3), // Transparente Füllfarbe
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: postcodeEditingController,
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: Colors.white), // Weiße Schriftfarbe
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Postleitzahl eingeben',
                          labelStyle: TextStyle(
                              color: Colors.white), // Weiße Schriftfarbe
                          counterText: "",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 320.0),
                  ElevatedButton(
                    onPressed: saveData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Daten speichern'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
