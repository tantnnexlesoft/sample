enum EClientError { errorFirestore, errorInAppPurchase, errorApp }

extension ClientErrorExtension on EClientError {
  int get value {
    switch (this) {
      case EClientError.errorFirestore:
        return 512;
      case EClientError.errorInAppPurchase:
        return 1024;
      case EClientError.errorApp:
        return 2048;
      default:
        return 0;
    }
  }
}
