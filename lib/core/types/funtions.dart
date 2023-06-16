

typedef DeserializeFunc<T> = T Function(Map<String, dynamic> json);
typedef DeserializeFuncForList<T> = T Function(List<dynamic> json);
typedef CustomReturnResponse<T> = T Function(Map<String, dynamic> json);


