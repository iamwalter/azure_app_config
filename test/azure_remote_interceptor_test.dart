import 'package:azure_app_config/azure_remote_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockRequestOptions extends Mock implements RequestOptions {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

void main() {
  test(
    'onRequest() should call handler.next()',
    () async {
      final interceptor = AzureRemoteInterceptor(
        credential: "testCredential",
        secret: "testSecrettt",
      );

      final options = MockRequestOptions();
      final handler = MockRequestInterceptorHandler();

      when(() => options.uri)
          .thenReturn(Uri(query: "any", path: "any", host: "any"));
      when(() => options.path).thenReturn("any");
      when(() => options.method).thenReturn("GET");
      when(() => options.headers).thenReturn({});

      interceptor.onRequest(options, handler);

      verify(() => handler.next(options)).called(1);
    },
  );
}
