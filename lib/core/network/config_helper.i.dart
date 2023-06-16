import '../enum/network/http_method.dart';
import '../response/response_message.dart';
import '../response/serializable.dart';
import '../types/funtions.dart';

abstract class IConfigHelper {
  Future<ResponseMessage<T>> request<T>(String url,
      {Map<String, dynamic>? queryParameters,
      Serializable? body,
      dynamic dynamicBody,
      EHttpMethod method = EHttpMethod.get,
      DeserializeFunc<T>? deserializeFunc,
      bool? allowToDeserializeError});
}
