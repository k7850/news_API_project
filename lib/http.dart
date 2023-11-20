import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// http 통신
final dio = Dio(
  BaseOptions(
    baseUrl: "https://openapi.naver.com/v1/search/news?query=",
    contentType: "application/json; charset=utf-8",
  ),
);
