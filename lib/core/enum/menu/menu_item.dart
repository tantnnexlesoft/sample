import '../../constant/resource/res.dart';

enum EMenuItem {
  home,
  none
}

extension EMenuItemExt on EMenuItem {
  String get title {
    switch (this) {
      case EMenuItem.home:
        return "Home";
      case EMenuItem.none:
        return "";
    }
  }

  String get icon {
    switch (this) {
      case EMenuItem.home:
        return Res.ic_home;
      case EMenuItem.none:
        return "";
    }
  }

}
