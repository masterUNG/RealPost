import 'package:flutter/material.dart';

class BodySinglePrice extends StatelessWidget {
  const BodySinglePrice({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return Container(
        
        width: boxConstraints.maxWidth,
        height: boxConstraints.maxHeight,
        child: Text('single Price'),
      );
    });
  }
}
