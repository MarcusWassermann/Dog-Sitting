import 'package:dogs_sitting/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Testing if HomeScreen increments counter',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify that our counter starts at 0.
    expect(find.text('Dog Sitting'),
        findsOneWidget); // Ändere 'Dog Sitting' zu dem Text, den dein HomeScreen anzeigt
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    // Falls dein HomeScreen ein Widget mit einem '+'-Symbol hat, füge hier entsprechenden Code zum Tappen hinzu

    // Verify that our counter has incremented.
    expect(find.text('Dog Sitting'), findsOneWidget);
    // Ersetze 'Dog Sitting' durch den Text, der auf deinem HomeScreen angezeigt wird, nachdem das Widget getappt wurde
  });
}
