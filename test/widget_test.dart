import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:splitease/main.dart';

void main() {
  testWidgets('SplitEase renders in Mobile Portrait mode', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const SplitEaseApp());

    expect(find.text('SplitEase'), findsOneWidget);
    expect(find.text('Good afternoon, Sneha!'), findsOneWidget);
    expect(find.text('Your Groups'), findsOneWidget);
    expect(find.text('Goa Trip'), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('SplitEase renders in Mobile Landscape mode', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(844, 390);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const SplitEaseApp());

    expect(find.text('Good afternoon, Sneha!'), findsOneWidget);
    expect(find.text('Your Groups'), findsOneWidget);
  });

  testWidgets('SplitEase renders in Tablet mode', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const SplitEaseApp());

    expect(find.text('SplitEase'), findsOneWidget);
    expect(find.text('Good afternoon, Sneha!'), findsOneWidget);
    expect(find.text('Recent Activity'), findsOneWidget);
  });

  testWidgets('SplitEase renders in Desktop mode with NavigationRail', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const SplitEaseApp());

    expect(find.text('SplitEase Dashboard'), findsOneWidget);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Good afternoon, Sneha!'), findsOneWidget);
  });
}
