import 'dart:io';

class NetworkException extends TlsException {
  final String mensaje;
  NetworkException([this.mensaje = 'Sin conexión a internet']);

  @override
  String toString() => mensaje;
}

class ApiException {
  final String mensaje;
  final int? codigoEstado;

  ApiException(this.mensaje, {this.codigoEstado});

  @override
  String toString() => 'Error $codigoEstado: $mensaje';
}