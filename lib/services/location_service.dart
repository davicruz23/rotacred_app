import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../env/environment.dart';

class LocationService {
  final Dio dio;
  final String baseUrl = Environment.apiBaseUrl;

  LocationService()
    : dio = Dio(
        BaseOptions(
          baseUrl: Environment.apiBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  StreamSubscription<Position>? _positionSubscription;

  Future<void> _checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception(
        'O GPS está desativado. Ative a localização do aparelho.',
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Permissão de localização negada.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'A permissão de localização foi negada permanentemente. '
        'Libere a permissão nas configurações do aplicativo.',
      );
    }
  }

  Future<Position> getCurrentLocation() async {
    await _checkPermission();

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<void> sendLocation({
    required int userId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      debugPrint(
        'Enviando localização: '
        'userId=$userId, latitude=$latitude, longitude=$longitude',
      );

      final response = await dio.post(
        '/locations',
        data: {'userId': userId, 'latitude': latitude, 'longitude': longitude},
      );

      debugPrint(
        'Localização enviada com sucesso. '
        'Status: ${response.statusCode}',
      );
    } on DioException catch (error) {
      final responseData = error.response?.data;

      String message;

      if (responseData is Map<String, dynamic>) {
        message =
            responseData['message']?.toString() ??
            'Erro ao enviar localização para o servidor.';
      } else if (responseData is String && responseData.isNotEmpty) {
        message = responseData;
      } else {
        message =
            error.message ?? 'Erro ao enviar localização para o servidor.';
      }

      debugPrint(
        'Erro no endpoint de localização: '
        'status=${error.response?.statusCode}, '
        'resposta=$responseData',
      );

      throw Exception(message);
    }
  }

  Future<void> sendCurrentLocation({required int userId}) async {
    final position = await getCurrentLocation();

    await sendLocation(
      userId: userId,
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  Future<void> startTracking({
    required int userId,
    int distanceFilter = 20,
    void Function(Position position)? onLocationUpdated,
    void Function(Object error)? onError,
  }) async {
    await _checkPermission();

    await stopTracking();

    final LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilter,
        intervalDuration: const Duration(seconds: 5),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationTitle: 'RotaCred em execução',
          notificationText:
              'Sua localização está sendo registrada durante o expediente.',
          enableWakeLock: true,
        ),
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilter,
      );
    }

    _positionSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (position) async {
            try {
              await sendLocation(
                userId: userId,
                latitude: position.latitude,
                longitude: position.longitude,
              );

              debugPrint(
                'Localização enviada: '
                '${position.latitude}, ${position.longitude}',
              );

              onLocationUpdated?.call(position);
            } catch (error) {
              debugPrint('Erro ao enviar localização: $error');
              onError?.call(error);
            }
          },
          onError: (Object error) {
            debugPrint('Erro no stream de localização: $error');
            onError?.call(error);
          },
        );
  }

  Future<void> stopTracking() async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;
  }

  bool get isTracking => _positionSubscription != null;

  Future<void> dispose() async {
    await stopTracking();
  }
}
