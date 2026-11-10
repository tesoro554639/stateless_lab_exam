import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stateless_lab_exam/main.dart';

void main() {
  testWidgets('Shopping cart page renders all components and callbacks', (
    WidgetTester tester,
  ) async {
    // Set viewport height to fit entire page comfortably
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    // 1. Check AppBar
    expect(find.text('My Cart'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    expect(find.text('3'), findsOneWidget);

    // 2. Check Intro
    expect(find.text('CAMPUS STORE'), findsOneWidget);
    expect(find.text('Ready for checkout'), findsOneWidget);
    expect(
      find.text('Review your items before placing your order.'),
      findsOneWidget,
    );

    // 3. Check Delivery Card
    expect(find.textContaining('Deliver to'), findsOneWidget);
    expect(find.text('Matina, Davao City'), findsOneWidget);
    expect(find.text('Change'), findsOneWidget);

    // 4. Check Order Items
    expect(find.text('Order Items'), findsOneWidget);
    expect(find.text('3 items'), findsOneWidget);
    expect(find.text('Wireless Mouse'), findsOneWidget);
    expect(find.text('PHP 450.00'), findsOneWidget);
    expect(find.text('USB-C Hub'), findsOneWidget);
    expect(find.text('PHP 850.00'), findsOneWidget);
    expect(find.text('Laptop Stand'), findsOneWidget);
    expect(find.text('PHP 700.00'), findsOneWidget);

    // 5. Check Discount Banner
    expect(find.text('STUDENT10 applied'), findsOneWidget);
    expect(find.text('10% discount on items'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);

    // 6. Check Payment Summary
    expect(find.text('Payment Summary'), findsOneWidget);
    expect(find.text('Subtotal'), findsOneWidget);
    expect(find.text('PHP 2,000.00'), findsOneWidget);
    expect(find.text('Discount (10%)'), findsOneWidget);
    expect(find.text('- PHP 200.00'), findsOneWidget);
    expect(find.text('Delivery Fee'), findsOneWidget);
    expect(find.text('PHP 50.00'), findsOneWidget);
    expect(find.text('Total'), findsOneWidget);
    expect(find.text('PHP 1,850.00'), findsOneWidget);

    // 7. Check Place Order Button
    expect(find.text('Place Order'), findsOneWidget);

    // Test all required button callbacks
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
    await tester.tap(find.text('Change'));

    // Test product buttons: Minus, Plus, and Delete
    final plusButtons = find.byIcon(Icons.add);
    final minusButtons = find.byIcon(Icons.remove);
    final deleteButtons = find.byIcon(Icons.delete_outline);

    expect(plusButtons, findsNWidgets(3));
    expect(minusButtons, findsNWidgets(3));
    expect(deleteButtons, findsNWidgets(3));

    // Tap first item buttons (Wireless Mouse)
    await tester.tap(plusButtons.first);
    await tester.tap(minusButtons.first);
    await tester.tap(deleteButtons.first);

    // Tap place order button
    await tester.tap(find.text('Place Order'));

    await tester.pump();
  });
}
