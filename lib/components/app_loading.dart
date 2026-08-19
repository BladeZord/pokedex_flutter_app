import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  final String? mensaje;

  const AppLoading({
    super.key,
    this.mensaje,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (mensaje != null) ...[
            const SizedBox(height: 12),
            Text(mensaje!),
          ],
        ],
      ),
    );
  }
}