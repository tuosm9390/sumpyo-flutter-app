import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:sumpyo_app/core/network/dio_client.dart';

void main() {
  test('dio provider returns a Dio instance', () {
    final container = ProviderContainer();
    final dio = container.read(dioProvider);

    expect(dio, isA<Dio>());
    expect(dio.options.connectTimeout, const Duration(seconds: 5));
  });
}
