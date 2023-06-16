enum EPlatformType {
  isWeb,
  isAndroid,
  isIOS,
  isFuchsia,
  isLinux,
  isMacOS,
  isWindows,
}

extension PlatformTypeExtension on EPlatformType {
  int get value {
    switch (this) {
      case EPlatformType.isWeb:
        return 4;
      case EPlatformType.isAndroid:
        return 8;
      case EPlatformType.isIOS:
        return 16;
      case EPlatformType.isFuchsia:
        return 32;
      case EPlatformType.isLinux:
        return 64;
      case EPlatformType.isMacOS:
        return 128;
      case EPlatformType.isWindows:
        return 256;
      default:
        return 0;
    }
  }
}
