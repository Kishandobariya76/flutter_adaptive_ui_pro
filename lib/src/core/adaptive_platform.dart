/// Enum representing the supported UI design systems and adaptive modes.
enum AdaptivePlatform {
  /// Automatically resolves to Cupertino on iOS, and Material Design on all other platforms.
  adaptive,

  /// Forces Google Material Design rendering.
  material,

  /// Forces Apple Cupertino (Human Interface Guidelines) rendering.
  cupertino,
}

/// Convenience extensions on [AdaptivePlatform].
extension AdaptivePlatformExtension on AdaptivePlatform {
  /// Returns `true` if this platform is [AdaptivePlatform.material].
  bool get isMaterial => this == AdaptivePlatform.material;

  /// Returns `true` if this platform is [AdaptivePlatform.cupertino].
  bool get isCupertino => this == AdaptivePlatform.cupertino;

  /// Returns `true` if this platform is [AdaptivePlatform.adaptive].
  bool get isAdaptive => this == AdaptivePlatform.adaptive;
}
