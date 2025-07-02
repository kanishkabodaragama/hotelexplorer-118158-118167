import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_listing_frontend/main.dart';

void main() {
  testWidgets('Hotel Explorer app loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const HotelExplorerApp());

    expect(find.text('Hotels'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('Bottom navigation works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const HotelExplorerApp());

    // Test that all navigation items are present
    expect(find.text('Hotels'), findsOneWidget);
    expect(find.text('Map'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Test navigation to Map screen
    await tester.tap(find.text('Map'));
    await tester.pumpAndSettle();
    expect(find.text('Interactive Map'), findsOneWidget);

    // Test navigation to Favorites screen
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();
    expect(find.text('No Favorites Yet'), findsOneWidget);

    // Test navigation to Profile screen
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Guest User'), findsOneWidget);
  });
}
