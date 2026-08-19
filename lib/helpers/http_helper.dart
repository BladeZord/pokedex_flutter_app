import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_flutter_app/exception/api_exception.dart';

class HttpHelper {
  /// Verifica si hay conexión a Internet adaptado a Móvil y Web
  static Future<bool> hasInternetConnection() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity()
        .checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    // Si la app está corriendo en Web, el navegador se encarga de la conexión
    // (no se puede usar InternetAddress.lookup en Web)
    if (kIsWeb) {
      return true;
    }

    // Si es Android/iOS/Desktop, ejecutamos el lookup normalmente
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Petición GET genérica
  static Future<http.Response> get(String url) async {
    if (!await hasInternetConnection()) {
      throw NetworkException('Comprueba tu conexión a Internet.');
    }

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      return _processResponse(response);
    } on SocketException {
      throw NetworkException('Error de conexión con el servidor.');
    } catch (e) {
      // Capturamos cualquier otro error inesperado en Web
      if (e is NetworkException || e is ApiException) rethrow;
      throw NetworkException('Error al conectar con el servidor.');
    }
  }

  static http.Response _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    }

    switch (response.statusCode) {
      case 400:
        throw ApiException('Petición incorrecta', codigoEstado: 400);
      case 401:
      case 403:
        throw ApiException(
          'Acceso no autorizado',
          codigoEstado: response.statusCode,
        );
      case 404:
        throw ApiException('Recurso no encontrado', codigoEstado: 404);
      case 500:
      default:
        throw ApiException(
          'Error en el servidor',
          codigoEstado: response.statusCode,
        );
    }
  }
}
