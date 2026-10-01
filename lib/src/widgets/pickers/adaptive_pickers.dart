import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../core/platform_resolver.dart';

/// Platform-adaptive date picker service.
abstract final class AdaptiveDatePicker {
  /// Displays a date selection modal.
  ///
  /// On Android, displays Material [showDatePicker].
  /// On iOS, presents [CupertinoDatePicker] inside a modal bottom sheet with Done and Cancel controls.
  static Future<DateTime?> show({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    Locale? locale,
    String? helpText,
    String? cancelText,
    String? confirmText,
    AdaptivePlatform? platform,
  }) async {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    final DateTime effectiveFirstDate = firstDate ?? DateTime(1900);
    final DateTime effectiveLastDate = lastDate ?? DateTime(2100);

    if (isCupertino) {
      DateTime tempSelected = initialDate;
      return showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext pickerContext) {
          return Container(
            height: 300,
            color: CupertinoColors.systemBackground.resolveFrom(pickerContext),
            child: Column(
              children: <Widget>[
                Container(
                  color: CupertinoColors.secondarySystemBackground.resolveFrom(pickerContext),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: () => Navigator.of(pickerContext).pop(),
                        child: Text(cancelText ?? 'Cancel'),
                      ),
                      CupertinoButton(
                        onPressed: () => Navigator.of(pickerContext).pop(tempSelected),
                        child: Text(
                          confirmText ?? 'Done',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDate,
                    minimumDate: effectiveFirstDate,
                    maximumDate: effectiveLastDate,
                    onDateTimeChanged: (DateTime newDate) {
                      tempSelected = newDate;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: effectiveFirstDate,
      lastDate: effectiveLastDate,
      currentDate: currentDate,
      locale: locale,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
    );
  }
}

/// Platform-adaptive time picker service.
abstract final class AdaptiveTimePicker {
  /// Displays a time selection modal.
  ///
  /// On Android, displays Material [showTimePicker].
  /// On iOS, displays [CupertinoDatePicker] in time mode with modal sheet controls.
  static Future<TimeOfDay?> show({
    required BuildContext context,
    required TimeOfDay initialTime,
    bool use24HourFormat = false,
    String? helpText,
    String? cancelText,
    String? confirmText,
    AdaptivePlatform? platform,
  }) async {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      final DateTime now = DateTime.now();
      DateTime tempSelected = DateTime(now.year, now.month, now.day, initialTime.hour, initialTime.minute);

      final DateTime? result = await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext pickerContext) {
          return Container(
            height: 300,
            color: CupertinoColors.systemBackground.resolveFrom(pickerContext),
            child: Column(
              children: <Widget>[
                Container(
                  color: CupertinoColors.secondarySystemBackground.resolveFrom(pickerContext),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: () => Navigator.of(pickerContext).pop(),
                        child: Text(cancelText ?? 'Cancel'),
                      ),
                      CupertinoButton(
                        onPressed: () => Navigator.of(pickerContext).pop(tempSelected),
                        child: Text(
                          confirmText ?? 'Done',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: use24HourFormat,
                    initialDateTime: tempSelected,
                    onDateTimeChanged: (DateTime newDateTime) {
                      tempSelected = newDateTime;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );

      if (result != null) {
        return TimeOfDay(hour: result.hour, minute: result.minute);
      }
      return null;
    }

    return showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
    );
  }
}

/// Platform-adaptive date and time picker.
abstract final class AdaptiveDateTimePicker {
  /// Displays a date and time selector.
  static Future<DateTime?> show({
    required BuildContext context,
    required DateTime initialDateTime,
    DateTime? firstDate,
    DateTime? lastDate,
    bool use24HourFormat = false,
    String? cancelText,
    String? confirmText,
    AdaptivePlatform? platform,
  }) async {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    final DateTime effectiveFirstDate = firstDate ?? DateTime(1900);
    final DateTime effectiveLastDate = lastDate ?? DateTime(2100);

    if (isCupertino) {
      DateTime tempSelected = initialDateTime;
      return showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext pickerContext) {
          return Container(
            height: 320,
            color: CupertinoColors.systemBackground.resolveFrom(pickerContext),
            child: Column(
              children: <Widget>[
                Container(
                  color: CupertinoColors.secondarySystemBackground.resolveFrom(pickerContext),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: () => Navigator.of(pickerContext).pop(),
                        child: Text(cancelText ?? 'Cancel'),
                      ),
                      CupertinoButton(
                        onPressed: () => Navigator.of(pickerContext).pop(tempSelected),
                        child: Text(
                          confirmText ?? 'Done',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    use24hFormat: use24HourFormat,
                    initialDateTime: initialDateTime,
                    minimumDate: effectiveFirstDate,
                    maximumDate: effectiveLastDate,
                    onDateTimeChanged: (DateTime newDateTime) {
                      tempSelected = newDateTime;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: effectiveFirstDate,
      lastDate: effectiveLastDate,
      cancelText: cancelText,
      confirmText: confirmText,
    );

    if (pickedDate == null || !context.mounted) return null;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDateTime),
      cancelText: cancelText,
      confirmText: confirmText,
    );

    if (pickedTime == null) return null;

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }
}

/// Platform-adaptive inline calendar view.
class AdaptiveCalendar extends StatelessWidget {
  /// Creates an [AdaptiveCalendar].
  const AdaptiveCalendar({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateChanged,
    this.platform,
  });

  /// The currently focused date.
  final DateTime initialDate;

  /// The earliest selectable date.
  final DateTime firstDate;

  /// The latest selectable date.
  final DateTime lastDate;

  /// Callback when date changes.
  final ValueChanged<DateTime> onDateChanged;

  /// Platform override.
  final AdaptivePlatform? platform;

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      return SizedBox(
        height: 240,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: initialDate,
          minimumDate: firstDate,
          maximumDate: lastDate,
          onDateTimeChanged: onDateChanged,
        ),
      );
    }

    return CalendarDatePicker(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onDateChanged: onDateChanged,
    );
  }
}

/// Platform-adaptive countdown / timer picker.
abstract final class AdaptiveTimerPicker {
  /// Displays a timer / duration selection dialog.
  static Future<Duration?> show({
    required BuildContext context,
    Duration initialDuration = Duration.zero,
    String? cancelText,
    String? confirmText,
    AdaptivePlatform? platform,
  }) async {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    if (isCupertino) {
      Duration tempDuration = initialDuration;
      return showCupertinoModalPopup<Duration>(
        context: context,
        builder: (BuildContext pickerContext) {
          return Container(
            height: 280,
            color: CupertinoColors.systemBackground.resolveFrom(pickerContext),
            child: Column(
              children: <Widget>[
                Container(
                  color: CupertinoColors.secondarySystemBackground.resolveFrom(pickerContext),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: () => Navigator.of(pickerContext).pop(),
                        child: Text(cancelText ?? 'Cancel'),
                      ),
                      CupertinoButton(
                        onPressed: () => Navigator.of(pickerContext).pop(tempDuration),
                        child: Text(
                          confirmText ?? 'Done',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoTimerPicker(
                    initialTimerDuration: initialDuration,
                    onTimerDurationChanged: (Duration d) {
                      tempDuration = d;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    // Material duration picker modal
    int minutes = initialDuration.inMinutes;
    return showDialog<Duration>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState) {
            return AlertDialog(
              title: const Text('Select Duration'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: minutes > 0 ? () => setState(() => minutes -= 5) : null,
                  ),
                  Text('$minutes mins', style: Theme.of(ctx).textTheme.titleLarge),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => minutes += 5),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(cancelText ?? 'Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(Duration(minutes: minutes)),
                  child: Text(confirmText ?? 'Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

/// Generic platform-adaptive item picker.
///
/// On iOS, opens a [CupertinoPicker] inside a modal popup.
/// On Android, displays a selection dialog or dropdown.
abstract final class AdaptivePicker {
  /// Presents an adaptive wheel/list picker.
  static Future<T?> show<T>({
    required BuildContext context,
    required List<T> items,
    required Widget Function(T item) itemBuilder,
    T? selectedItem,
    String? cancelText,
    String? confirmText,
    AdaptivePlatform? platform,
  }) async {
    final bool isCupertino = PlatformResolver.isCupertino(context, widgetOverride: platform);

    int initialIndex = selectedItem != null ? items.indexOf(selectedItem) : 0;
    if (initialIndex < 0) initialIndex = 0;

    if (isCupertino) {
      int tempIndex = initialIndex;
      final int? resultIndex = await showCupertinoModalPopup<int>(
        context: context,
        builder: (BuildContext pickerContext) {
          return Container(
            height: 280,
            color: CupertinoColors.systemBackground.resolveFrom(pickerContext),
            child: Column(
              children: <Widget>[
                Container(
                  color: CupertinoColors.secondarySystemBackground.resolveFrom(pickerContext),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: () => Navigator.of(pickerContext).pop(),
                        child: Text(cancelText ?? 'Cancel'),
                      ),
                      CupertinoButton(
                        onPressed: () => Navigator.of(pickerContext).pop(tempIndex),
                        child: Text(
                          confirmText ?? 'Done',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 36,
                    scrollController: FixedExtentScrollController(initialItem: initialIndex),
                    onSelectedItemChanged: (int index) {
                      tempIndex = index;
                    },
                    children: items.map((T item) => Center(child: itemBuilder(item))).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      );

      if (resultIndex != null && resultIndex >= 0 && resultIndex < items.length) {
        return items[resultIndex];
      }
      return null;
    }

    return showDialog<T>(
      context: context,
      builder: (BuildContext dialogContext) {
        return SimpleDialog(
          title: const Text('Select Option'),
          children: items.map((T item) {
            return SimpleDialogOption(
              onPressed: () => Navigator.of(dialogContext).pop(item),
              child: itemBuilder(item),
            );
          }).toList(),
        );
      },
    );
  }
}
