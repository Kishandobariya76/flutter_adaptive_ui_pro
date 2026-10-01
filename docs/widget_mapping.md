# Widget Mapping & Parameter Translation Guide

This document details how `flutter_adaptive_ui_pro` bridges parameter differences between Flutter Material and Cupertino widgets.

---

## 1. Principles of Adaptive Mapping

1. **No Fake Adaptivity**: We never wrap a Material button in an iOS theme and call it adaptive. When rendering for iOS, authentic `Cupertino` widgets (e.g. `CupertinoButton`, `CupertinoTextField`, `CupertinoAlertDialog`, `CupertinoPicker`) are used.
2. **Graceful Parameter Translation**: Parameters like `onPressed`, `child`, `label`, `padding`, `backgroundColor`, and `focusNode` translate 1-to-1. Where one design system lacks a concept (e.g. `elevation` on Cupertino), the parameter is translated to its visual counterpart (e.g. iOS subtle shadow or border), or handled cleanly via platform-specific configuration.
3. **Escapes without Bloat**: When platform-specific parameters are needed, dedicated `material:` and `cupertino:` configuration objects provide type-safe escapes without ballooning constructor signatures.

---

## 2. Category-Specific Mappings

### A. Buttons (`AdaptiveButton`, `AdaptiveFilledButton`, etc.)
- **Label & Icon**: Unified `label`, `icon`, or `child`. In Cupertino, `CupertinoButton` renders text or row layout with appropriate typography (`CupertinoTheme.of(context).textTheme.actionTextStyle`).
- **Styles**:
  - `filled` → `FilledButton` on Material; `CupertinoButton.filled` on Cupertino.
  - `tonal` → `FilledButton.tonal` on Material; `CupertinoButton` with system grey background on Cupertino.
  - `outlined` → `OutlinedButton` on Material; `CupertinoButton` with rounded border on Cupertino.
  - `text` → `TextButton` on Material; `CupertinoButton` plain on Cupertino.
  - `icon` → `IconButton` on Material; `CupertinoButton` with icon child and minimal padding on Cupertino.

### B. Text Inputs (`AdaptiveTextField`, `AdaptiveTextFormField`, etc.)
- **Placeholder / Hint**: Flutter Material uses `decoration: InputDecoration(hintText: ...)`, while Cupertino uses `placeholder: ...`. `AdaptiveTextField` exposes `placeholder` and `hint` interchangeably.
- **Prefix / Suffix**: Exposes `prefix` and `suffix` widgets. On Material, these map to `InputDecoration(prefixIcon: ..., suffixIcon: ...)`. On Cupertino, they map directly to `CupertinoTextField(prefix: ..., suffix: ...)`.
- **Validation**: `AdaptiveTextFormField` uses a standard `FormField<String>` wrapper on Cupertino to maintain `GlobalKey<FormState>` validation, rendering Cupertino-styled error text below the input.

### C. Selection Controls
- **Switch**: `AdaptiveSwitch` uses `Switch` on Material and `CupertinoSwitch` on iOS. Active and track colors are mapped faithfully.
- **Checkbox**: `AdaptiveCheckbox` uses `Checkbox` on Material and `CupertinoCheckbox` on iOS. Both support `tristate`.
- **Radio**: `AdaptiveRadio<T>` uses `Radio<T>` on Material and `CupertinoRadio<T>` on iOS.

### D. Overlays & Dialogs
- **Dialogs**:
  - `AdaptiveDialog.show` maps to `showDialog` with `AlertDialog` on Material, and `showCupertinoDialog` with `CupertinoAlertDialog` on iOS.
  - Action buttons map to `TextButton` on Material and `CupertinoDialogAction` on iOS, respecting `isDestructiveAction` and `isDefaultAction`.
- **Bottom Sheets**:
  - `AdaptiveBottomSheet` maps to `showModalBottomSheet` on Material, and `showCupertinoModalPopup` with `CupertinoActionSheet` on iOS.

### E. Navigation & Scaffolding
- **Scaffold**: `AdaptiveScaffold` resolves to `Scaffold` on Material, with `appBar`, `body`, `bottomNavigationBar`, `floatingActionButton`, `drawer`. On iOS, it maps to `CupertinoPageScaffold` with `CupertinoNavigationBar`, automatically adapting padding and safe area handling.
- **App Root**: `AdaptiveApp` builds `MaterialApp` on Material and `CupertinoApp` on iOS, or injects an `AdaptiveScope` bridge so that Cupertino and Material themes co-exist in harmony.

### F. Lists
- **ListTile**: `AdaptiveListTile` renders Material `ListTile` with ripple effects on Android, and `CupertinoListTile` with trailing chevrons and separator lines on iOS.
- **ListSection**: Renders Material `Card`/grouped column on Android, and `CupertinoListSection.insetGrouped` on iOS.

---

## 3. Platform Configuration Escapes

When deep platform-specific customization is required:
```dart
AdaptiveButton(
  label: 'Checkout',
  onPressed: () {},
  material: AdaptiveMaterialButtonConfig(
    elevation: 4.0,
    shadowColor: Colors.blueAccent,
  ),
  cupertino: AdaptiveCupertinoButtonConfig(
    pressedOpacity: 0.6,
    borderRadius: BorderRadius.circular(12),
  ),
);
```
This guarantees zero leakage of platform checks into user business logic.
