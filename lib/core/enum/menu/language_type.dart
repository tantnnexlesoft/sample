import 'package:easy_localization/easy_localization.dart';

enum ELanguageOption {
  en,
  fr
}

extension ELanguageOptionExtensions on ELanguageOption {
  String get title {
    switch (this) {
      case ELanguageOption.en:
        return "strings_language_english".tr();
      case ELanguageOption.fr:
        return "strings_language_french".tr();
    }
  }

  static ELanguageOption eLanguageOption (String langeCode) {
    switch (langeCode) {
      case "en":
        return ELanguageOption.en;
      case "fr":
        return ELanguageOption.fr;
      default:
        return ELanguageOption.en;
    }
  }
}