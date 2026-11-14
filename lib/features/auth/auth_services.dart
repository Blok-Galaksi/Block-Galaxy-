import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AuthService {
  static const _timeout = Duration(seconds: 15);

  static Uri get _apiBaseUri {
    final host = defaultTargetPlatform == TargetPlatform.android
        ? '192.168.1.21'
        : 'localhost';
    return Uri.parse('http://$host:8080/api/');
  }

  Future<String> register({
    required String email,
    required String username,
    required String password,
  }) {
    return _post('register', {
      'email': email,
      'name': username,
      'password': password,
    }, successMessage: 'Registrasi berhasil.');
  }

  Future<String> login({required String email, required String password}) {
    return _post('login', {
      'email': email,
      'password': password,
    }, successMessage: 'Login berhasil.');
  }

  Future<String> _post(
    String endpoint,
    Map<String, String> body, {
    required String successMessage,
  }) async {
    late final http.Response response;
    try {
      response = await http
          .post(
            _apiBaseUri.resolve(endpoint),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(_timeout);
    } on TimeoutException {
      if (kDebugMode) debugPrint('[Auth] POST /api/$endpoint timed out');
      throw const AuthException('Koneksi ke server timeout.');
    } on SocketException catch (error) {
      if (kDebugMode) {
        debugPrint('[Auth] POST /api/$endpoint connection failed: $error');
      }
      throw const AuthException(
        'Tidak dapat terhubung ke server. Pastikan server API berjalan.',
      );
    } on http.ClientException catch (error) {
      if (kDebugMode) {
        debugPrint('[Auth] POST /api/$endpoint request failed: $error');
      }
      throw const AuthException('Terjadi masalah saat menghubungi server.');
    }

    final message = _responseMessage(response.body);
    final isSuccessful =
        response.statusCode >= 200 && response.statusCode < 300;
    final resultMessage =
        message ??
        (isSuccessful
            ? successMessage
            : 'Permintaan gagal (HTTP ${response.statusCode}).');
    if (kDebugMode) {
      debugPrint(
        '[Auth] POST /api/$endpoint -> HTTP ${response.statusCode}: '
        '$resultMessage',
      );
    }

    if (!isSuccessful) throw AuthException(resultMessage);

    return resultMessage;
  }

  String? _responseMessage(String body) {
    if (body.isEmpty) return null;

    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        final message = decoded['message'] ?? decoded['error'];
        if (message is String && message.trim().isNotEmpty) {
          return message;
        }
      }
    } on FormatException {
      final text = body.trim();
      if (text.isNotEmpty) return text;
    }

    return null;
  }
}
