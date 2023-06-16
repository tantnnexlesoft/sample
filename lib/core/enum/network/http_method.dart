enum EHttpMethod { get, post, put, delete, patch }

extension HttpMethodExtension on EHttpMethod {
  String get value {
    switch (this) {
      case EHttpMethod.get:
        return "GET";
      case EHttpMethod.post:
        return "POST";
      case EHttpMethod.put:
        return "PUT";
      case EHttpMethod.delete:
        return "DELETE";
      case EHttpMethod.patch:
        return "PATCH";
      default:
        return "GET";
    }
  }
}
