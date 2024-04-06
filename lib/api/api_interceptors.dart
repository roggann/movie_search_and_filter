
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ApiInterceptors extends InterceptorsWrapper {
  final ProviderRef ref;

  ApiInterceptors(this.ref);

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }
}
