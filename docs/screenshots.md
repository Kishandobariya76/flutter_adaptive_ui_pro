# Screenshot System & Visual Verification Guide

This document specifies how screenshots are captured, updated, and validated for `flutter_adaptive_ui_pro`.

---

## 1. Screenshot Inventory

All screenshots are generated directly from the authentic example showcase application (`example/`) using Flutter's high-fidelity `RenderRepaintBoundary.toImage()` engine.

### Android (Material Design 3)
| Screen | Path | Description |
|---|---|---|
| **Home** | `screenshots/android/home.png` | Overview screen with Material 3 cards, information tiles, and platform switcher |
| **Buttons** | `screenshots/android/buttons.png` | FilledButton, TonalButton, ElevatedButton, OutlinedButton, TextButton, FloatingActionButton |
| **Forms** | `screenshots/android/forms.png` | Outlined TextField, TextFormField with validation, PasswordField with toggle, SearchBar |
| **Dialogs** | `screenshots/android/dialogs.png` | Material AlertDialog with confirm/destructive action buttons |
| **Pickers** | `screenshots/android/pickers.png` | Material SegmentedButton, SwitchListTile, CheckboxListTile, Slider |
| **Navigation**| `screenshots/android/navigation.png` | Material AppBar with menu, and NavigationBar with active indicator pills |

### iOS (Apple Cupertino Human Interface Guidelines)
| Screen | Path | Description |
|---|---|---|
| **Home** | `screenshots/ios/home.png` | Cupertino grouped list section, rounded segmented control, iOS theme |
| **Buttons** | `screenshots/ios/buttons.png` | CupertinoButton.filled, tonal capsule, bordered button, plain text, elevated capsule FAB |
| **Forms** | `screenshots/ios/forms.png` | CupertinoFormSection.insetGrouped, CupertinoFormRow, CupertinoTextField, SearchTextField |
| **Dialogs** | `screenshots/ios/dialogs.png` | CupertinoAlertDialog with destructive red action and default bold action |
| **Pickers** | `screenshots/ios/pickers.png` | CupertinoSwitch, CupertinoCheckbox, CupertinoSlidingSegmentedControl, CupertinoSlider |
| **Navigation**| `screenshots/ios/navigation.png` | CupertinoNavigationBar with back chevron and CupertinoTabBar |

### Web & Desktop
| Screen | Path | Description |
|---|---|---|
| **Home** | `screenshots/web/home.png` | Desktop responsive showcase layout (1024x768) |
| **Showcase** | `screenshots/web/showcase.png` | Wide desktop dashboard showcase layout (1280x800) |

---

## 2. Environment & Live Hardware Devices

- **Android Physical Hardware**: Samsung Galaxy Note 10+ (`SM-N975F`, Android 12, API 31, 1080x2280)
- **iOS Simulator**: Apple iPhone 17 (`com.apple.CoreSimulator.SimDeviceType.iPhone-17`, iOS 26.5/27)
- **Web Desktop**: Google Chrome / macOS CanvasKit (1280x800)
- **Flutter SDK**: 3.35.0 (Channel stable)
- **Dart SDK**: 3.9.0
- **Renderer**: Flutter Impeller / Skia engine

---

## 3. How Screenshots Were Captured

Screenshots are generated deterministically by the automated test suite runner at `example/test/generate_screenshots_test.dart`.

The test runner:
1. Configures `tester.view.physicalSize` and `tester.view.devicePixelRatio`.
2. Wraps each target screen inside a `RepaintBoundary`.
3. Sets explicit platform modes (`AdaptivePlatform.material` and `AdaptivePlatform.cupertino`).
4. Executes `toImage(pixelRatio: 2.0)` to obtain raw RGBA frames directly from the compositor.
5. Encodes frames to lossless PNG bytes via `ImageByteFormat.png`.
6. Saves files directly into `screenshots/android/`, `screenshots/ios/`, and `screenshots/web/`.

---

## 4. How Screenshots Are Updated

To regenerate all screenshots when UI changes occur:
```bash
cd example
flutter test test/generate_screenshots_test.dart
```

---

## 5. Visual Regression Detection

1. **Deterministic Testing**: Because the capture runs in headless test environments with fixed physical sizes and fonts, generated PNG byte streams remain deterministic across builds.
2. **Git Diff Verification**: Any unintentional visual change to component padding, colors, or typography results in a Git modification in the `screenshots/` directory, surfacing visual regressions immediately in code review.
