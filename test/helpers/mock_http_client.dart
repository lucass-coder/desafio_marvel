import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {}

final Uint8List kTransparentImage = Uint8List.fromList([
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

Future<void> mockHttpClient(WidgetTester tester, Widget widget) async {
  final mockHttpClient = MockHttpClient();
  final mockHttpClientRequest = MockHttpClientRequest();
  final mockHttpClientResponse = MockHttpClientResponse();
  final mockHttpHeaders = MockHttpHeaders();

  when(
    () => mockHttpClient.getUrl(any()),
  ).thenAnswer((_) async => mockHttpClientRequest);

  when(() => mockHttpClientRequest.headers).thenReturn(mockHttpHeaders);
  when(
    () => mockHttpClientRequest.close(),
  ).thenAnswer((_) async => mockHttpClientResponse);

  when(() => mockHttpClientResponse.statusCode).thenReturn(HttpStatus.ok);
  when(
    () => mockHttpClientResponse.contentLength,
  ).thenReturn(kTransparentImage.length);
  when(() => mockHttpClientResponse.headers).thenReturn(mockHttpHeaders);
  when(() => mockHttpClientResponse.listen(any())).thenAnswer((invocation) {
    final onData =
        invocation.positionalArguments[0] as void Function(List<int>);
    final onDone = invocation.namedArguments[#onDone] as void Function()?;
    final onError = invocation.namedArguments[#onError] as Function?;
    final cancelOnError = invocation.namedArguments[#cancelOnError] as bool?;

    final stream = Stream.value(kTransparentImage.toList());
    return stream.listen(
      onData,
      onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  });

  await HttpOverrides.runZoned(() async {
    await tester.pumpWidget(widget);
  }, createHttpClient: (_) => mockHttpClient);
}
