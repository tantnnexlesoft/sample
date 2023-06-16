
import '../enum/network/error_code.dart';

class ResponseMessage<T> {
  ResponseMessage({
    this.isSuccess = true,
    this.codeResult = EErrorCode.ok,
    this.errorMessage,
    this.data,
  });

  bool isSuccess;
  EErrorCode codeResult;
  String? errorMessage;
  T? data;
}
