import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/pages/current_session_page.dart';

void main() {
  testWidgets('current_session_page test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new CurrentSessionPage())
    );
    await tester.pumpWidget(testWidget);
  });
}