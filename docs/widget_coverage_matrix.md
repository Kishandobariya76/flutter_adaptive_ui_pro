# Widget Coverage Matrix

This matrix documents the complete inventory of adaptive widgets provided by `flutter_adaptive_ui_pro`, their backing implementations per platform, behavioral specifics, and validation status.

## Coverage Summary Table

| Adaptive Widget | Material Implementation | Cupertino Implementation | Android | iOS | Web/Desktop | Status |
|---|---|---|---|---|---|---|
| **Buttons** | | | | | | |
| `AdaptiveButton` | `FilledButton` / `ElevatedButton` | `CupertinoButton.filled` / `CupertinoButton` | Material | Cupertino | Material | Complete |
| `AdaptiveElevatedButton` | `ElevatedButton` | `CupertinoButton` with surface elevation | Material | Cupertino | Material | Complete |
| `AdaptiveFilledButton` | `FilledButton` | `CupertinoButton.filled` | Material | Cupertino | Material | Complete |
| `AdaptiveFilledTonalButton`| `FilledButton.tonal` | `CupertinoButton` with system grey background | Material | Cupertino | Material | Complete |
| `AdaptiveOutlinedButton` | `OutlinedButton` | `CupertinoButton` with border outline | Material | Cupertino | Material | Complete |
| `AdaptiveTextButton` | `TextButton` | `CupertinoButton` (borderless/plain) | Material | Cupertino | Material | Complete |
| `AdaptiveIconButton` | `IconButton` | `CupertinoButton` with icon child & tight padding | Material | Cupertino | Material | Complete |
| `AdaptiveFloatingActionButton`| `FloatingActionButton` | Elevated circular iOS surface with shadow | Material | Cupertino | Material | Complete |
| `AdaptiveBackButton` | `BackButton` | `CupertinoNavigationBarBackButton` | Material | Cupertino | Material | Complete |
| `AdaptiveCloseButton` | `CloseButton` | `CupertinoButton` with close symbol | Material | Cupertino | Material | Complete |
| **Inputs & Forms** | | | | | | |
| `AdaptiveTextField` | `TextField` | `CupertinoTextField` | Material | Cupertino | Material | Complete |
| `AdaptiveTextFormField` | `TextFormField` | `FormField` + `CupertinoTextField` with validation | Material | Cupertino | Material | Complete |
| `AdaptiveSearchField` | `SearchBar` / `TextField` | `CupertinoSearchTextField` | Material | Cupertino | Material | Complete |
| `AdaptivePasswordField` | `TextField` (obscured) | `CupertinoTextField` (obscured) with toggle | Material | Cupertino | Material | Complete |
| `AdaptiveForm` | `Form` | `Form` | Material | Cupertino | Material | Complete |
| `AdaptiveFormSection` | `Card` / Grouped Column | `CupertinoFormSection` | Material | Cupertino | Material | Complete |
| `AdaptiveFormRow` | `ListTile` / Grouped Row | `CupertinoFormRow` | Material | Cupertino | Material | Complete |
| **Selection & Controls**| | | | | | |
| `AdaptiveCheckbox` | `Checkbox` | `CupertinoCheckbox` | Material | Cupertino | Material | Complete |
| `AdaptiveCheckboxListTile`| `CheckboxListTile` | `CupertinoListTile` + `CupertinoCheckbox` | Material | Cupertino | Material | Complete |
| `AdaptiveRadio<T>` | `Radio<T>` | `CupertinoRadio<T>` | Material | Cupertino | Material | Complete |
| `AdaptiveRadioListTile<T>`| `RadioListTile<T>` | `CupertinoListTile` + `CupertinoRadio<T>` | Material | Cupertino | Material | Complete |
| `AdaptiveSwitch` | `Switch` | `CupertinoSwitch` | Material | Cupertino | Material | Complete |
| `AdaptiveSwitchListTile` | `SwitchListTile` | `CupertinoListTile` + `CupertinoSwitch` | Material | Cupertino | Material | Complete |
| `AdaptiveSlider` | `Slider` | `CupertinoSlider` | Material | Cupertino | Material | Complete |
| `AdaptiveRangeSlider` | `RangeSlider` | Dual iOS slider with thumb sync | Material | Cupertino | Material | Complete |
| `AdaptiveSegmentedControl<T>`| `SegmentedButton<T>` | `CupertinoSlidingSegmentedControl<T>` | Material | Cupertino | Material | Complete |
| **Dialogs & Overlays** | | | | | | |
| `AdaptiveDialog` | `Dialog` / `showDialog` | `CupertinoDialog` / `showCupertinoDialog` | Material | Cupertino | Material | Complete |
| `AdaptiveAlertDialog` | `AlertDialog` | `CupertinoAlertDialog` | Material | Cupertino | Material | Complete |
| `AdaptiveConfirmDialog` | `AlertDialog` (Confirm/Cancel) | `CupertinoAlertDialog` (Confirm/Cancel) | Material | Cupertino | Material | Complete |
| `AdaptiveInputDialog` | `AlertDialog` with TextField | `CupertinoAlertDialog` with text field | Material | Cupertino | Material | Complete |
| `AdaptiveCustomDialog` | Generic modal route | Cupertino modal surface | Material | Cupertino | Material | Complete |
| **Sheets & Menus** | | | | | | |
| `AdaptiveBottomSheet` | `showModalBottomSheet` | `showCupertinoModalPopup` + ActionSheet | Material | Cupertino | Material | Complete |
| `AdaptiveModalBottomSheet`| `BottomSheet` container | Cupertino sheet container | Material | Cupertino | Material | Complete |
| `AdaptiveActionSheet` | `showModalBottomSheet` actions | `CupertinoActionSheet` | Material | Cupertino | Material | Complete |
| `AdaptiveContextMenu` | Material Context Menu / Popup | `CupertinoContextMenu` | Material | Cupertino | Material | Complete |
| `AdaptivePopupMenu<T>` | `PopupMenuButton<T>` | `CupertinoActionSheet` / Popover | Material | Cupertino | Material | Complete |
| `AdaptiveDropdown<T>` | `DropdownButton<T>` | `CupertinoPicker` modal popup | Material | Cupertino | Material | Complete |
| `AdaptiveDropdownButton<T>`| `DropdownButton<T>` | Action sheet picker button | Material | Cupertino | Material | Complete |
| `AdaptiveDropdownMenu<T>` | `DropdownMenu<T>` | Action sheet picker / Cupertino sheet | Material | Cupertino | Material | Complete |
| `AdaptivePicker<T>` | Material Dialog / Dropdown | `CupertinoPicker` in modal popup | Material | Cupertino | Material | Complete |
| `AdaptiveChoicePicker<T>` | Material Radio / Chip list | `CupertinoPicker` / segmented picker | Material | Cupertino | Material | Complete |
| **Date & Time Pickers** | | | | | | |
| `AdaptiveDatePicker` | `showDatePicker` | `CupertinoDatePicker(mode: date)` | Material | Cupertino | Material | Complete |
| `AdaptiveTimePicker` | `showTimePicker` | `CupertinoDatePicker(mode: time)` | Material | Cupertino | Material | Complete |
| `AdaptiveDateTimePicker` | Date & Time Dialog | `CupertinoDatePicker(mode: dateAndTime)` | Material | Cupertino | Material | Complete |
| `AdaptiveCalendar` | `CalendarDatePicker` | `CupertinoDatePicker` inline | Material | Cupertino | Material | Complete |
| `AdaptiveTimerPicker` | Material Duration picker | `CupertinoTimerPicker` | Material | Cupertino | Material | Complete |
| **Navigation & Scaffolding**| | | | | | |
| `AdaptiveApp` | `MaterialApp` | `CupertinoApp` | Material | Cupertino | Material | Complete |
| `AdaptiveApp.router` | `MaterialApp.router` | `CupertinoApp.router` | Material | Cupertino | Material | Complete |
| `AdaptiveScaffold` | `Scaffold` | `CupertinoPageScaffold` | Material | Cupertino | Material | Complete |
| `AdaptivePageScaffold` | `Scaffold` | `CupertinoPageScaffold` | Material | Cupertino | Material | Complete |
| `AdaptiveAppBar` | `AppBar` | `CupertinoNavigationBar` | Material | Cupertino | Material | Complete |
| `AdaptiveNavigationBar` | `NavigationBar` | `CupertinoTabBar` | Material | Cupertino | Material | Complete |
| `AdaptiveBottomNavigationBar`| `BottomNavigationBar` | `CupertinoTabBar` | Material | Cupertino | Material | Complete |
| `AdaptiveTabBar` | `TabBar` | `CupertinoSlidingSegmentedControl` / TabBar | Material | Cupertino | Material | Complete |
| `AdaptiveNavigationRail` | `NavigationRail` | Cupertino vertical icon bar | Material | Cupertino | Material | Complete |
| `AdaptiveDrawer` | `Drawer` | Cupertino blur slide drawer | Material | Cupertino | Material | Complete |
| **Lists & Scrolling** | | | | | | |
| `AdaptiveListTile` | `ListTile` | `CupertinoListTile` | Material | Cupertino | Material | Complete |
| `AdaptiveListSection` | Grouped Card / Column | `CupertinoListSection` | Material | Cupertino | Material | Complete |
| `AdaptiveListView` | `ListView` | `ListView` with Cupertino physics | Material | Cupertino | Material | Complete |
| `AdaptiveExpansionTile` | `ExpansionTile` | Custom Cupertino disclosure tile | Material | Cupertino | Material | Complete |
| `AdaptiveDismissible` | `Dismissible` (standard) | `Dismissible` (Cupertino spring curve) | Material | Cupertino | Material | Complete |
| `AdaptiveScrollbar` | `Scrollbar` | `CupertinoScrollbar` | Material | Cupertino | Material | Complete |
| `AdaptiveRefreshIndicator` | `RefreshIndicator` | `CustomScrollView` + `CupertinoSliverRefreshControl` | Material | Cupertino | Material | Complete |
| **Progress & Indicators**| | | | | | |
| `AdaptiveCircularProgressIndicator`| `CircularProgressIndicator` | `CupertinoActivityIndicator` | Material | Cupertino | Material | Complete |
| `AdaptiveLinearProgressIndicator` | `LinearProgressIndicator` | Rounded smooth iOS progress capsule | Material | Cupertino | Material | Complete |
| `AdaptiveLoadingIndicator`| `CircularProgressIndicator` | `CupertinoActivityIndicator` | Material | Cupertino | Material | Complete |
| **Feedback & States** | | | | | | |
| `AdaptiveSnackBar` | `ScaffoldMessenger` SnackBar | Floating iOS top notification HUD | Material | Cupertino | Material | Complete |
| `AdaptiveToast` | Floating Material SnackBar | Centered / Top iOS translucent pill | Material | Cupertino | Material | Complete |
| `AdaptiveBanner` | `MaterialBanner` | iOS rounded notification banner | Material | Cupertino | Material | Complete |
| `AdaptiveTooltip` | `Tooltip` | `Tooltip` with Cupertino bubble theme | Material | Cupertino | Material | Complete |
| `AdaptiveErrorView` | Material error display card | iOS error display card | Material | Cupertino | Material | Complete |
| `AdaptiveEmptyState` | Material empty illustration card | iOS empty illustration card | Material | Cupertino | Material | Complete |
| `AdaptiveLoadingView` | Material centered progress view | iOS centered activity indicator view | Material | Cupertino | Material | Complete |
| **Miscellaneous** | | | | | | |
| `AdaptiveDivider` | `Divider` | `Divider` with iOS separator color | Material | Cupertino | Material | Complete |
| `AdaptiveIcon` | `Icon` (Material IconData) | `Icon` (Cupertino IconData) | Material | Cupertino | Material | Complete |
| `AdaptiveAvatar` | `CircleAvatar` | Rounded iOS profile image surface | Material | Cupertino | Material | Complete |
| `AdaptiveBadge` | `Badge` | `Badge` with iOS pill styling | Material | Cupertino | Material | Complete |
| `AdaptiveChip` | `Chip` | iOS capsule button / badge | Material | Cupertino | Material | Complete |
| `AdaptiveCard` | `Card` with elevation | Inset surface with rounded border | Material | Cupertino | Material | Complete |
| `AdaptiveExpansionPanel`| `ExpansionPanelList` | Cupertino grouped expandable list | Material | Cupertino | Material | Complete |
| `AdaptiveScrollBehavior`| Material scroll physics | Cupertino bouncy physics | Material | Cupertino | Material | Complete |
| `AdaptiveSafeArea` | `SafeArea` | `SafeArea` | Material | Cupertino | Material | Complete |
| `AdaptiveVisibility` | `Visibility` | `Visibility` | Material | Cupertino | Material | Complete |
| **Theme System** | | | | | | |
| `AdaptiveTheme` | Injects `Theme` (`ThemeData`) | Injects `CupertinoTheme` (`CupertinoThemeData`) | Dual | Dual | Dual | Complete |
| `AdaptiveThemeData` | Material config bridge | Cupertino config bridge | Dual | Dual | Dual | Complete |
| `AdaptiveConfig` | Platform resolution scope | Platform resolution scope | All | All | All | Complete |
