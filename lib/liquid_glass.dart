import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class LiquidGlass extends StatefulWidget {
  const LiquidGlass({super.key});

  @override
  State<LiquidGlass> createState() => _LiquidGlassState();
}

class _LiquidGlassState extends State<LiquidGlass> {
  var _touchPosition = const Offset(0.5, 0.5);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Liquid Glass Shader')),
    body: ShaderBuilder(
      assetKey: 'assets/shaders/liquid_glass.frag',
      (BuildContext context, FragmentShader liquidglass, _) => GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final localPosition = box.globalToLocal(details.globalPosition);
            _touchPosition = Offset(
              localPosition.dx / box.size.width,
              localPosition.dy / box.size.height,
            );
          });
        },
        child: AnimatedSampler((ui.Image image, Size size, Canvas canvas) {
          liquidglass
            ..setFloat(0, size.width)
            ..setFloat(1, size.height)
            ..setFloat(2, _touchPosition.dx)
            ..setFloat(3, _touchPosition.dy)
            ..setImageSampler(0, image);
          canvas.drawRect(Offset.zero & size, Paint()..shader = liquidglass);
        }, child: _Image()),
      ),
    ),
  );
}

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.5,
      child: Image.asset('assets/images/dash.png', height: double.infinity),
    );
  }
}
