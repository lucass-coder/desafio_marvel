import 'dart:developer';

import 'package:flutter/services.dart';

class AnalyticsService {
  static const _platform = MethodChannel(
    'com.desafiomarvel.desafio_marvel/analytics',
  );

  static Future<void> logCustomEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _platform.invokeMethod<String>('logEvent', {
        'name': name,
        'parameters': parameters,
      });
      log('AnalyticsService: $result');
    } on PlatformException catch (e) {
      log("AnalyticsService: Falha ao registrar evento: '${e.message}'.");
    }
  }

  static Future<void> logScreenView(String screenName) async {
    try {
      await _platform.invokeMethod<void>('logEvent', {
        'name': 'screen_view',
        'parameters': {'screen_name': screenName},
      });
      log("AnalyticsService: Tela '$screenName' registrada.");
    } on PlatformException catch (e) {
      log("AnalyticsService: Falha ao registrar tela: '${e.message}'.");
    }
  }
}
