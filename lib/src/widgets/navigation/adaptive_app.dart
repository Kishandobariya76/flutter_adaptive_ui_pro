import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/adaptive_platform.dart';
import '../../theme/adaptive_theme.dart';
import '../../theme/adaptive_theme_data.dart';

/// Top-level platform-adaptive application container.
///
/// Automatically bridges [MaterialApp] and [CupertinoApp] styles and injects
/// [AdaptiveTheme] so that both Material and Cupertino widgets co-exist seamlessly.
class AdaptiveApp extends StatelessWidget {
  /// Creates a standard [AdaptiveApp].
  const AdaptiveApp({
    super.key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowCheckedModeBanner = true,
    this.platform = AdaptivePlatform.adaptive,
  }) : routerConfig = null;

  /// Creates an [AdaptiveApp] that uses the [Router] API.
  const AdaptiveApp.router({
    super.key,
    this.routerConfig,
    this.builder,
    this.title = '',
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowCheckedModeBanner = true,
    this.platform = AdaptivePlatform.adaptive,
  })  : navigatorKey = null,
        home = null,
        routes = const <String, WidgetBuilder>{},
        initialRoute = null,
        onGenerateRoute = null,
        onUnknownRoute = null,
        navigatorObservers = const <NavigatorObserver>[];

  /// Navigator key.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// Default home widget.
  final Widget? home;

  /// Named routes table.
  final Map<String, WidgetBuilder> routes;

  /// Initial route path.
  final String? initialRoute;

  /// Route generator callback.
  final RouteFactory? onGenerateRoute;

  /// Unknown route callback.
  final RouteFactory? onUnknownRoute;

  /// Navigator observers.
  final List<NavigatorObserver> navigatorObservers;

  /// Transition builder.
  final TransitionBuilder? builder;

  /// App title.
  final String title;

  /// Light theme data.
  final AdaptiveThemeData? theme;

  /// Dark theme data.
  final AdaptiveThemeData? darkTheme;

  /// Active theme mode.
  final ThemeMode themeMode;

  /// Primary color swatch.
  final Color? color;

  /// App locale.
  final Locale? locale;

  /// Localization delegates.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// Locale resolution callback.
  final LocaleResolutionCallback? localeResolutionCallback;

  /// Supported locales.
  final Iterable<Locale> supportedLocales;

  /// Show debug banner.
  final bool debugShowCheckedModeBanner;

  /// Explicit platform mode.
  final AdaptivePlatform platform;

  /// Router configuration when using `AdaptiveApp.router`.
  final RouterConfig<Object>? routerConfig;

  @override
  Widget build(BuildContext context) {
    final AdaptiveThemeData effectiveTheme = theme ?? AdaptiveThemeData.light(platform: platform);
    final AdaptiveThemeData effectiveDarkTheme = darkTheme ?? AdaptiveThemeData.dark(platform: platform);

    Widget buildAppWithTheme(BuildContext ctx, Widget? child) {
      final Widget wrapped = AdaptiveTheme(
        data: Theme.of(ctx).brightness == Brightness.dark ? effectiveDarkTheme : effectiveTheme,
        child: child ?? const SizedBox.shrink(),
      );
      if (builder != null) {
        return builder!(ctx, wrapped);
      }
      return wrapped;
    }

    if (routerConfig != null) {
      return MaterialApp.router(
        routerConfig: routerConfig,
        title: title,
        color: color,
        theme: effectiveTheme.materialTheme,
        darkTheme: effectiveDarkTheme.materialTheme,
        themeMode: themeMode,
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        builder: buildAppWithTheme,
      );
    }

    return MaterialApp(
      navigatorKey: navigatorKey,
      home: home,
      routes: routes,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers: navigatorObservers,
      title: title,
      color: color,
      theme: effectiveTheme.materialTheme,
      darkTheme: effectiveDarkTheme.materialTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: localizationsDelegates,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      builder: buildAppWithTheme,
    );
  }
}
