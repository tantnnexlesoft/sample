import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import '../enum/network/client_error.dart';
import '../enum/network/error_code.dart';
import '../enum/network/http_method.dart';
import '../enum/network/log_level.dart';
import '../enum/network/platform_type.dart';
import '../local_storage/storage_helper.i.dart';
import '../response/api_response.dart';
import '../response/response_message.dart';
import '../response/serializable.dart';
import '../types/funtions.dart';
import 'http_helper.i.dart';



class HttpHelper implements IHttpHelper {
  late IStorageHelper _storageHelper;
  late Dio _dio;

  HttpHelper(IStorageHelper storageHelper) {
    _storageHelper = storageHelper;
    _dio = Dio();
    //Comment this to avoid crash on web
    // if (kDebugMode) {
    //   _dio.interceptors.add(
    //     PrettyDioLogger(
    //       requestBody: true,
    //       // requestHeader: true,
    //     ),
    //   );
    // }
    initializeInterceptors();
  }

  @override
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
  }) async {
    try {
      final response = await _dio.request(url,
          queryParameters: queryParameters,
          data: body?.toJson() ?? dynamicBody ?? file,
          options: options != null
              ? options.copyWith(method: method.value)
              : Options(method: method.value));
      return ResponseMessage(
          data: deserializeFunc != null
              ? deserializeFunc(response.data)
              : (deserializeFuncForList != null
                  ? deserializeFuncForList(response.data)
                  : response.data));
    } on DioError catch (e) {
      if (handleTimeOut &&
          (e.type == DioErrorType.connectTimeout ||
              e.type == DioErrorType.receiveTimeout ||
              e.type == DioErrorType.sendTimeout)) {
        throw DioError(
          requestOptions: e.requestOptions,
          type: e.type,
        );
      }
      developer.log("request url: $url exception: ", error: e);
      const showErrorMessage = false;
      final response = ResponseMessage<T>(
          isSuccess: false,
          codeResult: EErrorCode.unknown,
          errorMessage: showErrorMessage
              ? "${method.value} | $url | error: ${e.message}"
              : "strings_no_internet_content".tr());
      try {
        if (e.response == null) return response;
        developer.log("request data: ${e.response!.data}");
       //TODO: handle error

      } catch (ex2) {
        log("HttpHelper DioError exception: ${method.value} | $url | ${e.response?.statusCode} | error: ${ex2.toString()}",
            clientError: EClientError.errorApp);
        if (!disableErrorPopup) {
          //TODO:
        }
      }
      return response;
    } catch (ex1) {
      log("HttpHelper Other exception: ${method.value} | $url | error: ${ex1.toString()}",
          clientError: EClientError.errorApp);
      return ResponseMessage(isSuccess: false, codeResult: EErrorCode.unknown);
    }
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.baseUrl =
          "${"baseAPIUrl"}/";
      String body = "";
      if (options.data is! FormData) {
        body = options.data != null ? jsonEncode(options.data) : "";
      }

      options.headers = {
        ...options.headers,
        "Authorization":
            "Bearer ${"accessToken"}",
        // "X-IMI-SIGNATURE": digest.toString().toUpperCase(),
        // "X-IMI-REQINIT": requestInit,
        // "X-USER-ID": _storageHelper.getCurrentUser()?.id ?? "",
        // "X-APP-AGENT-ID": kConfigurationAppAgentId,
        // "X-APP-LANGUAGE-CODE": LocalizationService.currentLanguageCode,
        // "X-IMI-APP-VERSION": Utils.appVersion,
        // "X-IMI-APP-OS": Utils.appOs,
      };

      if (!kIsWeb) {
        options.headers.addAll({"Connection": "keep-alive"});
      }

      developer.log("${options.method} | ${options.path}");
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      // developer.log(
      //     "${response.statusCode} ${response.statusMessage} ${response.data}");
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      return handler.next(e); //continue
    }));
    // final performanceInterceptor = DioFirebasePerformanceInterceptor();
    // _dio.interceptors.add(performanceInterceptor);
  }

  String getOddRequestInit(String requestInit) {
    String oddRequestInit = "";
    for (var i = 0; i < requestInit.length; i++) {
      int? requestInt = int.tryParse(requestInit[i]);
      if (requestInt != null) {
        if (requestInt % 2 == 1) {
          oddRequestInit += requestInt.toString();
        }
      }
    }
    return oddRequestInit;
  }

  @override
  Future<void> log(
    String message, {
    ELogLevel logLevel = ELogLevel.basic,
    EClientError clientError = EClientError.errorFirestore,
  }) async {

    //TODO: log error



    // final appVersion = await Utils.getAppVersion();
    // final content =
    //     "app version: $appVersion | has googleplayservice: true | is rooted: false | time: ${DateTime.now().toString()} | content: $message";
    // developer.log(content);
    // final user = _storageHelper.getCurrentUser();
    // if (user == null) return;
    //
    // final serverLogLevel = user.logLevel ?? ELogLevel.basic;
    //
    // if (serverLogLevel.index < logLevel.index) return;

    // await request("api/v5/errors",
    //     body: ErrorLogRequest(
    //       content: content,
    //       clientErrorType: _getPlatformType() | clientError.value,
    //     ),
    //     disableErrorPopup: true,
    //     method: EHttpMethod.post);
  }

  int _getPlatformType() {
    if (kIsWeb) return EPlatformType.isWeb.value;
    if (Platform.isAndroid) return EPlatformType.isAndroid.value;
    if (Platform.isIOS) return EPlatformType.isIOS.value;
    if (Platform.isFuchsia) return EPlatformType.isFuchsia.value;
    if (Platform.isLinux) return EPlatformType.isLinux.value;
    if (Platform.isMacOS) return EPlatformType.isMacOS.value;
    if (Platform.isWindows) return EPlatformType.isWindows.value;
    return 0;
  }

}
