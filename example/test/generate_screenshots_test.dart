import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:example/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> captureScreen({
    required WidgetTester tester,
    required String path,
    required Widget widget,
    Size size = const Size(390, 844),
  }) async {
    tester.view.physicalSize = Size(size.width * 2.0, size.height * 2.0);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final GlobalKey boundaryKey = GlobalKey();

    await tester.pumpWidget(
      RepaintBoundary(
        key: boundaryKey,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: widget,
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

  group('Capture Android Material Screenshots', () {
    testWidgets('android_home', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/android/home.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.material,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true, brightness: Brightness.light, platform: TargetPlatform.android),
            home: ShowcaseHome(
              currentPlatform: AdaptivePlatform.material,
              isDarkMode: false,
              onPlatformChanged: (_) {},
              onToggleDarkMode: () {},
            ),
          ),
        ),
      );
    });

    testWidgets('android_buttons', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/android/buttons.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.material,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true, platform: TargetPlatform.android),
            home: AdaptiveScaffold(
              appBar: const AdaptiveAppBar(titleText: 'Buttons — Material 3'),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AdaptiveButton.filled(
                      label: 'Primary Action',
                      icon: const Icon(Icons.check),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    AdaptiveButton.tonal(
                      label: 'Tonal Action',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    AdaptiveButton.elevated(
                      label: 'Elevated Action',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    AdaptiveButton.outlined(
                      label: 'Outlined Action',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    AdaptiveButton.text(
                      label: 'Text Action',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        AdaptiveIconButton(icon: const Icon(Icons.thumb_up), onPressed: () {}),
                        AdaptiveIconButton(icon: const Icon(Icons.share), onPressed: () {}),
                        AdaptiveFloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('android_forms', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/android/forms.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.material,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true, platform: TargetPlatform.android),
            home: AdaptiveScaffold(
              appBar: const AdaptiveAppBar(titleText: 'Forms — Material 3'),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    AdaptiveTextField(
                      label: 'Username',
                      placeholder: 'john_doe',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 16),
                    AdaptiveTextFormField(
                      label: 'Email',
                      placeholder: 'user@example.com',
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 16),
                    const AdaptivePasswordField(
                      label: 'Password',
                      placeholder: '••••••••',
                    ),
                    const SizedBox(height: 16),
                    const AdaptiveSearchField(placeholder: 'Search resources...'),
                    const SizedBox(height: 24),
                    AdaptiveButton.filled(
                      label: 'Submit Form',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('android_dialogs', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/android/dialogs.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.material,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true, platform: TargetPlatform.android),
            home: AdaptiveScaffold(
              appBar: const AdaptiveAppBar(titleText: 'Dialogs — Material'),
              body: Center(
                child: AdaptiveAlertDialog(
                  title: const Text('Discard Changes?'),
                  content: const Text('You have unsaved changes that will be lost.'),
                  actions: <AdaptiveDialogAction<dynamic>>[
                    const AdaptiveDialogAction<void>(title: 'Cancel'),
                    AdaptiveDialogAction<void>(title: 'Discard', isDestructiveAction: true, onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('android_pickers', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/android/pickers.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.material,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true, platform: TargetPlatform.android),
            home: AdaptiveScaffold(
              appBar: const AdaptiveAppBar(titleText: 'Pickers & Controls'),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    AdaptiveSwitchListTile(
                      title: const Text('Dark Mode Preference'),
                      value: true,
                      onChanged: (_) {},
                    ),
                    AdaptiveCheckboxListTile(
                      title: const Text('Auto-save documents'),
                      value: true,
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: 16),
                    AdaptiveSegmentedControl<int>(
                      groupValue: 1,
                      onValueChanged: (_) {},
                      children: const <int, Widget>{
                        0: Text('Day'),
                        1: Text('Week'),
                        2: Text('Month'),
                      },
                    ),
                    const SizedBox(height: 20),
                    AdaptiveSlider(value: 0.7, onChanged: (_) {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('android_navigation', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/android/navigation.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.material,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true, platform: TargetPlatform.android),
            home: AdaptiveScaffold(
              appBar: const AdaptiveAppBar(
                titleText: 'Material Navigation',
                leading: Icon(Icons.menu),
                actions: <Widget>[Icon(Icons.more_vert)],
              ),
              bottomNavigationBar: AdaptiveBottomNavigationBar(
                currentIndex: 0,
                onTap: (_) {},
                items: const <AdaptiveNavigationItem>[
                  AdaptiveNavigationItem(icon: Icon(Icons.home), label: 'Home'),
                  AdaptiveNavigationItem(icon: Icon(Icons.search), label: 'Search'),
                  AdaptiveNavigationItem(icon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
              body: const Center(child: Text('Material Scaffold & Navigation')),
            ),
          ),
        ),
      );
    });
  });

  group('Capture iOS Cupertino Screenshots', () {
    final AdaptiveThemeData iosTheme = AdaptiveThemeData.light(platform: AdaptivePlatform.cupertino);

    testWidgets('ios_home', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/ios/home.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.cupertino,
          child: AdaptiveTheme(
            data: iosTheme,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: iosTheme.materialTheme,
              home: ShowcaseHome(
                currentPlatform: AdaptivePlatform.cupertino,
                isDarkMode: false,
                onPlatformChanged: (_) {},
                onToggleDarkMode: () {},
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('ios_buttons', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/ios/buttons.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.cupertino,
          child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: AdaptiveScaffold(
              appBar: const AdaptiveAppBar(titleText: 'Buttons — Cupertino'),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AdaptiveButton.filled(
                      label: 'Cupertino Primary',
                      icon: const Icon(CupertinoIcons.check_mark, size: 18),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    AdaptiveButton.tonal(
                      label: 'Cupertino Tonal',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    AdaptiveButton.outlined(
                      label: 'Cupertino Bordered',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    AdaptiveButton.text(
                      label: 'Cupertino Plain',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        AdaptiveIconButton(icon: const Icon(CupertinoIcons.heart_fill), onPressed: () {}),
                        AdaptiveIconButton(icon: const Icon(CupertinoIcons.share), onPressed: () {}),
                        AdaptiveFloatingActionButton(
                          onPressed: () {},
                          child: const Icon(CupertinoIcons.plus),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('ios_forms', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/ios/forms.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.cupertino,
          child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: AdaptiveScaffold(
              appBar: const AdaptiveAppBar(titleText: 'Forms — iOS HIG'),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    AdaptiveFormSection(
                      header: const Text('Account Details'),
                      children: <Widget>[
                        AdaptiveFormRow(
                          prefix: const Text('Name'),
                          child: AdaptiveTextField(placeholder: 'Jane Doe'),
                        ),
                        AdaptiveFormRow(
                          prefix: const Text('Email'),
                          child: AdaptiveTextField(placeholder: 'jane@apple.com'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const AdaptiveSearchField(placeholder: 'Search contacts...'),
                    const SizedBox(height: 24),
                    AdaptiveButton.filled(
                      label: 'Continue',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('ios_dialogs', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/ios/dialogs.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.cupertino,
          child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: AdaptiveScaffold(
              appBar: const AdaptiveAppBar(titleText: 'Alerts — Cupertino'),
              body: Center(
                child: AdaptiveAlertDialog(
                  title: const Text('Delete Account?'),
                  content: const Text('This action will permanently delete all cloud data.'),
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
          ),
        ),
      );
    });

    testWidgets('ios_pickers', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/ios/pickers.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.cupertino,
          child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: AdaptiveScaffold(
              appBar: const AdaptiveAppBar(titleText: 'Pickers — Cupertino'),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    AdaptiveSwitchListTile(
                      title: const Text('iCloud Sync'),
                      value: true,
                      onChanged: (_) {},
                    ),
                    AdaptiveCheckboxListTile(
                      title: const Text('Notify via Push'),
                      value: true,
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: 16),
                    AdaptiveSegmentedControl<int>(
                      groupValue: 0,
                      onValueChanged: (_) {},
                      children: const <int, Widget>{
                        0: Text('Day'),
                        1: Text('Week'),
                        2: Text('Month'),
                      },
                    ),
                    const SizedBox(height: 20),
                    AdaptiveSlider(value: 0.8, onChanged: (_) {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('ios_navigation', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        path: '../screenshots/ios/navigation.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.cupertino,
          child: CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: AdaptiveScaffold(
              appBar: const AdaptiveAppBar(
                titleText: 'Cupertino Navigation',
                leading: Icon(CupertinoIcons.back),
                actions: <Widget>[Icon(CupertinoIcons.ellipsis_circle)],
              ),
              bottomNavigationBar: AdaptiveBottomNavigationBar(
                currentIndex: 0,
                onTap: (_) {},
                items: const <AdaptiveNavigationItem>[
                  AdaptiveNavigationItem(icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
                  AdaptiveNavigationItem(icon: Icon(CupertinoIcons.search), label: 'Search'),
                  AdaptiveNavigationItem(icon: Icon(CupertinoIcons.person_fill), label: 'Profile'),
                ],
              ),
              body: const Center(child: Text('Cupertino Navigation Bar & Tab Bar')),
            ),
          ),
        ),
      );
    });
  });

  group('Capture Web Desktop Screenshots', () {
    testWidgets('web_home', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        size: const Size(1024, 768),
        path: '../screenshots/web/home.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.material,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true),
            home: ShowcaseHome(
              currentPlatform: AdaptivePlatform.material,
              isDarkMode: false,
              onPlatformChanged: (_) {},
              onToggleDarkMode: () {},
            ),
          ),
        ),
      );
    });

    testWidgets('web_showcase', (WidgetTester tester) async {
      await captureScreen(
        tester: tester,
        size: const Size(1280, 800),
        path: '../screenshots/web/showcase.png',
        widget: AdaptiveConfig(
          platform: AdaptivePlatform.material,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true),
            home: ShowcaseHome(
              currentPlatform: AdaptivePlatform.material,
              isDarkMode: false,
              onPlatformChanged: (_) {},
              onToggleDarkMode: () {},
            ),
          ),
        ),
      );
    });
  });
}
