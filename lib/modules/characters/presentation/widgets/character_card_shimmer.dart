import 'package:flutter/material.dart';

class CharacterCardShimmer extends StatelessWidget {
  final double width;
  final double height;

  const CharacterCardShimmer({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
