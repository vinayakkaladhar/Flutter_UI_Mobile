import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uitest/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Future<void> pumpUntilFound(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    bool timerDone = false;
    final timer = Timer(timeout, () => timerDone = true);
    while (timerDone != true) {
      await tester.pump();

      final found = tester.any(finder);
      if (found) {
        timerDone = true;
      }
    }
    timer.cancel();
  }

  testWidgets("forgot password", (WidgetTester tester) async {
    print("== Test Started ==");
    app.main();
    await tester.pump();
    await tester.tap(find.byKey(const Key("LoginButton")));
    await pumpUntilFound(tester, find.text("Forgot Password"));
    await tester.tap(find.text("Forgot Password"));
    await tester.pumpAndSettle();
    await pumpUntilFound(tester, find.text("Forget Password Page"));
    final emailField = find.ancestor(
      of: find.text('Email'),
      matching: find.byType(TextField),
    );
    await tester.tap(emailField);
    final emailenterField = find.ancestor(
      of: find.textContaining('Enter valid email id as abc@gmail.com'),
      matching: find.byType(TextField),
    );
    await tester.enterText(emailenterField, 'vinayak@mailinator.com');
    expect(find.text('vinayak@mailinator.com'), findsOneWidget);
    print("== Test Ended ==");
  });
}
