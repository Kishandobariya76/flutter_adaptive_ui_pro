import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> captureWidget({
    required WidgetTester tester,
    required String path,
    required Widget widget,
    Size size = const Size(960, 560),
  }) async {
    tester.view.physicalSize = Size(size.width * 2.0, size.height * 2.0);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final GlobalKey boundaryKey = GlobalKey();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: RepaintBoundary(
          key: boundaryKey,
          child: Container(
            width: size.width,
            height: size.height,
            color: const Color(0xFFF1F5F9), // Light modern canvas backdrop
            padding: const EdgeInsets.all(16),
            child: widget,
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    await tester.runAsync(() async {
      final RenderRepaintBoundary boundary =
          boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      final File file = File(path);
      file.parent.createSync(recursive: true);
      file.writeAsBytesSync(pngBytes);
    });
  }

  Widget buildComparisonFrame({
    required String title,
    required String subtitle,
    required Widget androidContent,
    required Widget iosContent,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1.5)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'flutter_adaptive_ui_pro',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Comparison Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Android Column
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: const <Widget>[
                              Icon(Icons.android, color: Color(0xFF10B981), size: 18),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Android (Material Design 3)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 20),
                          Expanded(
                            child: AdaptiveConfig(
                              platform: AdaptivePlatform.material,
                              child: MaterialApp(
                                debugShowCheckedModeBanner: false,
                                theme: ThemeData(
                                  useMaterial3: true,
                                  brightness: Brightness.light,
                                  colorSchemeSeed: Colors.indigo,
                                ),
                                home: Material(color: Colors.transparent, child: androidContent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // iOS Column
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: const <Widget>[
                              Icon(Icons.apple, color: Color(0xFF0F172A), size: 18),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'iOS (Cupertino HIG)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 20),
                          Expanded(
                            child: AdaptiveConfig(
                              platform: AdaptivePlatform.cupertino,
                              child: CupertinoApp(
                                debugShowCheckedModeBanner: false,
                                theme: const CupertinoThemeData(
                                  brightness: Brightness.light,
                                  primaryColor: CupertinoColors.systemBlue,
                                ),
                                home: Material(color: Colors.transparent, child: iosContent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  group('Generate Rich Widget Screenshots for README', () {
    // 1. Buttons
    testWidgets('widget_buttons', (WidgetTester tester) async {
      await captureWidget(
        tester: tester,
        path: '/Volumes/MiniPart/Development/FlutterPackages/flutter_adaptive_ui_pro/screenshots/widgets/buttons.png',
        widget: buildComparisonFrame(
          title: 'AdaptiveButton System',
          subtitle: 'Automatic rendering of Material 3 and Cupertino button styles',
          androidContent: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AdaptiveButton.filled(label: 'Filled Button', icon: const Icon(Icons.check), onPressed: () {}),
                  const SizedBox(height: 8),
                  AdaptiveButton.tonal(label: 'Tonal Button', onPressed: () {}),
                  const SizedBox(height: 8),
                  AdaptiveButton.elevated(label: 'Elevated Button', onPressed: () {}),
                  const SizedBox(height: 8),
                  AdaptiveButton.outlined(label: 'Outlined Button', onPressed: () {}),
                  const SizedBox(height: 8),
                  AdaptiveButton.text(label: 'Text Button', onPressed: () {}),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AdaptiveIconButton(icon: const Icon(Icons.favorite), onPressed: () {}),
                      AdaptiveIconButton(icon: const Icon(Icons.share), onPressed: () {}),
                      AdaptiveFloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          iosContent: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AdaptiveButton.filled(
                    label: 'Filled Button',
                    icon: const Icon(CupertinoIcons.check_mark, size: 16),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 8),
                  AdaptiveButton.tonal(label: 'Tonal Button', onPressed: () {}),
                  const SizedBox(height: 8),
                  AdaptiveButton.elevated(label: 'Elevated Button', onPressed: () {}),
                  const SizedBox(height: 8),
                  AdaptiveButton.outlined(label: 'Outlined Button', onPressed: () {}),
                  const SizedBox(height: 8),
                  AdaptiveButton.text(label: 'Text Button', onPressed: () {}),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      AdaptiveIconButton(icon: const Icon(CupertinoIcons.heart_fill), onPressed: () {}),
                      AdaptiveIconButton(icon: const Icon(CupertinoIcons.share), onPressed: () {}),
                      AdaptiveFloatingActionButton(
                        onPressed: () {},
                        child: const Icon(CupertinoIcons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });

    // 2. Alert Dialogs
    testWidgets('widget_dialogs', (WidgetTester tester) async {
      await captureWidget(
        tester: tester,
        path: '/Volumes/MiniPart/Development/FlutterPackages/flutter_adaptive_ui_pro/screenshots/widgets/dialogs.png',
        widget: buildComparisonFrame(
          title: 'AdaptiveDialog System',
          subtitle: 'Native Material 3 AlertDialog vs authentic iOS CupertinoAlertDialog',
          androidContent: Center(
            child: AdaptiveAlertDialog(
              title: const Text('Delete Document?'),
              content: const Text('This action cannot be undone and will permanently remove your file.'),
              actions: <AdaptiveDialogAction<dynamic>>[
                const AdaptiveDialogAction<void>(title: 'Cancel'),
                AdaptiveDialogAction<void>(
                  title: 'Delete',
                  isDestructiveAction: true,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          iosContent: Center(
            child: AdaptiveAlertDialog(
              title: const Text('Delete Document?'),
              content: const Text('This action cannot be undone and will permanently remove your file.'),
              actions: <AdaptiveDialogAction<dynamic>>[
                const AdaptiveDialogAction<void>(title: 'Cancel'),
                AdaptiveDialogAction<void>(
                  title: 'Delete',
                  isDestructiveAction: true,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );
    });

    // 3. Selection Controls
    testWidgets('widget_controls', (WidgetTester tester) async {
      await captureWidget(
        tester: tester,
        path: '/Volumes/MiniPart/Development/FlutterPackages/flutter_adaptive_ui_pro/screenshots/widgets/controls.png',
        widget: buildComparisonFrame(
          title: 'Adaptive Selection Controls',
          subtitle: 'Native Switch, Checkbox, Slider, and Segmented controls',
          androidContent: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AdaptiveSwitchListTile(
                    title: const Text('Enable Notifications'),
                    subtitle: const Text('Sound and banner alerts'),
                    value: true,
                    onChanged: (_) {},
                  ),
                  AdaptiveCheckboxListTile(
                    title: const Text('Sync with Cloud'),
                    value: true,
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 12),
                  AdaptiveSegmentedControl<int>(
                    groupValue: 1,
                    onValueChanged: (_) {},
                    children: const <int, Widget>{
                      0: Text('Day'),
                      1: Text('Week'),
                      2: Text('Month'),
                    },
                  ),
                  const SizedBox(height: 16),
                  AdaptiveSlider(value: 0.7, onChanged: (_) {}),
                ],
              ),
            ),
          ),
          iosContent: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AdaptiveSwitchListTile(
                    title: const Text('Enable Notifications'),
                    subtitle: const Text('Sound and banner alerts'),
                    value: true,
                    onChanged: (_) {},
                  ),
                  AdaptiveCheckboxListTile(
                    title: const Text('Sync with Cloud'),
                    value: true,
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 12),
                  AdaptiveSegmentedControl<int>(
                    groupValue: 1,
                    onValueChanged: (_) {},
                    children: const <int, Widget>{
                      0: Text('Day'),
                      1: Text('Week'),
                      2: Text('Month'),
                    },
                  ),
                  const SizedBox(height: 16),
                  AdaptiveSlider(value: 0.7, onChanged: (_) {}),
                ],
              ),
            ),
          ),
        ),
      );
    });

    // 4. Forms and Text Fields
    testWidgets('widget_forms', (WidgetTester tester) async {
      await captureWidget(
        tester: tester,
        path: '/Volumes/MiniPart/Development/FlutterPackages/flutter_adaptive_ui_pro/screenshots/widgets/forms.png',
        widget: buildComparisonFrame(
          title: 'Adaptive Text Fields & Forms',
          subtitle: 'Material 3 input decorations vs iOS grouped inset form rows',
          androidContent: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AdaptiveTextField(
                    label: 'Full Name',
                    placeholder: 'John Doe',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  const SizedBox(height: 12),
                  const AdaptivePasswordField(
                    label: 'Password',
                    placeholder: '••••••••',
                  ),
                  const SizedBox(height: 12),
                  const AdaptiveSearchField(placeholder: 'Search files...'),
                  const SizedBox(height: 16),
                  AdaptiveButton.filled(label: 'Continue', onPressed: () {}),
                ],
              ),
            ),
          ),
          iosContent: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AdaptiveFormSection(
                    header: const Text('USER PROFILE'),
                    children: <Widget>[
                      AdaptiveFormRow(
                        prefix: const Text('Name'),
                        child: AdaptiveTextField(placeholder: 'Jane Doe'),
                      ),
                      AdaptiveFormRow(
                        prefix: const Text('Secret'),
                        child: const AdaptivePasswordField(placeholder: '••••••••'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const AdaptiveSearchField(placeholder: 'Search files...'),
                  const SizedBox(height: 16),
                  AdaptiveButton.filled(label: 'Continue', onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
      );
    });

    // 5. Navigation & Tabs
    testWidgets('widget_navigation', (WidgetTester tester) async {
      await captureWidget(
        tester: tester,
        path: '/Volumes/MiniPart/Development/FlutterPackages/flutter_adaptive_ui_pro/screenshots/widgets/navigation.png',
        widget: buildComparisonFrame(
          title: 'Adaptive Navigation & Scaffolding',
          subtitle: 'Material 3 NavigationBar pills vs Cupertino Navigation & Tab Bar',
          androidContent: Column(
            children: <Widget>[
              const AdaptiveAppBar(
                titleText: 'Explore',
                leading: Icon(Icons.menu),
                actions: <Widget>[Icon(Icons.more_vert)],
              ),
              const Expanded(
                child: Center(child: Text('Material Scaffold Canvas')),
              ),
              AdaptiveBottomNavigationBar(
                currentIndex: 0,
                onTap: (_) {},
                items: const <AdaptiveNavigationItem>[
                  AdaptiveNavigationItem(icon: Icon(Icons.home), label: 'Home'),
                  AdaptiveNavigationItem(icon: Icon(Icons.explore), label: 'Explore'),
                  AdaptiveNavigationItem(icon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
            ],
          ),
          iosContent: Column(
            children: <Widget>[
              const AdaptiveAppBar(
                titleText: 'Explore',
                leading: Icon(CupertinoIcons.back),
                actions: <Widget>[Icon(CupertinoIcons.ellipsis_circle)],
              ),
              const Expanded(
                child: Center(child: Text('Cupertino Scaffold Canvas')),
              ),
              AdaptiveBottomNavigationBar(
                currentIndex: 0,
                onTap: (_) {},
                items: const <AdaptiveNavigationItem>[
                  AdaptiveNavigationItem(icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
                  AdaptiveNavigationItem(icon: Icon(CupertinoIcons.compass), label: 'Explore'),
                  AdaptiveNavigationItem(icon: Icon(CupertinoIcons.person_fill), label: 'Profile'),
                ],
              ),
            ],
          ),
        ),
      );
    });

    // 6. Action Sheets & Overlays
    testWidgets('widget_sheets', (WidgetTester tester) async {
      await captureWidget(
        tester: tester,
        path: '/Volumes/MiniPart/Development/FlutterPackages/flutter_adaptive_ui_pro/screenshots/widgets/sheets.png',
        widget: buildComparisonFrame(
          title: 'Adaptive Action Sheets & Overlays',
          subtitle: 'Material Modal BottomSheet vs Cupertino ActionSheet with blur',
          androidContent: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(width: 32, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 16),
                  const Text('Options', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  ListTile(leading: const Icon(Icons.share), title: const Text('Share Link'), onTap: () {}),
                  ListTile(leading: const Icon(Icons.copy), title: const Text('Copy to Clipboard'), onTap: () {}),
                  ListTile(leading: const Icon(Icons.delete, color: Colors.red), title: const Text('Delete', style: TextStyle(color: Colors.red)), onTap: () {}),
                ],
              ),
            ),
          ),
          iosContent: Center(
            child: CupertinoActionSheet(
              title: const Text('Document Options'),
              message: const Text('Select an action for this document'),
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(child: const Text('Share Link'), onPressed: () {}),
                CupertinoActionSheetAction(child: const Text('Copy to Clipboard'), onPressed: () {}),
                CupertinoActionSheetAction(isDestructiveAction: true, child: const Text('Delete'), onPressed: () {}),
              ],
              cancelButton: CupertinoActionSheetAction(isDefaultAction: true, child: const Text('Cancel'), onPressed: () {}),
            ),
          ),
        ),
      );
    });
  });
}
