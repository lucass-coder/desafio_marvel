import 'package:flutter/material.dart';

class CharacterSearchFieldShimmer extends StatelessWidget {
  const CharacterSearchFieldShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 16, top: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 220, height: 16, color: Colors.black26),
          const SizedBox(height: 8),
          Container(width: double.infinity, height: 48, color: Colors.black26),
        ],
      ),
    );
  }
}
