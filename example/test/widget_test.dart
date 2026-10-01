import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('ShowcaseApp renders and switches tabs smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ShowcaseApp());
    await tester.pump(const Duration(milliseconds: 300));

    // Verify title and overview content
    expect(find.text('Adaptive UI Pro'), findsWidgets);
    expect(find.text('flutter_adaptive_ui_pro'), findsOneWidget);

    // Switch to Buttons tab
    await tester.tap(find.text('Buttons'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Button System Variants'), findsOneWidget);

    // Switch to Forms tab
    await tester.tap(find.text('Forms'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Adaptive Inputs & Form Validation'), findsOneWidget);

    // Switch to Controls tab
    await tester.tap(find.text('Controls'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Selection Controls & Sliders'), findsOneWidget);

    // Switch to Overlays tab
    await tester.tap(find.text('Overlays'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Dialogs, Sheets & Pickers'), findsOneWidget);
  });
}
