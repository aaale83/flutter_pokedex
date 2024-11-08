import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomLoaderIndicator extends StatefulWidget {

  final Color color;
  final double strokeWidth;
  final double radius;

  const CustomLoaderIndicator({
    super.key,
    required this.color,
    this.strokeWidth = 4,
    this.radius = 10,
  });

  @override
  State<CustomLoaderIndicator> createState() => _CustomLoaderIndicatorState();
}

class _CustomLoaderIndicatorState extends State<CustomLoaderIndicator> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return SizedBox(width: widget.radius, height: widget.radius, child: CircularProgressIndicator(color: widget.color, strokeWidth: widget.strokeWidth));
    } else {
      return CupertinoActivityIndicator(color: widget.color, radius: widget.radius);
    }
  }
}