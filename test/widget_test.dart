import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkedin_clone/main.dart';
import 'package:linkedin_clone/utils/initials.dart';

void main() {
  test('getInitials normalise les noms et les espaces', () {
    expect(getInitials(' Aïssata ', ' Tounkara '), 'AT');
    expect(getInitials('Mamadou', 'Diallo'), 'MD');
    expect(getInitials('Fatou', ''), 'F');
    expect(getInitials('', ''), '?');
  });

  testWidgets('l’écran d’accueil de l’authentification est affiché', (
    tester,
  ) async {
    await tester.pumpWidget(const LinkedInCloneApp());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(
      find.text('Bienvenue dans votre\ncommunauté professionnelle'),
      findsOneWidget,
    );
    expect(find.text('S’identifier'), findsWidgets);
  });

  testWidgets('la connexion redirige vers l’accueil', (tester) async {
    await tester.pumpWidget(const LinkedInCloneApp());
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('S’identifier avec un e-mail'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'test@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'secret');
    await tester.tap(find.text('S’identifier').last);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Commencer un post'), findsOneWidget);
  });
}
