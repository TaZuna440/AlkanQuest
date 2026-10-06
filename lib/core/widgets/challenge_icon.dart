import 'package:flutter/material.dart';

import 'image_ref_view.dart';

class ChallengeIcon extends StatelessWidget {
  final String? iconPath;
  final Color color;
  final double size;

  const ChallengeIcon({
    super.key,
    required this.iconPath,
    required this.color,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = iconPath != null && iconPath!.isNotEmpty;
    if (!hasImage) return _placeholder();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipOval(
        child: ImageRefView(
          reference: iconPath,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholderBuilder: _placeholder,
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(
        Icons.savings_outlined,
        color: color,
        size: size * 0.5,
      ),
    );
  }
}
