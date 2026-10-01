# Platform Behavior & Resolution System

This document specifies the platform detection and resolution logic in `flutter_adaptive_ui_pro`.

---

## 1. Platform Matrix

By default, without manual overrides, platforms resolve to the following design systems:

| Platform | Resolved UI Style | Implementation |
|---|---|---|
| **Android** | Material Design 3 | Flutter `material` library |
| **iOS** | Cupertino (Human Interface Guidelines) | Flutter `cupertino` library |
| **Web** | Material Design 3 | Flutter `material` library |
| **macOS** | Material Design 3 | Flutter `material` library |
| **Windows** | Material Design 3 | Flutter `material` library |
| **Linux** | Material Design 3 | Flutter `material` library |
| **Fuchsia** | Material Design 3 | Flutter `material` library |
| **Unknown / Fallback** | Material Design 3 | Flutter `material` library |

---

## 2. Multi-Level Resolution Priority

When an adaptive widget renders, it resolves its active design system through a 5-step cascade:

```text
┌─────────────────────────────────────────────────────────────┐
│ 1. Widget-Level Override                                    │
│    (e.g., AdaptiveButton(platform: AdaptivePlatform.cupertino))│
└──────────────────────────────┬──────────────────────────────┘
                               │ (if null or adaptive)
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. Nearest AdaptiveConfig In Widget Tree                   │
│    (InheritedWidget scoped configuration)                   │
└──────────────────────────────┬──────────────────────────────┘
                               │ (if null or adaptive)
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. AdaptiveTheme Configuration                              │
│    (App-wide theme platform setting)                        │
└──────────────────────────────┬──────────────────────────────┘
                               │ (if null or adaptive)
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. Flutter Platform Detection                               │
│    (Theme.of(context).platform or defaultTargetPlatform)    │
│    TargetPlatform.iOS => Cupertino                          │
│    TargetPlatform.*   => Material                           │
└──────────────────────────────┬──────────────────────────────┘
                               │ (if detection fails)
                               ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Material 3 Fallback                                      │
└─────────────────────────────────────────────────────────────┘
```

---

## 3. Flutter Web & Desktop Safety

The package strictly avoids importing `dart:io` in all runtime code. Platform detection is implemented via:
- `Theme.of(context).platform` (reflecting mockable debug platforms and framework state)
- `foundation.defaultTargetPlatform` (safe on Flutter Web and all targets)
- `foundation.kIsWeb` check to handle web compilation seamlessly.

This guarantees:
- Zero crashes on Flutter Web (`Unsupported operation: Platform._operatingSystem`).
- Predictable tests: tests can simulate iOS or Android using `debugDefaultTargetPlatformOverride` or `ThemeData(platform: TargetPlatform.iOS)`.
