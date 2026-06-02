import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  static const String _baseUrl = 'http://10.0.2.2:3000/api'; 
  
  ApiClient({FlutterSecureStorage? storage, Dio? dio})
      : _storage = storage ?? const FlutterSecureStorage(),
        _dio = dio ??
            Dio(BaseOptions(
              baseUrl: _baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              contentType: 'application/json',
            )) {
    _initializeInterceptors();
  }

  Dio get client => _dio;

  void _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          final String? accessToken = await _storage.read(key: 'accessToken');
          if (accessToken != null && accessToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 401) {
            if (e.requestOptions.path.contains('/auth/refresh-token')) {
              await _clearTokens();
              return handler.reject(e);
            }

            final bool isRefreshed = await _refreshToken();
            
            if (isRefreshed) {
              final String? newAccessToken = await _storage.read(key: 'accessToken');
              
              final Options opts = Options(
                method: e.requestOptions.method,
                headers: <String, dynamic>{
                  ...e.requestOptions.headers,
                  'Authorization': 'Bearer $newAccessToken',
                },
              );

              try {
                final Response<dynamic> response = await _dio.request<dynamic>(
                  e.requestOptions.path,
                  options: opts,
                  data: e.requestOptions.data,
                  queryParameters: e.requestOptions.queryParameters,
                );
                return handler.resolve(response);
              } on DioException catch (retryError) {
                return handler.reject(retryError);
              }
            } else {
              await _clearTokens();
              return handler.reject(e);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<bool> _refreshToken() async {
    final String? refreshToken = await _storage.read(key: 'refreshToken');
    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      final Dio refreshDio = Dio(BaseOptions(baseUrl: _baseUrl));
      final Response<Map<String, dynamic>> response = await refreshDio.post<Map<String, dynamic>>(
        '/auth/refresh-token',
        data: <String, dynamic>{'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final dynamic data = response.data!['data']; 
        if (data != null && data['tokens'] != null) {
          final String? newAccessToken = data['tokens']['accessToken'] as String?;
          final String? newRefreshToken = data['tokens']['refreshToken'] as String?;

          if (newAccessToken != null && newRefreshToken != null) {
            await _storage.write(key: 'accessToken', value: newAccessToken);
            await _storage.write(key: 'refreshToken', value: newRefreshToken);
            return true;
          }
        }
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }
}
