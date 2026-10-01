import 'package:flutter/material.dart';
import 'package:flutter_adaptive_ui_pro/flutter_adaptive_ui_pro.dart';

void main(List<String> args) {
  int initialTab = 0;
  if (args.isNotEmpty) {
    initialTab = int.tryParse(args.first) ?? 0;
  }
  runApp(ShowcaseApp(initialTab: initialTab));
}

/// Root showcase application demonstrating flutter_adaptive_ui_pro components.
class ShowcaseApp extends StatefulWidget {
  /// Creates the [ShowcaseApp].
  const ShowcaseApp({super.key, this.initialTab = 0});

  /// The initial navigation tab index.
  final int initialTab;

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  AdaptivePlatform _currentPlatform = AdaptivePlatform.adaptive;
  bool _isDarkMode = false;

  void _setPlatform(AdaptivePlatform platform) {
    setState(() {
      _currentPlatform = platform;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AdaptiveThemeData themeData = _isDarkMode
        ? AdaptiveThemeData.dark(platform: _currentPlatform)
        : AdaptiveThemeData.light(platform: _currentPlatform);

    return AdaptiveConfig(
      platform: _currentPlatform,
      child: AdaptiveTheme(
        data: themeData,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Adaptive UI Pro Showcase',
          theme: themeData.materialTheme,
          home: ShowcaseHome(
            initialTab: widget.initialTab,
            currentPlatform: _currentPlatform,
            isDarkMode: _isDarkMode,
            onPlatformChanged: _setPlatform,
            onToggleDarkMode: _toggleDarkMode,
          ),
        ),
      ),
    );
  }
}

/// Main showcase home screen.
class ShowcaseHome extends StatefulWidget {
  /// Creates a [ShowcaseHome].
  const ShowcaseHome({
    super.key,
    this.initialTab = 0,
    required this.currentPlatform,
    required this.isDarkMode,
    required this.onPlatformChanged,
    required this.onToggleDarkMode,
  });

  /// The initial navigation tab index.
  final int initialTab;

  /// Active platform override.
  final AdaptivePlatform currentPlatform;

  /// Whether dark mode is enabled.
  final bool isDarkMode;

  /// Callback when platform selection changes.
  final ValueChanged<AdaptivePlatform> onPlatformChanged;

  /// Callback when dark mode is toggled.
  final VoidCallback onToggleDarkMode;

  @override
  State<ShowcaseHome> createState() => _ShowcaseHomeState();
}

class _ShowcaseHomeState extends State<ShowcaseHome> {
  late int _selectedNavIndex = widget.initialTab == 5 ? 4 : widget.initialTab;

  @override
  void initState() {
    super.initState();
    if (widget.initialTab == 5) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AdaptiveDialog.confirm(
          context: context,
          title: 'Discard Changes?',
          message: 'Any unsaved input will be permanently lost.',
          confirmText: 'Discard',
          isDestructive: true,
        );
      });
    }
  }

  // Selection states
  bool _switchValue = true;
  bool? _checkboxValue = true;
  int _radioValue = 1;
  double _sliderValue = 0.6;
  int _segmentedValue = 0;
  String _dropdownValue = 'Flutter';

  // Form states
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController(text: 'Antigravity Adaptive UI');
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCupertino = context.isCupertino;
    final String resolvedMode = isCupertino ? 'Cupertino (iOS HIG)' : 'Material Design 3';

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        titleText: 'Adaptive UI Pro',
        actions: <Widget>[
          AdaptiveIconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Toggle Theme Mode',
            onPressed: widget.onToggleDarkMode,
          ),
        ],
      ),
      bottomNavigationBar: AdaptiveBottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: (int index) => setState(() => _selectedNavIndex = index),
        items: const <AdaptiveNavigationItem>[
          AdaptiveNavigationItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Overview',
          ),
          AdaptiveNavigationItem(
            icon: Icon(Icons.smart_button_outlined),
            activeIcon: Icon(Icons.smart_button),
            label: 'Buttons',
          ),
          AdaptiveNavigationItem(
            icon: Icon(Icons.input_outlined),
            activeIcon: Icon(Icons.input),
            label: 'Forms',
          ),
          AdaptiveNavigationItem(
            icon: Icon(Icons.tune_outlined),
            activeIcon: Icon(Icons.tune),
            label: 'Controls',
          ),
          AdaptiveNavigationItem(
            icon: Icon(Icons.more_horiz_outlined),
            activeIcon: Icon(Icons.more_horiz),
            label: 'Overlays',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedNavIndex,
        children: <Widget>[
          _buildOverviewTab(resolvedMode),
          _buildButtonsTab(),
          _buildFormsTab(),
          _buildControlsTab(),
          _buildOverlaysTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(String resolvedMode) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        AdaptiveCard(
          color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  AdaptiveAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.auto_awesome, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'flutter_adaptive_ui_pro',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Production-Grade Cross-Platform UI Engine',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const AdaptiveDivider(),
              const SizedBox(height: 12),
              _buildInfoRow('Detected OS Target:', PlatformDetector.platformName),
              const SizedBox(height: 6),
              _buildInfoRow('Active UI Mode:', resolvedMode),
              const SizedBox(height: 6),
              _buildInfoRow('Engine Architecture:', 'Pure Flutter (Zero Native Channels)'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Runtime Platform Override',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AdaptiveSegmentedControl<AdaptivePlatform>(
          groupValue: widget.currentPlatform,
          onValueChanged: (AdaptivePlatform? p) {
            if (p != null) widget.onPlatformChanged(p);
          },
          children: const <AdaptivePlatform, Widget>{
            AdaptivePlatform.adaptive: Text('Adaptive'),
            AdaptivePlatform.material: Text('Material'),
            AdaptivePlatform.cupertino: Text('Cupertino'),
          },
        ),
        const SizedBox(height: 24),
        AdaptiveListSection(
          header: const Text('Package Highlights'),
          children: <Widget>[
            const AdaptiveListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text('Zero Native iOS Pods / Kotlin'),
              subtitle: Text('Runs universally on Web, Mobile & Desktop'),
            ),
            const AdaptiveListTile(
              leading: Icon(Icons.tune, color: Colors.blue),
              title: Text('5-Step Resolution Cascade'),
              subtitle: Text('Widget override → Config → Theme → OS → Fallback'),
            ),
            AdaptiveListTile(
              leading: const Icon(Icons.accessibility_new, color: Colors.purple),
              title: const Text('Verified Accessibility'),
              subtitle: const Text('Semantics, text scaling & RTL support'),
              trailing: const AdaptiveBadge(label: 'PRO', isLarge: true),
              onTap: () {
                AdaptiveSnackBar.show(
                  context,
                  message: 'Full accessibility compliance verified!',
                  type: AdaptiveFeedbackType.success,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonsTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        const Text('Button System Variants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            AdaptiveButton(
              label: 'Filled Button',
              icon: const Icon(Icons.done, size: 18),
              onPressed: () {
                AdaptiveSnackBar.show(context, message: 'Filled Button Pressed!', type: AdaptiveFeedbackType.success);
              },
            ),
            AdaptiveButton.tonal(
              label: 'Tonal Button',
              onPressed: () {},
            ),
            AdaptiveButton.elevated(
              label: 'Elevated Button',
              onPressed: () {},
            ),
            AdaptiveButton.outlined(
              label: 'Outlined Button',
              onPressed: () {},
            ),
            AdaptiveButton.text(
              label: 'Text Button',
              onPressed: () {},
            ),
            AdaptiveButton(
              label: 'Disabled',
              enabled: false,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Icon & Navigation Buttons', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AdaptiveIconButton(
              icon: const Icon(Icons.favorite),
              tooltip: 'Favorite',
              onPressed: () {
                AdaptiveSnackBar.show(context, message: 'Favorited!', type: AdaptiveFeedbackType.info);
              },
            ),
            AdaptiveIconButton(
              icon: const Icon(Icons.share),
              tooltip: 'Share',
              onPressed: () {},
            ),
            const AdaptiveBackButton(),
            const AdaptiveCloseButton(),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Chips & Badges', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            AdaptiveChip(
              label: const Text('Interactive Chip'),
              selected: true,
              onPressed: () {},
            ),
            AdaptiveChip(
              label: const Text('Deletable Chip'),
              onDeleted: () {},
            ),
            const AdaptiveBadge(
              count: 7,
              child: Icon(Icons.notifications, size: 28),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormsTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        const Text('Adaptive Inputs & Form Validation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        AdaptiveForm(
          formKey: _formKey,
          child: Column(
            children: <Widget>[
              AdaptiveTextField(
                controller: _textController,
                label: 'Name or Title',
                placeholder: 'Enter full name',
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 16),
              AdaptiveTextFormField(
                label: 'Email Address',
                placeholder: 'user@example.com',
                prefixIcon: const Icon(Icons.email),
                validator: (String? val) {
                  if (val == null || !val.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AdaptivePasswordField(
                controller: _passwordController,
                label: 'Account Password',
                placeholder: 'Enter password',
                validator: (String? val) {
                  if (val == null || val.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AdaptiveSearchField(
                placeholder: 'Search library...',
                onChanged: (String v) {},
              ),
              const SizedBox(height: 20),
              AdaptiveButton(
                label: 'Validate & Save Form',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    AdaptiveSnackBar.show(
                      context,
                      message: 'Form Validated Successfully!',
                      type: AdaptiveFeedbackType.success,
                    );
                  } else {
                    AdaptiveSnackBar.show(
                      context,
                      message: 'Please resolve form validation errors.',
                      type: AdaptiveFeedbackType.error,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        AdaptiveFormSection(
          header: const Text('Grouped Inset Settings'),
          children: <Widget>[
            AdaptiveFormRow(
              prefix: const Text('Notifications'),
              child: Align(
                alignment: Alignment.centerRight,
                child: AdaptiveSwitch(
                  value: _switchValue,
                  onChanged: (bool v) => setState(() => _switchValue = v),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildControlsTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        const Text('Selection Controls & Sliders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        AdaptiveSwitchListTile(
          title: const Text('Push Notifications'),
          subtitle: const Text('Receive instant alerts and updates'),
          value: _switchValue,
          onChanged: (bool v) => setState(() => _switchValue = v),
        ),
        AdaptiveCheckboxListTile(
          title: const Text('Accept Terms & Privacy'),
          subtitle: const Text('Required for account creation'),
          value: _checkboxValue,
          onChanged: (bool? v) => setState(() => _checkboxValue = v),
        ),
        AdaptiveRadioListTile<int>(
          title: const Text('Priority Standard'),
          value: 1,
          groupValue: _radioValue,
          onChanged: (int? v) => setState(() => _radioValue = v ?? 1),
        ),
        AdaptiveRadioListTile<int>(
          title: const Text('Priority Express'),
          value: 2,
          groupValue: _radioValue,
          onChanged: (int? v) => setState(() => _radioValue = v ?? 2),
        ),
        const SizedBox(height: 16),
        Text('Volume Level: ${(_sliderValue * 100).toInt()}%'),
        AdaptiveSlider(
          value: _sliderValue,
          onChanged: (double v) => setState(() => _sliderValue = v),
        ),
        const SizedBox(height: 16),
        const Text('Segmented Control:'),
        const SizedBox(height: 8),
        AdaptiveSegmentedControl<int>(
          groupValue: _segmentedValue,
          onValueChanged: (int? v) => setState(() => _segmentedValue = v ?? 0),
          children: const <int, Widget>{
            0: Text('Daily'),
            1: Text('Weekly'),
            2: Text('Monthly'),
          },
        ),
        const SizedBox(height: 24),
        const Text('Progress & Indicators', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AdaptiveCircularProgressIndicator(),
            AdaptiveCircularProgressIndicator(value: 0.75),
          ],
        ),
        const SizedBox(height: 16),
        AdaptiveLinearProgressIndicator(value: _sliderValue),
      ],
    );
  }

  Widget _buildOverlaysTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        const Text('Dialogs, Sheets & Pickers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            AdaptiveButton(
              label: 'Confirm Dialog',
              onPressed: () async {
                final bool confirmed = await AdaptiveDialog.confirm(
                  context: context,
                  title: 'Discard Changes?',
                  message: 'Any unsaved input will be permanently lost.',
                  confirmText: 'Discard',
                  isDestructive: true,
                );
                if (!mounted) return;
                AdaptiveSnackBar.show(
                  context,
                  message: confirmed ? 'Confirmed discard.' : 'Cancelled.',
                  type: confirmed ? AdaptiveFeedbackType.warning : AdaptiveFeedbackType.info,
                );
              },
            ),
            AdaptiveButton.tonal(
              label: 'Action Sheet',
              onPressed: () async {
                final String? action = await AdaptiveActionSheet.show<String>(
                  context: context,
                  titleText: 'Photo Options',
                  messageText: 'Choose how to upload your avatar',
                  actions: const <AdaptiveSheetAction<String>>[
                    AdaptiveSheetAction<String>(title: 'Take Photo', icon: Icon(Icons.camera_alt), value: 'camera'),
                    AdaptiveSheetAction<String>(title: 'Choose from Gallery', icon: Icon(Icons.photo_library), value: 'gallery'),
                    AdaptiveSheetAction<String>(title: 'Delete Photo', value: 'delete', isDestructive: true),
                  ],
                );
                if (!mounted) return;
                if (action != null) {
                  AdaptiveSnackBar.show(context, message: 'Selected: $action');
                }
              },
            ),
            AdaptiveButton.outlined(
              label: 'Date Picker',
              onPressed: () async {
                final DateTime? picked = await AdaptiveDatePicker.show(
                  context: context,
                  initialDate: DateTime.now(),
                );
                if (!mounted) return;
                if (picked != null) {
                  AdaptiveSnackBar.show(
                    context,
                    message: 'Selected: ${picked.toLocal().toString().split(' ')[0]}',
                    type: AdaptiveFeedbackType.success,
                  );
                }
              },
            ),
            AdaptiveButton.outlined(
              label: 'Time Picker',
              onPressed: () async {
                final TimeOfDay? time = await AdaptiveTimePicker.show(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (!mounted) return;
                if (time != null) {
                  AdaptiveSnackBar.show(
                    context,
                    message: 'Time: ${time.format(context)}',
                    type: AdaptiveFeedbackType.info,
                  );
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Dropdown & Popup Menus', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AdaptiveDropdown<String>(
              value: _dropdownValue,
              onChanged: (String? val) {
                if (val != null) setState(() => _dropdownValue = val);
              },
              items: const <AdaptiveMenuItem<String>>[
                AdaptiveMenuItem<String>(value: 'Flutter', label: 'Flutter'),
                AdaptiveMenuItem<String>(value: 'Dart', label: 'Dart'),
                AdaptiveMenuItem<String>(value: 'Adaptive UI', label: 'Adaptive UI Pro'),
              ],
            ),
            AdaptivePopupMenu<String>(
              onSelected: (String val) {
                AdaptiveSnackBar.show(context, message: 'Selected Menu: $val');
              },
              items: const <AdaptiveMenuItem<String>>[
                AdaptiveMenuItem<String>(value: 'edit', label: 'Edit Document'),
                AdaptiveMenuItem<String>(value: 'share', label: 'Share Link'),
                AdaptiveMenuItem<String>(value: 'delete', label: 'Delete Item'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text('Context Menu (Long Press)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        AdaptiveContextMenu(
          actions: <AdaptiveContextAction>[
            AdaptiveContextAction(
              title: 'Copy',
              onPressed: () => AdaptiveSnackBar.show(context, message: 'Copied to clipboard'),
            ),
            AdaptiveContextAction(
              title: 'Delete',
              isDestructive: true,
              onPressed: () => AdaptiveSnackBar.show(context, message: 'Deleted', type: AdaptiveFeedbackType.error),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: const Center(
              child: Text('Long press here for Adaptive Context Menu', style: TextStyle(fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ],
    );
  }
}
