import 'package:shared_preferences/shared_preferences.dart';

import 'storage_helper.i.dart';


class StorageHelper implements IStorageHelper {
  final SharedPreferences _sharedPreferences;


  StorageHelper(SharedPreferences sharedPreferencesFuture)
      : _sharedPreferences = sharedPreferencesFuture;

}
