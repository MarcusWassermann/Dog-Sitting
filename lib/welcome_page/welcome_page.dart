import 'package:flutter/material.dart';
import 'package:dogs_sitting/my_page/my_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const SizedBox.shrink(), // Titel entfernen
        iconTheme:
            const IconThemeData(color: Colors.black), // Schriftfarbe ändern
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          final velocity = details.primaryVelocity;
          if (velocity != null && velocity < -1000) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyScreen()),
            );
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/20.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          // Hinzugefügt, um den Container mittig zu platzieren
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                0.9, // Breite des Containers festlegen
                            margin: const EdgeInsets.symmetric(
                              vertical:
                                  40.0, // Anpassung der Position des Containers
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                  0.1), // Hellerer Hintergrund des Containers
                              borderRadius: BorderRadius.circular(
                                  20.0), // Abrundung der Ecken
                              border: Border.all(
                                color: const Color.fromARGB(
                                    221, 56, 51, 51), // Farbe des Rahmens
                                width: 8.0, // Breite des Rahmens erhöhen
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0,
                                      4), // Schatten für eine erhöhte Darstellung
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(
                                20.0), // Innenabstand des Containers
                            child: const Text(
                              'In unserer Community geht es um mehr als nur um das Finden eines Hundesitters oder das Anbieten Ihrer Dienste. Hier geht es darum, eine Familie zu finden - eine Familie, die Ihre Liebe zu Hunden versteht und teilt.\n\n'
                              'Ein Teil unserer Familie werden: Treten Sie unserer Gemeinschaft bei und lassen Sie uns gemeinsam für unsere vierbeinigen Freunde da sein. Als Sitter können Sie nicht nur ein Hundesitter sein, sondern auch ein Freund und Vertrauter für die Hunde, die Ihnen anvertraut werden. Sie bringen nicht nur Ihre Zeit und Ihr Können mit, sondern auch Ihr Herz.\n\n'
                              'Den richtigen Begleiter finden: Wenn Sie auf der Suche nach einem Sitter sind, möchten wir Ihnen helfen, die perfekte Ergänzung für Ihre pelzige Familie zu finden. Es geht nicht nur darum, jemanden zu finden, der auf Ihren Hund aufpasst, sondern darum, jemanden zu finden, dem Sie vertrauen können, der sich um Ihr geliebtes Familienmitglied kümmert, als wäre es sein eigenes.\n\n'
                              'Bitte beachten Sie: Dog Sitting ist nicht nur eine Plattform - sie ist ein Zuhause für Hundeliebhaber. Hier geht es darum, Beziehungen aufzubauen, Vertrauen zu schaffen und sich gegenseitig zu unterstützen. Wir möchten, dass Sie sich wie in einer großen, liebevollen Familie fühlen, in der jeder Hund geliebt und geschätzt wird.\n\n'
                              'Tritt heute unserer Familie bei und erlebe die Freude, die entsteht, wenn Menschen und Hunde sich gegenseitig bereichern und unterstützen.',
                              style: TextStyle(
                                color:
                                    Color.fromARGB(255, 221, 225, 229), // Schriftfarbe in Blau ändern
                                fontSize: 18.0,
                                fontWeight:
                                    FontWeight.bold, // Schrift fett machen
                                letterSpacing:
                                    -0.5, // Enge der Schrift anpassen
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
