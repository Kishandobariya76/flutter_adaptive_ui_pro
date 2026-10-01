# Flutter SDK API Inventory

This document surveys Flutter's installed Material and Cupertino APIs to establish the baseline mapping for `flutter_adaptive_ui_pro`.

---

## 1. Component Categories & Inventory

### A. Buttons
| Functionality | Material Widget | Cupertino Widget | Parity Type | Adaptive Resolution |
|---|---|---|---|---|
| Primary Button | `ElevatedButton` / `FilledButton` | `CupertinoButton.filled` | Direct | `AdaptiveButton` / `AdaptiveFilledButton` |
| Secondary / Outlined | `OutlinedButton` | `CupertinoButton` (bordered) | Partial | `AdaptiveOutlinedButton` |
| Text / Plain | `TextButton` | `CupertinoButton` (plain) | Direct | `AdaptiveTextButton` |
| Icon Button | `IconButton` | `CupertinoButton` (icon child) | Direct | `AdaptiveIconButton` |
| Floating Action | `FloatingActionButton` | Custom elevated Cupertino container | Partial | `AdaptiveFloatingActionButton` |
| Back Navigation | `BackButton` | `CupertinoNavigationBarBackButton` | Direct | `AdaptiveBackButton` |
| Close Navigation | `CloseButton` | `CupertinoButton` (CupertinoIcons.xmark) | Direct | `AdaptiveCloseButton` |

---

### B. Text Inputs & Forms
| Functionality | Material Widget | Cupertino Widget | Parity Type | Adaptive Resolution |
|---|---|---|---|---|
| Text Field | `TextField` | `CupertinoTextField` | Direct | `AdaptiveTextField` |
| Form Text Field | `TextFormField` | `CupertinoTextFormFieldRow` / `FormField` + `CupertinoTextField` | Direct | `AdaptiveTextFormField` |
| Search Input | `SearchBar` / `TextField` | `CupertinoSearchTextField` | Direct | `AdaptiveSearchField` |
| Password Input | `TextField(obscureText: true)` | `CupertinoTextField(obscureText: true)` | Direct | `AdaptivePasswordField` |
| Form Container | `Form` | `Form` | Direct | `AdaptiveForm` |
| Form Section | `Card` / `Column` | `CupertinoFormSection` | Partial | `AdaptiveFormSection` |
| Form Row | `ListTile` / `Row` | `CupertinoFormRow` | Partial | `AdaptiveFormRow` |

---

### C. Selection & Controls
| Functionality | Material Widget | Cupertino Widget | Parity Type | Adaptive Resolution |
|---|---|---|---|---|
| Checkbox | `Checkbox` | `CupertinoCheckbox` | Direct | `AdaptiveCheckbox` |
| Checkbox List Item | `CheckboxListTile` | `CupertinoListTile` + `CupertinoCheckbox` | Partial | `AdaptiveCheckboxListTile` |
| Radio Button | `Radio<T>` | `CupertinoRadio<T>` | Direct | `AdaptiveRadio<T>` |
| Radio List Item | `RadioListTile<T>` | `CupertinoListTile` + `CupertinoRadio<T>` | Partial | `AdaptiveRadioListTile<T>` |
| Switch / Toggle | `Switch` | `CupertinoSwitch` | Direct | `AdaptiveSwitch` |
| Switch List Item | `SwitchListTile` | `CupertinoListTile` + `CupertinoSwitch` | Partial | `AdaptiveSwitchListTile` |
| Slider | `Slider` | `CupertinoSlider` | Direct | `AdaptiveSlider` |
| Range Slider | `RangeSlider` | Custom Dual Cupertino Slider | Partial | `AdaptiveRangeSlider` |
| Segmented Control | `SegmentedButton<T>` | `CupertinoSlidingSegmentedControl<T>` | Direct | `AdaptiveSegmentedControl<T>` |

---

### D. Overlays: Dialogs & Sheets
| Functionality | Material Widget | Cupertino Widget | Parity Type | Adaptive Resolution |
|---|---|---|---|---|
| Alert Dialog | `AlertDialog` | `CupertinoAlertDialog` | Direct | `AdaptiveAlertDialog` |
| General Dialog | `Dialog` | `CupertinoPopupSurface` | Direct | `AdaptiveDialog` |
| Modal Bottom Sheet | `showModalBottomSheet` | `showCupertinoModalPopup` + `CupertinoActionSheet` | Direct | `AdaptiveBottomSheet` / `AdaptiveModalBottomSheet` |
| Action Sheet | `BottomSheet` / `SimpleDialog` | `CupertinoActionSheet` | Direct | `AdaptiveActionSheet` |

---

### E. Pickers
| Functionality | Material Widget | Cupertino Widget | Parity Type | Adaptive Resolution |
|---|---|---|---|---|
| Date Picker | `showDatePicker` / `CalendarDatePicker` | `CupertinoDatePicker(mode: date)` | Direct | `AdaptiveDatePicker` |
| Time Picker | `showTimePicker` | `CupertinoDatePicker(mode: time)` / `CupertinoTimerPicker` | Direct | `AdaptiveTimePicker` |
| Date & Time Picker | `showDatePicker` + `showTimePicker` | `CupertinoDatePicker(mode: dateAndTime)` | Direct | `AdaptiveDateTimePicker` |
| General Item Picker | `DropdownButton<T>` / `MenuAnchor` | `CupertinoPicker` / `showCupertinoModalPopup` | Partial | `AdaptivePicker<T>` / `AdaptiveChoicePicker<T>` |

---

### F. Navigation & Structure
| Functionality | Material Widget | Cupertino Widget | Parity Type | Adaptive Resolution |
|---|---|---|---|---|
| App Root | `MaterialApp` | `CupertinoApp` | Direct | `AdaptiveApp` / `AdaptiveApp.router` |
| Page Scaffold | `Scaffold` | `CupertinoPageScaffold` | Direct | `AdaptiveScaffold` / `AdaptivePageScaffold` |
| Top Bar | `AppBar` | `CupertinoNavigationBar` | Direct | `AdaptiveAppBar` |
| Bottom Bar | `NavigationBar` / `BottomNavigationBar` | `CupertinoTabBar` | Direct | `AdaptiveBottomNavigationBar` |
| Drawer | `Drawer` | Slide-in drawer with Cupertino styling | Partial | `AdaptiveDrawer` |
| Navigation Rail | `NavigationRail` | Vertical Cupertino tab strip | Partial | `AdaptiveNavigationRail` |
| Tab Bar | `TabBar` | `CupertinoTabBar` / `CupertinoSlidingSegmentedControl` | Direct | `AdaptiveTabBar` |

---

### G. Lists & Scrolling
| Functionality | Material Widget | Cupertino Widget | Parity Type | Adaptive Resolution |
|---|---|---|---|---|
| List Tile | `ListTile` | `CupertinoListTile` | Direct | `AdaptiveListTile` |
| List Section | `Column` / `Card` | `CupertinoListSection` | Direct | `AdaptiveListSection` |
| Scrollbar | `Scrollbar` | `CupertinoScrollbar` | Direct | `AdaptiveScrollbar` |
| Expansion Tile | `ExpansionTile` | Custom Cupertino disclosure tile | Partial | `AdaptiveExpansionTile` |
| Dismissible | `Dismissible` | `Dismissible` (with platform gesture config) | Direct | `AdaptiveDismissible` |
| Refresh Indicator | `RefreshIndicator` | `CupertinoSliverRefreshControl` | Direct | `AdaptiveRefreshIndicator` |

---

### H. Progress & Feedback
| Functionality | Material Widget | Cupertino Widget | Parity Type | Adaptive Resolution |
|---|---|---|---|---|
| Circular Spinner | `CircularProgressIndicator` | `CupertinoActivityIndicator` | Direct | `AdaptiveCircularProgressIndicator` |
| Linear Progress | `LinearProgressIndicator` | Custom smooth iOS progress bar | Partial | `AdaptiveLinearProgressIndicator` |
| SnackBar / Banner | `ScaffoldMessenger.showSnackBar` | Top floating Cupertino HUD capsule | Partial | `AdaptiveSnackBar` / `AdaptiveFeedback` |
| Tooltip | `Tooltip` | `Tooltip` (with Cupertino styled bubble) | Direct | `AdaptiveTooltip` |
| Error / Empty States | Semantic Material layout | Semantic Cupertino layout | Direct | `AdaptiveErrorView` / `AdaptiveEmptyState` |

---

### I. Menus
| Functionality | Material Widget | Cupertino Widget | Parity Type | Adaptive Resolution |
|---|---|---|---|---|
| Context Menu | `showMenu` / `PopupMenuButton` | `CupertinoContextMenu` | Direct | `AdaptiveContextMenu` |
| Popup Menu | `PopupMenuButton<T>` | `CupertinoActionSheet` / `PullDownButton` style | Partial | `AdaptivePopupMenu<T>` |
| Dropdown Menu | `DropdownMenu<T>` | `CupertinoPicker` modal sheet | Partial | `AdaptiveDropdownMenu<T>` |

---

### J. Miscellaneous Core Components
| Functionality | Material Widget | Cupertino Widget | Parity Type | Adaptive Resolution |
|---|---|---|---|---|
| Divider | `Divider` | `Divider` with Cupertino border color | Direct | `AdaptiveDivider` |
| Icon | `Icon(Icons.x)` | `Icon(CupertinoIcons.y)` | Direct | `AdaptiveIcon` |
| Avatar | `CircleAvatar` | Rounded iOS profile clip | Direct | `AdaptiveAvatar` |
| Badge | `Badge` | `Badge` (with iOS pill styling) | Direct | `AdaptiveBadge` |
| Card | `Card` | Rounded Cupertino inset surface | Direct | `AdaptiveCard` |
| Chip | `Chip` / `FilterChip` | Rounded capsule with iOS border | Partial | `AdaptiveChip` |
| Visibility / Safe Area | `Visibility` / `SafeArea` | `Visibility` / `SafeArea` | Direct | `AdaptiveVisibility` / `AdaptiveSafeArea` |
