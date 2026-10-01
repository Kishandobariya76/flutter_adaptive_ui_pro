# flutter_adaptive_ui_pro

[![pub package](https://img.shields.io/badge/pub.dev-v1.0.1-blue.svg)](https://pub.dev/packages/flutter_adaptive_ui_pro)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.0.0-02569B)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%3E%3D3.0.0-0175C2)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/Kishandobariya76/flutter_adaptive_ui_pro/blob/main/LICENSE)
[![Buy Me a Chai](https://img.shields.io/badge/Buy%20Me%20a%20Chai-ffdd00?style=flat&logo=buy-me-a-coffee&logoColor=black)](https://cdn.jsdelivr.net/gh/Kishandobariya76/flutter_guard@main/support.html)

> **Write once, automatically render platform-appropriate UI.**  
> A lightweight, zero-dependency, production-grade adaptive UI framework for Flutter. Renders native-fidelity **Material Design 3** on Android, Web, and Desktop, and authentic **Cupertino (Apple HIG)** on iOS.

---

## 📖 Table of Contents

- [Why flutter_adaptive_ui_pro?](#-why-flutter_adaptive_ui_pro)
- [Platform Resolution Cascade](#-platform-resolution-cascade)
- [Platform Default Behavior](#-platform-default-behavior)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Comprehensive Widget Guide](#-comprehensive-widget-guide)
  - [1. Buttons](#1-buttons)
  - [2. Text Input & Fields](#2-text-input--fields)
  - [3. Forms & Grouping](#3-forms--grouping)
  - [4. Selection Controls](#4-selection-controls)
  - [5. Dialogs & Modals](#5-dialogs--modals)
  - [6. Bottom Sheets & Action Sheets](#6-bottom-sheets--action-sheets)
  - [7. Pickers & Dates](#7-pickers--dates)
  - [8. Menus & Dropdowns](#8-menus--dropdowns)
  - [9. Navigation & Scaffolding](#9-navigation--scaffolding)
  - [10. Lists & Grouped Sections](#10-lists--grouped-sections)
  - [11. Progress & Loading States](#11-progress--loading-states)
  - [12. Feedback & Notifications](#12-feedback--notifications)
  - [13. Miscellaneous Widgets](#13-miscellaneous-widgets)
- [Adaptive Theming](#-adaptive-theming)
- [Runtime Platform Overrides](#-runtime-platform-overrides)
- [BuildContext Extensions](#-buildcontext-extensions)
- [Accessibility & RTL](#-accessibility--rtl)
- [Contributing](#-contributing)
- [License](#-license)
- [Support](#support)
- [Developer](#developer)

---

## 🎯 Why flutter_adaptive_ui_pro?

Flutter enables building for multiple platforms with a single codebase. However, delivering an authentic platform experience typically requires verbose conditional logic:

```dart
// ❌ Verbose boilerplate platform checks
if (defaultTargetPlatform == TargetPlatform.iOS) {
  return CupertinoButton.filled(child: Text('Save'), onPressed: onSave);
} else {
  return FilledButton(child: Text('Save'), onPressed: onSave);
}
```

With `flutter_adaptive_ui_pro`:

```dart
// ✅ Unified, typed, and automatic
AdaptiveButton.filled(
  label: 'Save',
  onPressed: onSave,
);
```

### Key Highlights
- **No Fake Adaptivity**: iOS renders authentic `Cupertino` widgets (not recolored Material components). Android, Web, and Desktop render native `Material 3` widgets.
- **Zero External Dependencies**: Pure Flutter package built on Flutter's core framework (`Material`, `Cupertino`, `Widgets`). No third-party state managers or platform plugins.
- **Web & Desktop Safe**: Platform detection never imports `dart:io`, ensuring 100% universal compilation across Web, macOS, Windows, Linux, iOS, and Android.
- **Strong Typing & Generics**: Strongly typed dropdowns, radios, segmented controls, dialogs, and sheets.

---

## ⚡ Platform Resolution Cascade

Every adaptive widget resolves whether to render Material or Cupertino using a strict hierarchical cascade:

```text
1. Widget-level override (e.g. AdaptiveButton(platform: AdaptivePlatform.cupertino))
       ↓
2. Scoped AdaptiveConfig (e.g. AdaptiveConfig(platform: ...))
       ↓
3. AdaptiveTheme configuration (AdaptiveTheme.maybeOf(context))
       ↓
4. Flutter environment detection (defaultTargetPlatform)
       ↓
5. Material 3 Fallback
```

---

## 🌐 Platform Default Behavior

| Platform | Default UI | Underlying Flutter Engine |
|---|---|---|
| **Android** | Material 3 | `ThemeData(useMaterial3: true)` |
| **iOS** | Cupertino | Apple Human Interface Guidelines |
| **Web** | Material 3 | Universal browser canvas / HTML |
| **Windows** | Material 3 | Desktop Material |
| **macOS** | Material 3 | Desktop Material (Cupertino via override) |
| **Linux** | Material 3 | Desktop Material |
| **Fuchsia / Other** | Material 3 | Material 3 |

---

## 📦 Installation

Add `flutter_adaptive_ui_pro` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_adaptive_ui_pro: ^1.0.1
```

Run:

```bash
flutter pub get
```

Import in your Dart code:

```dart
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';
```

---

## 🚀 Quick Start

Use `AdaptiveApp` to wrap your application with automatic platform theme configuration:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveApp(
      title: 'Adaptive Demo',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: const AdaptiveAppBar(
        titleText: 'Adaptive Pro',
      ),
      body: Center(
        child: AdaptiveButton.filled(
          label: 'Launch Dialog',
          icon: const Icon(Icons.rocket_launch),
          onPressed: () {
            AdaptiveDialog.confirm(
              context: context,
              titleText: 'Confirm Launch',
              contentText: 'Ready to launch your adaptive Flutter app?',
              confirmText: 'Launch',
              isDestructiveAction: true,
            );
          },
        ),
      ),
    );
  }
}
```

---

## 🧩 Comprehensive Widget Guide

### 1. Buttons

`AdaptiveButton` provides constructors and named factories for all primary button styles:

```dart
// Filled / Primary Action
AdaptiveButton.filled(
  label: 'Save Changes',
  icon: const Icon(Icons.check),
  onPressed: () {},
);

// Tonal Action
AdaptiveButton.tonal(
  label: 'Secondary Option',
  onPressed: () {},
);

// Elevated Action
AdaptiveButton.elevated(
  label: 'Elevated Action',
  onPressed: () {},
);

// Outlined / Bordered Action
AdaptiveButton.outlined(
  label: 'Cancel',
  onPressed: () {},
);

// Plain Text Action
AdaptiveButton.text(
  label: 'Learn More',
  onPressed: () {},
);

// Icon Button
AdaptiveIconButton(
  icon: const Icon(Icons.favorite),
  tooltip: 'Favorite',
  onPressed: () {},
);

// Floating Action Button (Material FAB on Android, elevated pill on iOS)
AdaptiveFloatingActionButton(
  onPressed: () {},
  child: const Icon(Icons.add),
);

// Back & Close Buttons
AdaptiveBackButton(onPressed: () => Navigator.pop(context));
AdaptiveCloseButton(onPressed: () => Navigator.pop(context));
```

---

### 2. Text Input & Fields

Platform-appropriate input styling: Material 3 input decorations on Android, and iOS HIG borderless/filled inputs on iOS:

```dart
// Standard Text Field
AdaptiveTextField(
  label: 'Username',
  placeholder: 'Enter your handle',
  prefixIcon: const Icon(Icons.person),
  controller: usernameController,
  onChanged: (value) => print(value),
);

// Form-integrated Text Field with Validation
AdaptiveTextFormField(
  label: 'Email Address',
  placeholder: 'user@domain.com',
  keyboardType: TextInputType.emailAddress,
  validator: (val) {
    if (val == null || !val.contains('@')) return 'Please enter a valid email';
    return null;
  },
);

// Password Field with Built-in Visibility Toggle
AdaptivePasswordField(
  label: 'Password',
  placeholder: '••••••••',
  controller: passwordController,
);

// Search Field
AdaptiveSearchField(
  placeholder: 'Search documentation...',
  onChanged: (query) => performSearch(query),
);
```

---

### 3. Forms & Grouping

Preserve standard Flutter form workflows (`GlobalKey<FormState>`, `validate()`, `save()`, `reset()`) with native iOS grouped sections:

```dart
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

AdaptiveForm(
  formKey: _formKey,
  child: Column(
    children: [
      AdaptiveFormSection(
        header: const Text('ACCOUNT INFORMATION'),
        footer: const Text('Your email is used for account verification.'),
        children: [
          AdaptiveFormRow(
            prefix: const Text('Email'),
            child: AdaptiveTextFormField(
              placeholder: 'jane@apple.com',
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
          ),
          AdaptiveFormRow(
            prefix: const Text('Password'),
            child: const AdaptivePasswordField(
              placeholder: '••••••••',
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      AdaptiveButton.filled(
        label: 'Submit',
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            _formKey.currentState?.save();
          }
        },
      ),
    ],
  ),
);
```

---

### 4. Selection Controls

Native `Switch`, `Checkbox`, `Radio`, and `SegmentedControl`:

```dart
// Switch
AdaptiveSwitch(
  value: isEnabled,
  onChanged: (val) => setState(() => isEnabled = val),
);

// Switch List Tile
AdaptiveSwitchListTile(
  title: const Text('Push Notifications'),
  subtitle: const Text('Receive sound and badge alerts'),
  value: notificationsEnabled,
  onChanged: (val) => setState(() => notificationsEnabled = val),
);

// Checkbox
AdaptiveCheckbox(
  value: isChecked,
  onChanged: (val) => setState(() => isChecked = val ?? false),
);

// Checkbox List Tile
AdaptiveCheckboxListTile(
  title: const Text('I agree to the Terms of Service'),
  value: isChecked,
  onChanged: (val) => setState(() => isChecked = val ?? false),
);

// Radio
AdaptiveRadio<int>(
  value: 1,
  groupValue: selectedOption,
  onChanged: (val) => setState(() => selectedOption = val!),
);

// Segmented Control (Material SegmentedButton or iOS SlidingSegmentedControl)
AdaptiveSegmentedControl<int>(
  groupValue: selectedTab,
  onValueChanged: (val) => setState(() => selectedTab = val),
  children: const {
    0: Text('Daily'),
    1: Text('Weekly'),
    2: Text('Monthly'),
  },
);

// Sliders
AdaptiveSlider(
  value: volume,
  min: 0.0,
  max: 1.0,
  onChanged: (val) => setState(() => volume = val),
);

AdaptiveRangeSlider(
  values: const RangeValues(20, 80),
  min: 0,
  max: 100,
  onChanged: (range) => print(range),
);
```

---

### 5. Dialogs & Modals

Static asynchronous methods returning strongly typed results:

```dart
// Asynchronous Confirmation Dialog
final bool confirmed = await AdaptiveDialog.confirm(
  context: context,
  titleText: 'Delete Workspace?',
  contentText: 'This action cannot be undone. All documents will be lost.',
  confirmText: 'Delete',
  cancelText: 'Cancel',
  isDestructiveAction: true,
);

// Info Dialog
await AdaptiveDialog.info(
  context: context,
  titleText: 'Synchronization Complete',
  contentText: 'All files are up to date with cloud storage.',
);

// Error Dialog
await AdaptiveDialog.error(
  context: context,
  titleText: 'Network Failure',
  contentText: 'Unable to reach the server. Please check your connection.',
);

// Input Prompt Dialog
final String? username = await AdaptiveDialog.prompt(
  context: context,
  titleText: 'Rename File',
  placeholder: 'Enter new filename',
  initialValue: 'document.pdf',
);
```

---

### 6. Bottom Sheets & Action Sheets

Material modal bottom sheet on Android; native `CupertinoActionSheet` popup on iOS:

```dart
final String? action = await AdaptiveActionSheet.show<String>(
  context: context,
  title: const Text('Document Options'),
  message: const Text('Choose what to do with this file'),
  actions: [
    AdaptiveActionSheetAction<String>(
      title: const Text('Share Link'),
      value: 'share',
    ),
    AdaptiveActionSheetAction<String>(
      title: const Text('Download Copy'),
      value: 'download',
    ),
    AdaptiveActionSheetAction<String>(
      title: const Text('Delete File'),
      value: 'delete',
      isDestructive: true,
    ),
  ],
);
```

---

### 7. Pickers & Dates

Platform-authentic pickers: Material calendar/time dialogs on Android, and modal wheel pickers on iOS:

```dart
// Date Picker
final DateTime? pickedDate = await AdaptiveDatePicker.show(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2000),
  lastDate: DateTime(2100),
);

// Time Picker
final TimeOfDay? pickedTime = await AdaptiveTimePicker.show(
  context: context,
  initialTime: TimeOfDay.now(),
);

// Wheel Item Picker
final int? selectedIndex = await AdaptivePicker.show<int>(
  context: context,
  items: const [Text('Small'), Text('Medium'), Text('Large')],
  initialIndex: 1,
);
```

---

### 8. Menus & Dropdowns

```dart
// Dropdown Selector (DropdownButton on Android, CupertinoPicker modal on iOS)
AdaptiveDropdown<String>(
  value: selectedCategory,
  items: const [
    AdaptiveMenuItem(value: 'tech', label: 'Technology'),
    AdaptiveMenuItem(value: 'design', label: 'Design'),
    AdaptiveMenuItem(value: 'business', label: 'Business'),
  ],
  onChanged: (val) => setState(() => selectedCategory = val!),
);

// Popup Context Menu
AdaptivePopupMenu<String>(
  items: const [
    AdaptiveMenuItem(value: 'edit', label: 'Edit', icon: Icon(Icons.edit)),
    AdaptiveMenuItem(value: 'delete', label: 'Delete', icon: Icon(Icons.delete)),
  ],
  onSelected: (val) => handleMenuSelection(val),
  child: const Icon(Icons.more_vert),
);
```

---

### 9. Navigation & Scaffolding

```dart
AdaptiveScaffold(
  appBar: AdaptiveAppBar(
    titleText: 'Dashboard',
    leading: AdaptiveBackButton(),
    actions: [
      AdaptiveIconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
    ],
  ),
  bottomNavigationBar: AdaptiveBottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) => setState(() => currentIndex = index),
    items: const [
      AdaptiveNavigationItem(icon: Icon(Icons.home), label: 'Home'),
      AdaptiveNavigationItem(icon: Icon(Icons.explore), label: 'Explore'),
      AdaptiveNavigationItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  ),
  body: Center(child: Text('Page $currentIndex')),
);
```

---

### 10. Lists & Grouped Sections

Material `ListTile` vs Cupertino inset grouped `CupertinoListSection`:

```dart
AdaptiveListSection(
  header: const Text('SETTINGS'),
  children: [
    AdaptiveListTile(
      leading: const Icon(Icons.lock_outline),
      title: const Text('Security & Privacy'),
      subtitle: const Text('Manage password and two-factor auth'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    ),
    AdaptiveListTile(
      leading: const Icon(Icons.language),
      title: const Text('Language'),
      trailing: const Text('English'),
      onTap: () {},
    ),
  ],
);
```

---

### 11. Progress & Loading States

```dart
// Circular Spinner (CircularProgressIndicator or CupertinoActivityIndicator)
const AdaptiveCircularProgressIndicator();

// Linear Progress Bar
const AdaptiveLinearProgressIndicator(value: 0.65);

// Loading State Wrapper View
const AdaptiveLoadingView(
  message: 'Fetching workspace records...',
);

// Empty State View
const AdaptiveEmptyState(
  icon: Icons.inbox_outlined,
  title: 'No Documents Found',
  description: 'Your repository is empty. Create a new file to begin.',
);
```

---

### 12. Feedback & Notifications

```dart
// Platform SnackBar / Toast
AdaptiveSnackBar.show(
  context,
  message: 'Document saved successfully!',
  type: AdaptiveFeedbackType.success,
  actionLabel: 'Undo',
  onAction: () => undoAction(),
);

// Tooltip
AdaptiveTooltip(
  message: 'Toggle Dark Mode',
  child: IconButton(
    icon: const Icon(Icons.dark_mode),
    onPressed: () {},
  ),
);
```

---

### 13. Miscellaneous Widgets

```dart
// Adaptive Divider
const AdaptiveDivider();

// Adaptive Badge
const AdaptiveBadge(
  count: 3,
  child: Icon(Icons.notifications),
);

// Adaptive Avatar
const AdaptiveAvatar(
  name: 'John Doe',
  radius: 24,
);

// Adaptive Chip
AdaptiveChip(
  label: 'Flutter 3.35',
  onDeleted: () {},
);

// Pull-to-Refresh Indicator
AdaptiveRefreshIndicator(
  onRefresh: () async => fetchLatestData(),
  child: ListView(...),
);
```

---

## 🎨 Adaptive Theming

Configure unified styling for both Material and Cupertino:

```dart
AdaptiveTheme(
  data: AdaptiveThemeData(
    platform: AdaptivePlatform.adaptive,
    primaryColor: Colors.indigo,
    materialTheme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      brightness: Brightness.light,
    ),
    cupertinoTheme: const CupertinoThemeData(
      primaryColor: CupertinoColors.activeBlue,
      brightness: Brightness.light,
    ),
  ),
  child: const MyApp(),
);
```

---

## 🎛️ Runtime Platform Overrides

Test or force a specific platform UI anywhere in your widget tree:

```dart
// 1. Scoped Override: Forces Cupertino UI for this screen and all children
AdaptiveConfig(
  platform: AdaptivePlatform.cupertino,
  child: const SettingsScreen(),
);

// 2. Single-Widget Override: Forces Material for this specific button
AdaptiveButton.filled(
  platform: AdaptivePlatform.material,
  label: 'Android Style Button',
  onPressed: () {},
);
```

---

## 📱 BuildContext Extensions

Convenience helpers on `BuildContext`:

```dart
// Platform Queries
if (context.isCupertino) {
  // Cupertino UI is active
} else if (context.isMaterial) {
  // Material 3 UI is active
}

// Current Mode
final AdaptivePlatform currentPlatform = context.adaptivePlatform;

// Quick SnackBar
context.showAdaptiveSnackBar(const SnackBar(content: Text('Saved!')));
```

---

## ♿ Accessibility & RTL

All components are built with strict adherence to accessibility standards:
- **Screen Reader Support**: Integrated `Semantics` tags for voice assistants.
- **Dynamic Text Scaling**: Scales smoothly with `MediaQuery.textScaler`.
- **RTL Support**: Full bidirectional layout support with native `Directionality` awareness.
- **Accessible Touch Targets**: Standard 48×48dp (Material) and 44×44pt (Cupertino) minimum hit targets.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to open an issue or submit a pull request on [GitHub](https://github.com/Kishandobariya76/flutter_adaptive_ui_pro).

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## Support

If Flutter Adaptive UI Pro saved you time, you can buy me a chai.

[![Buy Me a Chai](https://img.shields.io/badge/Buy%20Me%20a%20Chai-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://cdn.jsdelivr.net/gh/Kishandobariya76/flutter_guard@main/support.html)
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://cdn.jsdelivr.net/gh/Kishandobariya76/flutter_guard@main/support.html)

Phones open a UPI app. Desktops show a QR to scan.

---

## Developer

**Kishan Dobariya**

- Phone: +91 90232 56218
- Email: [flutterdeveloper2206@gmail.com](mailto:flutterdeveloper2206@gmail.com)
- LinkedIn: [kishan-dobariya-99b005217](https://www.linkedin.com/in/kishan-dobariya-99b005217)
- GitHub: [Kishandobariya76](https://github.com/Kishandobariya76)
