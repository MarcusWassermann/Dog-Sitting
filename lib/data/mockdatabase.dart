import 'dart:math';

class User {
  final String username;
  final String firstName;
  final String lastName;
  final int age;
  final String email;
  final String phoneNumber;

  User({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
    required this.phoneNumber,
  });

  factory User.generate() {
    // Liste von deutschen Vornamen und Nachnamen
    List<String> firstNames = [
      'Max',
      'Anna',
      'Hannes',
      'Sophie',
      'Lukas',
      'Lea',
      'Leon',
      'Mia'
    ];
    List<String> lastNames = [
      'Müller',
      'Schmidt',
      'Schneider',
      'Fischer',
      'Weber',
      'Meyer',
      'Wagner',
      'Becker'
    ];

    // Zufällige Auswahl eines Vornamens und Nachnamens
    String firstName = firstNames[Random().nextInt(firstNames.length)];
    String lastName = lastNames[Random().nextInt(lastNames.length)];

    // Zufällige Auswahl eines Benutzernamens basierend auf Vor- und Nachnamen
    String username = '${firstName.toLowerCase()}_${lastName.toLowerCase()}';

    // Zufällige Auswahl eines Alters zwischen 18 und 60
    int age = 18 + Random().nextInt(43);

    // Generiere eine zufällige E-Mail-Adresse und Telefonnummer (als Platzhalter)
    String email = '$username@example.com';
    String phoneNumber =
        '+49 ${Random().nextInt(10000000000).toString().padLeft(10, '0')}';

    return User(
      username: username,
      firstName: firstName,
      lastName: lastName,
      age: age,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
