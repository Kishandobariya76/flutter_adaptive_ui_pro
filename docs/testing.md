# Testing Strategy & Validation Guide

Comprehensive automated testing is a core pillar of `flutter_adaptive_ui_pro`. This document describes the test architecture, suites, execution methods, and regression validation protocols.

---

## 1. Test Architecture

The package test suite is organized into modular categories matching the component domains:

```text
test/
├── core/
│   └── platform_resolver_test.dart       # 5-step cascade resolution logic
├── platform/
│   └── platform_detector_test.dart       # TargetPlatform, Web safety, OS heuristics
├── themes/
│   └── adaptive_theme_test.dart          # Coordinated Material/Cupertino theming
├── widgets/
│   ├── buttons_test.dart                 # Button variants, styles, disabled states
│   ├── text_fields_test.dart             # Inputs, password reveal, search
│   └── selection_test.dart               # Switches, checkboxes, sliders, segments
├── dialogs/
│   └── dialogs_and_sheets_test.dart      # Dialogs, confirm, action sheets
├── forms/
│   └── forms_test.dart                   # Form validation, sections, form rows
├── accessibility/
│   └── accessibility_test.dart           # Semantics, text scaling, RTL
└── regression/
    └── regression_test.dart              # Edge cases, icon mapping, empty bodies
```

---

## 2. Test Suites Overview

### A. Cascade Platform Resolution (`test/core/`)
- Verifies that `AdaptivePlatform.adaptive` automatically resolves to Cupertino on iOS and Material on Android/Web/Desktop/Fuchsia.
- Validates the 5-step resolution priority:
  1. Widget-level override (`platform: AdaptivePlatform.cupertino`)
  2. Nearest `AdaptiveConfig`
  3. `AdaptiveTheme` configuration
  4. Flutter platform detection (`Theme.of(context).platform` or `defaultTargetPlatform`)
  5. Material fallback.

### B. Button System (`test/widgets/buttons_test.dart`)
- Validates `AdaptiveButton`, `AdaptiveFilledButton`, `AdaptiveElevatedButton`, `AdaptiveOutlinedButton`, `AdaptiveTextButton`, `AdaptiveIconButton`, `AdaptiveFloatingActionButton`.
- Tests touch events, disabled states, custom content builders, icon-label layouts, and overrides.

### C. Text Inputs & Forms (`test/widgets/text_fields_test.dart` & `test/forms/forms_test.dart`)
- Tests `AdaptiveTextField` and `AdaptiveTextFormField`.
- Confirms end-to-end integration with `GlobalKey<FormState>()`, `validate()`, `save()`, and validation error presentation on both Material and Cupertino.
- Tests password obscurity toggle interactivity.

### D. Selection & Controls (`test/widgets/selection_test.dart`)
- Validates `AdaptiveSwitch`, `AdaptiveCheckbox`, `AdaptiveSlider`, and `AdaptiveSegmentedControl`.
- Verifies value mutation callbacks, active colors, and platform-specific widget rendering (`Switch` vs `CupertinoSwitch`, `SegmentedButton` vs `CupertinoSlidingSegmentedControl`).

### E. Dialogs & Action Sheets (`test/dialogs/dialogs_and_sheets_test.dart`)
- Tests static helper methods: `AdaptiveDialog.confirm`, `AdaptiveActionSheet.show`.
- Verifies modal presentation, destructive action color styling, default buttons, and result passing.

### F. Accessibility & Semantics (`test/accessibility/accessibility_test.dart`)
- Evaluates accessibility semantics: labels, `isButton`, `isEnabled`, and `hasEnabledState`.
- Verifies layout robustness under heavy text scaling (`TextScaler.linear(2.5)`).
- Validates RTL layout rendering with Arabic text.

---

## 3. Running Tests

### Run all tests:
```bash
flutter test
```

### Run tests with code coverage:
```bash
flutter test --coverage
```

### Run a specific suite:
```bash
flutter test test/core/platform_resolver_test.dart
flutter test test/widgets/buttons_test.dart
```

---

## 4. Static Analysis Quality Gate
Before any release or PR merge, the code must achieve zero issues under strict rules:
```bash
flutter analyze
```
Requirement:
- **0** analyzer errors
- **0** analyzer warnings
- **0** linter hints
