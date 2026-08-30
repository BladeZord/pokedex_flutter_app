import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  // Declaracion de los bindings
  final VoidCallback onTap;
  final Widget child;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Icon? icon;

  // constructor
  const CardButton({
    super.key,
    required this.onTap,
    required this.child,
    this.elevation = 2.0,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.color,
    this.icon
  });

  // Construccion del componente 
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: icon!,
                ),
                const SizedBox(height: 8.0),
              ],
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}