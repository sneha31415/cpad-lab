import 'package:flutter_test/flutter_test.dart';

import 'package:splitease/main.dart';

void main() {
  testWidgets('SplitEase dashboard loads', (WidgetTester tester) async {
    await tester.pumpWidget(const SplitEaseApp());

    expect(find.text('SplitEase'), findsOneWidget);
    expect(find.text('Good afternoon, Sneha!'), findsOneWidget);
    expect(find.text('Your Groups'), findsOneWidget);
    expect(find.text('Goa Trip'), findsOneWidget);
  });
}
