import 'package:dio/dio.dart';

import '../enum/network/error_code.dart';
import '../enum/network/http_method.dart';
import '../response/response_message.dart';
import '../response/serializable.dart';
import '../types/funtions.dart';


abstract class IHttpHelper {
  Future<ResponseMessage<T>> request<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Serializable? body,
    dynamic dynamicBody,
    FormData? file,
    EHttpMethod method = EHttpMethod.get,
    DeserializeFunc<T>? deserializeFunc,
    DeserializeFuncForList<T>? deserializeFuncForList,
    CustomReturnResponse? customReturnResponse,
    bool disableErrorPopup = false,
    bool handleTimeOut = false,
    List<EErrorCode>? disableErrorPopupByCodeResults,
    Options? options,
  });

}
