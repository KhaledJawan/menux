import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:menux/app.dart';

void main() {
  testWidgets('App boots to the Login screen when signed out', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MenuxApp()));
    await tester.pumpAndSettle();

    expect(find.text('Menux'), findsWidgets);
    expect(find.text('Sign In'), findsWidgets);
  });
}
