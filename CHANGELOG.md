# Changelog

All notable changes to `flutter_adaptive_ui_pro` are documented in this file.

## 1.0.1

- Updated README documentation with developer info, support channels, and badges.
- Enhanced package metadata and quick start references.

## 1.0.0 - Initial Production Release

Initial stable release of `flutter_adaptive_ui_pro` — a production-grade, zero-native-channel adaptive UI framework for Flutter.

### Core Features
- **Zero Native Plugins**: Pure Flutter & Dart package running universally across Android, iOS, Web, macOS, Windows, Linux, and Fuchsia.
- **5-Step Platform Resolution Cascade**: Widget override → Scoped `AdaptiveConfig` → `AdaptiveTheme` → `TargetPlatform` / OS detection → Material 3 fallback.
- **Web Safe Platform Heuristics**: Pure Flutter detection avoiding `dart:io` crashes on Web.

### Component System (Over 40+ Adaptive Widgets)
- **Buttons**: `AdaptiveButton`, `AdaptiveElevatedButton`, `AdaptiveFilledButton`, `AdaptiveFilledTonalButton`, `AdaptiveOutlinedButton`, `AdaptiveTextButton`, `AdaptiveIconButton`, `AdaptiveFloatingActionButton`, `AdaptiveBackButton`, `AdaptiveCloseButton`.
- **Text Inputs**: `AdaptiveTextField`, `AdaptiveTextFormField`, `AdaptiveSearchField`, `AdaptivePasswordField` with interactive obscurity toggle.
- **Selection Controls**: `AdaptiveCheckbox`, `AdaptiveCheckboxListTile`, `AdaptiveRadio`, `AdaptiveRadioListTile`, `AdaptiveSwitch`, `AdaptiveSwitchListTile`, `AdaptiveSlider`, `AdaptiveRangeSlider`, `AdaptiveSegmentedControl`.
- **Overlays & Dialogs**: `AdaptiveDialog` (with `confirm`, `info`, `error`, `success`, `prompt`), `AdaptiveAlertDialog`, `AdaptiveConfirmDialog`, `AdaptiveInputDialog`, `AdaptiveCustomDialog`.
- **Sheets**: `AdaptiveBottomSheet`, `AdaptiveModalBottomSheet`, `AdaptiveActionSheet`.
- **Pickers**: `AdaptiveDatePicker`, `AdaptiveTimePicker`, `AdaptiveDateTimePicker`, `AdaptiveCalendar`, `AdaptiveTimerPicker`, `AdaptivePicker`.
- **Menus**: `AdaptiveDropdown`, `AdaptiveDropdownButton`, `AdaptiveDropdownMenu`, `AdaptivePopupMenu`, `AdaptiveContextMenu`.
- **Navigation**: `AdaptiveApp`, `AdaptiveApp.router`, `AdaptiveScaffold`, `AdaptivePageScaffold`, `AdaptiveAppBar`, `AdaptiveNavigationBar`, `AdaptiveBottomNavigationBar`, `AdaptiveTabBar`, `AdaptiveNavigationRail`, `AdaptiveDrawer`.
- **Lists**: `AdaptiveListTile`, `AdaptiveListSection`, `AdaptiveListView`, `AdaptiveExpansionTile`, `AdaptiveDismissible`, `AdaptiveScrollbar`.
- **Progress**: `AdaptiveCircularProgressIndicator`, `AdaptiveLinearProgressIndicator`, `AdaptiveLoadingIndicator`.
- **Feedback**: `AdaptiveSnackBar`, `AdaptiveToast`, `AdaptiveBanner`, `AdaptiveTooltip`, `AdaptiveErrorView`, `AdaptiveEmptyState`, `AdaptiveLoadingView`.
- **Forms**: `AdaptiveForm`, `AdaptiveFormField`, `AdaptiveFormSection`, `AdaptiveFormRow`.
- **Miscellaneous**: `AdaptiveDivider`, `AdaptiveIcon`, `AdaptiveAvatar`, `AdaptiveBadge`, `AdaptiveChip`, `AdaptiveCard`, `AdaptiveRefreshIndicator`, `AdaptiveSafeArea`, `AdaptiveVisibility`.

### Theming & Extensions
- `AdaptiveTheme` and `AdaptiveThemeData` dual-engine coordinator bridging Material 3 `ThemeData` and `CupertinoThemeData`.
- `AdaptiveColorScheme` and `AdaptiveTextTheme`.
- `BuildContext` extension methods: `isCupertino`, `isMaterial`, `resolvedAdaptivePlatform`, `showAdaptiveSnackBar`, `showAdaptiveConfirmDialog`.

### Quality & Testing
- 100% null-safe strongly typed API.
- Zero external state management dependencies.
- Verified accessibility: screen readers, semantics, large text scaling, focus navigation, and RTL localization.
- Exhaustive test suite across unit, widget, theme, form validation, and accessibility domains.
