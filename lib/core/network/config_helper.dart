import 'package:dio/dio.dart';
import '../enum/network/error_code.dart';
import '../enum/network/http_method.dart';
import '../response/response_message.dart';
import '../response/serializable.dart';
import '../types/funtions.dart';
import 'config_helper.i.dart';


class ConfigHelper implements IConfigHelper {
  late Dio _dio;

  ConfigHelper() {
    _dio = Dio();
  }

  @override
  Future<ResponseMessage<T>> request<T>(String url,
      {Map<String, dynamic>? queryParameters,
      Serializable? body,
      dynamic dynamicBody,
      EHttpMethod method = EHttpMethod.get,
      DeserializeFunc<T>? deserializeFunc,
      bool? allowToDeserializeError}) async {
    try {
      final response = await _dio.request(
        url,
        queryParameters: queryParameters,
        data: body?.toJson() ?? dynamicBody,
        options: Options(method: method.value),
      );
      return ResponseMessage(
          data:
              deserializeFunc != null ? deserializeFunc(response.data) : null);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseMessage(
            isSuccess: false,
            codeResult: EErrorCode.unknown,
            errorMessage: "App error.");
      }

      final response = ResponseMessage<T>(
          isSuccess: false,
          codeResult: EErrorCode.unknown,
          errorMessage: "Unknown error.");

      if (allowToDeserializeError == true && deserializeFunc != null) {
        response.data = deserializeFunc(e.response!.data);
      }

      return response;
    }
  }
}
