import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('My Home Page widget', (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtil.pumpWidgetWithShellApp(const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Flutter templates testing'),
        findsOneWidget);
    expect(find.text('This is only for testing'), findsOneWidget);
  });
}
