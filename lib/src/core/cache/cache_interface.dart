import 'package:adote_um_pet/src/core/cache/cache_params.dart';

abstract class ICache {
  Future<bool> setData({required CacheParams params});
  Future<dynamic> getData(String key);
  Future<bool> removeData(String key);
  Future<bool> clean();
}