
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_and_filter/utils/api_interceptors.dart';


final dioProvider = Provider((ref) {
  // HTTP networking client
  Dio _dio = Dio();
  if (kDebugMode) {
    _dio.interceptors.add(LogInterceptor(request: true, responseBody: true, responseHeader: true));
  }
  _dio.interceptors.add(ApiInterceptors(ref));
  return _dio;
});

