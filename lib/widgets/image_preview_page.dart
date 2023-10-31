import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImagePreviewPage extends StatefulWidget {
  final Uint8List imageData;

  const ImagePreviewPage({required this.imageData});

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _previousOffset = Offset.zero;
  Offset _focalPoint = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // title: Text('Image Preview'),
      ),
      body: GestureDetector(
        onScaleStart: (ScaleStartDetails details) {
          _previousScale = _scale;
          _previousOffset = _offset;
          _focalPoint = details.focalPoint;
          setState(() {});
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          _scale = _previousScale * details.scale;
          if (_scale <= 1.0) {
            _scale = 1.0;
            _offset = Offset.zero;
          } else {
            Offset delta = details.focalPoint - _focalPoint;
            _offset = Offset(
              _previousOffset.dx + delta.dx,
              _previousOffset.dy + delta.dy,
            );
          }
          setState(() {});
        },
        child: Center(
          child: Transform(
            transform: Matrix4.identity()
              ..translate(_offset.dx, _offset.dy)
              ..scale(_scale),
            alignment: FractionalOffset.center,
            child: Image.memory(
              widget.imageData,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
