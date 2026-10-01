# API Design Philosophy & Guidelines

`flutter_adaptive_ui_pro` is designed for Flutter engineers who value idiomatic API design, compile-time safety, zero runtime overhead, and beautiful native UI.

---

## 1. Design Principles

1. **Flutter-Native Ergonomics**:
   Widgets mimic standard Flutter naming patterns. If you know how to use `ElevatedButton`, `AdaptiveButton` or `AdaptiveElevatedButton` requires zero learning curve.
2. **Type-Safety & Generics**:
   Generic components such as `AdaptiveDropdown<T>`, `AdaptiveRadio<T>`, `AdaptivePicker<T>`, and `AdaptiveSegmentedControl<T>` are strongly typed without relying on `dynamic`.
3. **Immutability & Const Optimization**:
   All widget definitions and configuration structures offer `const` constructors where possible to prevent redundant rebuilds.
4. **No External State-Management Dependencies**:
   Zero dependencies on GetX, Provider, Bloc, Riverpod, or MobX. The package operates cleanly on Flutter's built-in `InheritedWidget` and `BuildContext` systems.
5. **No `dart:io` Invasions**:
   Universal web and desktop compatibility by querying `Theme.of(context).platform` and `defaultTargetPlatform`.

---

## 2. API Surface Tour

### A. Core Platform Scope & Configuration
```dart
AdaptiveConfig(
  platform: AdaptivePlatform.adaptive, // or .material, .cupertino
  child: MyApp(),
);
```

### B. Dual-Engine Theming
```dart
AdaptiveTheme(
  data: AdaptiveThemeData(
    platform: AdaptivePlatform.adaptive,
    materialTheme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
    cupertinoTheme: const CupertinoThemeData(primaryColor: CupertinoColors.activeBlue),
  ),
  child: const HomeScreen(),
);
```

### C. Declarative UI Widgets
```dart
// Buttons
AdaptiveButton(
  label: 'Get Started',
  icon: Icons.rocket_launch,
  onPressed: () => handleStart(),
);

// Form Fields
AdaptiveTextFormField(
  label: 'Email',
  placeholder: 'you@example.com',
  validator: (v) => v != null && v.contains('@') ? null : 'Invalid email',
);

// Selection
AdaptiveSwitch(
  value: isEnabled,
  onChanged: (val) => setState(() => isEnabled = val),
);
```

### D. Overlay Services
```dart
// Static Dialog
final confirmed = await AdaptiveDialog.confirm(
  context: context,
  title: 'Delete Item',
  message: 'Are you sure you want to permanently delete this item?',
  confirmText: 'Delete',
  isDestructive: true,
);

// Date Picker
final date = await AdaptiveDatePicker.show(
  context: context,
  initialDate: DateTime.now(),
);

// Bottom Action Sheet
final option = await AdaptiveActionSheet.show<String>(
  context: context,
  title: 'Select Action',
  actions: [
    AdaptiveSheetAction(title: 'Edit', value: 'edit'),
    AdaptiveSheetAction(title: 'Delete', value: 'delete', isDestructive: true),
  ],
);
```
