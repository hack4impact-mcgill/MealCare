import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/pages/login_page.dart';

void main() {
  testWidgets('food_item_page test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new LoginPage())
    );
    await tester.pumpWidget(testWidget);
  });
}