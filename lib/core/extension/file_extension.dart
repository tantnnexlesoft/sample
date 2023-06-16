import 'dart:io';
import 'dart:typed_data';

extension FileExtension on File {
  bool isValidSize(int maxSizeInMb) {
    final sizeInBytes = lengthSync();
    final sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb <= maxSizeInMb;
  }
}

extension Uint8ListExtension on Uint8List {
  bool isValidSize(int maxSizeInMb) {
    final sizeInMb = lengthInBytes / (1024 * 1024);
    return sizeInMb <= maxSizeInMb;
  }
}
