import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sun_time_service.g.dart';

class SunTimeData {
  final DateTime sunrise;
  final DateTime sunset;

  SunTimeData({required this.sunrise, required this.sunset});
}

@Riverpod(keepAlive: true)
class SunTimeNotifier extends _$SunTimeNotifier {
  @override
  FutureOr<SunTimeData?> build() async {
    return _fetchSunTimes();
  }

  Future<SunTimeData?> _fetchSunTimes() async {
    try {
      // 1. 위치 권한 확인 및 요청
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }

      if (permission == LocationPermission.deniedForever) return null;

      // 2. 현재 위치 가져오기
      Position position = await Geolocator.getCurrentPosition();

      // 3. API 호출 (Sunrise-Sunset.org)
      final dio = Dio();
      final response = await dio.get(
        'https://api.sunrise-sunset.org/json',
        queryParameters: {
          'lat': position.latitude,
          'lng': position.longitude,
          'formatted': 0, // ISO 8601 형식 사용
        },
      );

      if (response.statusCode == 200 && response.data['status'] == 'OK') {
        final results = response.data['results'];
        // API는 UTC 시간을 주므로 .toLocal()로 현지 시간 변환
        final sunrise = DateTime.parse(results['sunrise']).toLocal();
        final sunset = DateTime.parse(results['sunset']).toLocal();

        return SunTimeData(sunrise: sunrise, sunset: sunset);
      }
    } catch (e) {
      // 에러 발생 시 null 반환 (기본값 사용 유도)
    }
    return null;
  }
}
