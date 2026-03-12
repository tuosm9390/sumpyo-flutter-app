import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@riverpod
// ignore: deprecated_member_use_from_same_package
Dio dio(DioRef ref) {
  final dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);
  return dio;
}
